 //
//  ZTDataCenter.m
//  ZhongTuan
//
//  Created by anddward on 15/1/9.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//
#import <objc/runtime.h>
#import "ZTDataCenter.h"
#import "User.h"
#import "AppDelegate.h"
#import "TeamBuyProduct.h"
#import "TeMaiProduct.h"
#import "Activities.h"
#import "Address.h"
#import "orderInfo.h"
#import <sqlite3.h>

@interface ZTDataCenter(){
    NSMutableDictionary *_cache;
    sqlite3 *db;
}
@end

@implementation ZTDataCenter

#pragma mark - initialization
//    线程安全下单例
+(id)sharedInstance{
    static id instances;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instances = [[ZTDataCenter alloc] init];
    });
    return instances;
}

-(sqlite3 *)dataBase{
    return db;
}

-(id)init{
    if (self = [super init]) {
    //dictionary cache
        _cache = [NSMutableDictionary new];
        
        // initDataBase
        int success = sqlite3_open_v2(getFileName(), &db, SQLITE_OPEN_READONLY, NULL);
        if (NULL == db) {
            alertShow(@"not enough memery");
        }
        if (!success == SQLITE_OK) {
            alertShow([NSString stringWithUTF8String:sqlite3_errmsg(db)]);
        }
    }
    return self;
}

-(void)saveToDisk{
    NSFileManager *fmg = [NSFileManager defaultManager];
    NSURL *cacheDirectory = [fmg URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    NSURL *cacheFile = [cacheDirectory URLByAppendingPathComponent:@"ZTCache"];
    [NSKeyedArchiver archiveRootObject:_cache toFile:[cacheFile path]];
}

-(void)initFromDisk{
    NSFileManager *fmg = [NSFileManager defaultManager];
    NSURL *cacheDirectory = [fmg URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    NSURL *cacheFile = [cacheDirectory URLByAppendingPathComponent:@"ZTCache"];
    NSMutableDictionary *storeDic = [NSKeyedUnarchiver unarchiveObjectWithFile:[cacheFile path]];
    // debug
    [self getCityListByProvinceId:1];
    if (nil != storeDic) {
        _cache = storeDic;
    }
}

#pragma mark - data save

//**** user ****/
-(void)loginUser:(User*)user{
NSLog(@"userr%@userr",user);
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setObject:user.acctoken forKey:UD_KEY_CURRENT_TOKEN];
    [def setObject:user.mobile forKey:UD_KEY_CURRENT_PHONE];
    NSMutableDictionary *userDic = _cache[CKEY_USER];
    NSLog(@"userdic%@",userDic);
    if (nil == userDic) {
        userDic = [NSMutableDictionary new];
    }
    NSLog(@"denglu%@denglu",user);
    [userDic setObject:user forKey:user.acctoken];
    NSLog(@"dic%@",userDic);
    _cache[CKEY_USER] = userDic;
    NSLog(@"ckeyey%@",_cache[CKEY_USER]);
}

/**** address ****/
-(void)saveUserAddresses:(NSArray *)address{
    NSMutableDictionary *addressDic = _cache[CKEY_ADDRESS];
    if (nil == addressDic) {
        addressDic = [NSMutableDictionary new];
    }
    for (Address *add in address) {
        [addressDic setObject:add forKey:add.uaid];
    }
    _cache[CKEY_ADDRESS] = addressDic;
}

-(void)saveUserAddress:(Address *)address{
    NSMutableDictionary *addressDic = _cache[CKEY_ADDRESS];
    if (nil == addressDic) {
        addressDic = [NSMutableDictionary new];
    }
    [addressDic setObject:address forKey:address.uaid];
    _cache[CKEY_ADDRESS] = addressDic;
}

/**** products ****/
-(void)saveProducts:(NSArray *)products forType:(NSString*)type{
    NSMutableDictionary *productDic = _cache[type];
    if (nil == productDic) {
        productDic = [NSMutableDictionary new];
    }
    for (id p in products) {
    //把每个产品保存在字典中
        [productDic setObject:p forKey:[self getProductKey:p]];
    }
    _cache[type] = productDic;
}

-(void)saveProduct:(id)product forType:(NSString*)type{
    NSMutableDictionary *productDic = _cache[type];
    if (nil == productDic) {
        productDic = [NSMutableDictionary new];
    }
    
    [productDic setObject:product forKey:[self getProductKey:product]];
    _cache[type] = productDic;
}

#pragma mark - data search
/**** user ****/
-(User*)getUserWithToken:(NSString*)token{
    NSDictionary *userDic = _cache[CKEY_USER];
    NSLog(@"_cache%@",_cache[CKEY_USER]);
     NSLog(@"userdic%@ aa",userDic);
     NSLog(@"usertoken%@",userDic[token]);
    return userDic[token];
}

-(User*)getCurrentUser{
    NSUserDefaults* udf = [NSUserDefaults standardUserDefaults];
    NSString* token = [udf objectForKey:UD_KEY_CURRENT_TOKEN];
   NSLog(@"tokentoken%@",token);
    return [self getUserWithToken:token];
}

/**** address ****/
-(NSArray *)getUserAddresses{
    NSDictionary *addressDic = _cache[CKEY_ADDRESS];
    return addressDic.allValues;
}

-(Address*)getDefaultAddress{
    NSArray *addresses = [self getUserAddresses];
    for (Address* add in addresses) {
        if ([add.isDef isEqualToNumber:@1]) {
            return add;
        }
    }
    return nil;
}

/**** product ****/
-(id)getProductWithPid:(NSNumber *)pid forType:(NSString*)type{
    NSDictionary *productDic = _cache[type];
    return productDic[pid];
}

-(NSArray*)getProductsFromPage:(NSInteger)page
                      pageSize:(NSInteger)size
                        offSet:(NSInteger)offset
                         count:(NSInteger)count
                       orderBy:(NSString*)att
                          asic:(BOOL)asic
                          type:(NSString*)type
{
    NSArray *products = [[_cache objectForKey:type] allValues];
      NSArray *sorteAry = [products sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        /// TODO: add other data type compare eg:date,time

        NSNumber *v1 = [obj1 valueForKey:att];
        NSNumber *v2 = [obj2 valueForKey:att];
        if (v1 < v2) {
            return asic? NSOrderedAscending : NSOrderedDescending;
        }else{
            return asic? NSOrderedDescending : NSOrderedAscending;
        }
    }];
    NSInteger start = (page-1)*size+offset;
  
  NSInteger end = (count == -1 || count > sorteAry.count) ? sorteAry.count :count;
   
            return [sorteAry objectsAtIndexes:[[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(start, end)]];
}
/***** tmorder *****/
//gettmorderinfo
-(NSArray*)gettmordInfo:(NSString*)ordno forType:(NSString*)type{
    NSDictionary *tmorderDic = _cache[type];
    return tmorderDic[ordno];
}

/***** Area ******/
// province
-(NSArray*)getProvinceList{
    NSMutableDictionary *pDic = _cache[CKEY_PROVINCE];
    if (pDic == nil) {
        _cache[CKEY_PROVINCE] = [NSMutableDictionary new];
        [self loadProvinceFromDB];
        return [self getProvinceList];
    }
   
        return [self getsortformdic:pDic];
                 //return [pDic allValues];
}
-(NSString*)getProvinceNameByPid:(NSInteger)pid{
    NSMutableDictionary *pDic = _cache[CKEY_PROVINCE];
    if (pDic == nil) {
        _cache[CKEY_PROVINCE] = [NSMutableDictionary new];
        [self loadProvinceFromDB];
       
    }
        Province *OneProvince=[_cache[CKEY_PROVINCE] objectForKey:[NSNumber numberWithInteger:pid]];
    
    return OneProvince.ProName;

}
-(NSString*)getCityNameByCid:(NSInteger)cid
{
    
    if (NULL == db)return nil;
    const char *sql = "select * from T_City where _id = ? ";
    sqlite3_stmt *stmt;
     City *c = [City new];
         if (sqlite3_prepare_v2(db, sql, -1, &stmt, NULL) == SQLITE_OK) {
        sqlite3_bind_int64(stmt, 1, cid);
        while (SQLITE_ROW == sqlite3_step(stmt)) {
           
            c.CityName = [NSString stringWithUTF8String:(const char*)sqlite3_column_text(stmt, 0)];
        }
         }
         NSLog(@"11111111111111%@",c.CityName);
    return  c.CityName;
}



-(NSString*)getAreaNameByAid:(NSInteger)aid {
   
    if (NULL == db) return nil;
    const char *sql = "select * from T_Zone where _id = ? ";
    sqlite3_stmt *stmt;
    Area *a = [Area new];
    if (sqlite3_prepare_v2(db, sql, -1, &stmt, NULL) == SQLITE_OK) {
        sqlite3_bind_int64(stmt, 1, aid);
        while (SQLITE_ROW == sqlite3_step(stmt)) {
            
            
            a.ZoneName = [NSString stringWithUTF8String:(const char*)sqlite3_column_text(stmt, 1)];
            
        }
    }
    
    return a.ZoneName;

}




// city
-(NSArray*)getCityListByProvinceId:(NSInteger)pid{
    NSMutableDictionary *cDic = _cache[CKEY_CITY];
    if (cDic == nil) {
        _cache[CKEY_CITY] = [NSMutableDictionary new];
    }
    NSArray *cities = [_cache[CKEY_CITY] objectForKey:[[NSNumber numberWithInteger:pid] stringValue]];
    if (nil == cities) {
        [self loadCityFromDB:pid];
        return [self getCityListByProvinceId:pid];
    }
    return cities;
}

// area
-(NSArray*)getAreaListByCityId:(NSInteger)cid{
    NSMutableDictionary *aDic = _cache[CKEY_AREA];
    if (aDic == nil) {
    NSLog(@"11111111");
        _cache[CKEY_AREA] = [NSMutableDictionary new];
    }
    NSArray *areas = [_cache[CKEY_AREA] objectForKey:[[NSNumber numberWithInteger:cid] stringValue]];
    if (nil == areas) {
    
    NSLog(@"222222");
 //   NSLog(@"%d",cid);
        [self loadAreaFromDB:cid];
        return [self getAreaListByCityId:cid];
    }
    return areas;
}

#pragma mark - data clear

-(void)logoutUser:(UIViewController*)controller{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *token = [def objectForKey:UD_KEY_CURRENT_TOKEN];
    [_cache removeObjectForKey:CKEY_USER];
    //[[_cache objectForKey:CKEY_USER] removeObjectForKey:token];
    NSLog(@"qweqweqweqwe%@  %@",token,_cache[CKEY_USER]);
    [def removeObjectForKey:UD_KEY_CURRENT_TOKEN];
    
  
    //[controller.navigationController.presentingViewController dismissViewControllerAnimated:NO completion:nil];
}

-(void)clearAllProductsForType:(NSString*)type{
    [_cache[type] removeAllObjects];
}

-(id)getProductKey:(id)product{
    if ([product isKindOfClass:[TeamBuyProduct class]]) {
        return ((TeamBuyProduct*)product).mid;
    }
    if ([product isKindOfClass:[TeMaiProduct class]]){
        return ((TeMaiProduct*)product).tmid;
    }
    if ([product isKindOfClass:[Activities class]]) {
        return ((Activities*)product).tgno;
    }
    @throw [NSException exceptionWithName:@"ProductTypeError" reason:@"not support product Type" userInfo:nil];
}

#pragma mark - helper

-(void)loadProvinceFromDB{
    NSMutableDictionary *pDic = _cache[CKEY_PROVINCE];
    if (NULL == db) return;
    const char *sql = "select * from T_Province order by _id asc";
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(db, sql, -1, &stmt, NULL) == SQLITE_OK) {
        while (SQLITE_ROW == sqlite3_step(stmt)) {
        
            Province *p = [Province new];
            p.ProName = [NSString stringWithUTF8String:(const char*)sqlite3_column_text(stmt, 0)];
            p._id = [NSNumber numberWithInt:sqlite3_column_int(stmt, 1)];
            p.ProRemark = [NSString stringWithUTF8String:(const char*)sqlite3_column_text(stmt, 2)];
            p.SimP_Pro_Name = [NSString stringWithUTF8String:(const char*)sqlite3_column_text(stmt, 3)];
            p._code = [NSString stringWithUTF8String:(const char*)sqlite3_column_text(stmt, 4)];
            NSLog(@"%@---- %@",p._id,p.ProName);
            [pDic setObject:p forKey:p._id];}
            
//            [pDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
//                NSLog(@"key:%@---value:%@",key,obj);
//            }];
        
            
    }
        }
-(NSArray*)getsortformdic:(NSDictionary*)pDic{
    NSArray *keys = [pDic allKeys];
    
    NSComparator cmptr = ^(id obj1, id obj2){
        if ([obj1 shortValue] > [obj2 shortValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        if ([obj1 shortValue] < [obj2 shortValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    };
    NSArray *sortKeys = [keys sortedArrayUsingComparator:cmptr];
    NSLog(@"%@",sortKeys);
    NSMutableArray*arr=[NSMutableArray array];
    int i=0;
    for (NSString *categoryId in sortKeys) {
        arr[i]=[pDic objectForKey:categoryId];
        i++;
    }
    return arr;
   
}




-(void)loadCityFromDB:(NSInteger)pid{
    NSMutableDictionary *cDic = _cache[CKEY_CITY];
    NSMutableArray *cArray = [NSMutableArray new];
    if (NULL == db) return;
    const char *sql = "select * from T_City where ProID = ? order by _id asc";
    sqlite3_stmt *stmt;

    if (sqlite3_prepare_v2(db, sql, -1, &stmt, NULL) == SQLITE_OK) {
        sqlite3_bind_int64(stmt, 1, pid);
        while (SQLITE_ROW == sqlite3_step(stmt)) {
            City *c = [City new];
            c.CityName = [NSString stringWithUTF8String:(const char*)sqlite3_column_text(stmt, 0)];
            c.ProID = [NSNumber numberWithInt:sqlite3_column_int(stmt, 1)];
            c._id = [NSNumber numberWithInt:sqlite3_column_int(stmt, 2)];
            c.CityCode = [NSNumber numberWithInt:sqlite3_column_int(stmt, 3)];
            c.Sim_Cit_Name = [NSString stringWithUTF8String:(const char*)sqlite3_column_text(stmt, 4)];
            c._code = [NSString stringWithUTF8String:(const char*)sqlite3_column_text(stmt, 5)];
            [cArray addObject:c];
        }
        NSLog(@"%@",cArray);
    }
    [cDic setObject:cArray forKey:[[NSNumber numberWithInteger:pid] stringValue]];
}

-(void)loadAreaFromDB:(NSInteger)cid{
    NSMutableDictionary *aDic = _cache[CKEY_AREA];
    NSMutableArray *aArray = [NSMutableArray new];
    if (NULL == db) return;
    const char *sql = "select * from T_Zone where CityID = ? order by _id asc";
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(db, sql, -1, &stmt, NULL) == SQLITE_OK) {
        sqlite3_bind_int64(stmt, 1, cid);
        while (SQLITE_ROW == sqlite3_step(stmt)) {
            Area *a = [Area new];
            a._id = [NSNumber numberWithInt:sqlite3_column_int(stmt, 0)];
            a.ZoneName = [NSString stringWithUTF8String:(const char*)sqlite3_column_text(stmt, 1)];
            a.CityID = [NSNumber numberWithInt:sqlite3_column_int(stmt, 2)];
            [aArray addObject:a];
        }
    }
   
    [aDic setObject:aArray forKey:[[NSNumber numberWithInteger:cid] stringValue]];
    }

@end
