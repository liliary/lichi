//
//  ZTDataCenter.h
//  ZhongTuan
//
//  Created by anddward on 15/1/9.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Province.h"
#import "City.h"
#import "Area.h"
#import "Sendid.h"
@class User;
@class TeamBuyProduct;
@class TMProduct;
@class Address;
@class orderInfo;
@interface ZTDataCenter : NSObject{
    
}

//**** singleton ****/
+(id)sharedInstance;
-(void)initFromDisk;
-(void)saveToDisk;
-(sqlite3*)dataBase;

//**** data insert ****/
// User
-(void)loginUser:(User*)user;
// address
-(void)saveUserAddresses:(NSArray*)address;
-(void)saveUserAddress:(Address*)address;
// products
-(void)saveProducts:(NSArray*)products forType:(NSString*)type;
-(void)saveProduct:(id)Product forType:(NSString*)type;
// tmorder
//-(void)submitTmorder:(NSArray*)tmorder;


//**** data search ****/
// user
-(User*)getUserWithToken:(NSString*)token;
-(User*)getCurrentUser;
// address
-(NSArray*)getUserAddresses;
-(Address*)getDefaultAddress;
-(NSArray*)getProvinceList;
-(NSArray*)getCityListByProvinceId:(NSInteger)pid;
-(NSArray*)getAreaListByCityId:(NSInteger)cid;
//********  address data show****************
-(NSString*)getProvinceNameByPid:(NSInteger)pid;
-(NSString*)getCityNameByCid:(NSInteger)cid ;
-(NSString*)getAreaNameByAid:(NSInteger)aid ;


// products
-(id)getProductWithPid:(NSNumber*)pid forType:(NSString*)type;
-(NSArray*)getProductsFromPage:(NSInteger)page pageSize:(NSInteger)size offSet:(NSInteger)offset count:(NSInteger)count orderBy:(NSString*)att asic:(BOOL)asic type:(NSString*)type;
// tmorder
-(NSArray*)gettmordInfo:(NSString*)ordno forType:(NSString*)type;

//**** data clean ****/
-(void)logoutUser:(UIViewController*)controller;
-(void)clearAllProductsForType:(NSString*)type;
@end
