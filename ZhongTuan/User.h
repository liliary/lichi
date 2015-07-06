//
//  User.h
//  ZhongTuan
//
//  Created by anddward on 14-11-6.
//  Copyright (c) 2014年 TeamBuy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Model.h"


@interface User : Model

@property (nonatomic, retain) NSNumber * uid;       // 用户 id
@property (nonatomic, retain) NSString * username;  // 用户名
// TODO: no password saved
@property (nonatomic, retain) NSString * userpwd;   // 用户密码
@property (nonatomic, retain) NSString * nickname;  // 用户昵称
@property (nonatomic, retain) NSString * mobile;    // 用户手机号码
@property (nonatomic, retain) NSString * email;     // 用户邮箱
@property (nonatomic, retain) NSNumber * sex;       // 用户性别
@property (nonatomic, retain) NSString * birthday;  // 用户生日
@property (nonatomic, retain) NSString * signate;   // 用户签名
@property (nonatomic, retain) NSString * handpwd;   // 用户手势密码
@property (nonatomic, retain) NSString * regdate;   // 用户注册日期
@property (nonatomic, retain) NSString * regip;     // 用户注册 ip
@property (nonatomic, retain) NSString * lastdate;  // 上次登录时间
@property (nonatomic, retain) NSString * lastip;    // 最近登录 ip
@property (nonatomic, retain) NSString * userlb;    //
@property (nonatomic, retain) NSString * acctoken;  // 用户 token
@property(nonatomic,retain)NSString*avatar;        //用户头像

@end
