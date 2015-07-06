//
//  Constant.h
//  ZhongTuan
//
//  Created by anddward on 14-11-6.
//  Copyright (c) 2014年 TeamBuy. All rights reserved.
//

#ifndef ZhongTuan_Constant_h
#define ZhongTuan_Constant_h

#pragma mark - UTILITIES *******************************
#define MD5_LEN 32

#pragma mark - FLAGS *******************************
#define FLAG_DEBUG NO


#pragma mark - FILES(F) *******************************
/* 引导页面设置(GUI) */
#define FGUI_CONF @"guidePageConfigure"
#define FGUI_KEY_PAGES @"pages"
#define FGUI_KEY_ENTRY_BTN @"entry_btn"
#define FGUI_KEY_INTERVAL @"interval"
#define FGUI_KEY_BG_BLIGHT @"bg_bright"
#define FGUI_KEY_BG_DARK @"bg_dark"

#pragma mark - USER-DEFAULT(UD) *******************************

#define UD_KEY_CURRENT_TOKEN @"ACCTOKEN"    // 当前用户的token
#define UD_KEY_GUID_HAD_SHOWN @"HAD_SHOWN"  // 启动界面被浏览过
#define UD_KEY_CURRENT_PHONE @"PHONENUM"    // 当我们用户的phone number

#pragma mark - NETWORK(NET) ******************************
/* errors */
#define NET_ERR_EMPTY_CONTENT @"服务器返回内容为空"
#define NET_ERR_STATUS_EXEPTION @"服务器状态异常"
#define NET_ERR_JSON_PARSE_FAILED @"服务器返回内容异常"
#define NET_ERR_REQUEST_FAILED @"访问失败"

/* ret code */
#define NET_RET_SUCCESS 1
#define NET_RET_FAILED 0
#define NET_RET_TOKEN_TIMEOUT -2

/* key */
#define NET_KEY_RET @"ret"
#define NET_KEY_ERRMSG @"errmsg"
#define NET_KEY_DATA @"data"
#define NET_KEY_SESSID @"sessid"

/* api */
#define NET_API_BASE @"http://app.teambuy.com.cn/apnc/m/"
/*   add address complete post    */
/*(api)*/
#define NET_API_ADDADDRESS @"cpord/a/newaddress"//新增地址
//*******(arg)*********
#define NET_ARG_TURENAME @"truename"           //收件人
#define NET_ARG_TEL @"tel"                     //电话
#define NET_ARG_ADDRESS @"address"              //地址
#define NET_ARG_PROVINCE @"province"            // 省份ID
#define NET_ARG_CITY @"city"                    // 城市ID
#define NET_ARG_CAREA @"carea"                  //区ID
#define NET_ARG_SENDID @"sendid"                //送货ID
#define NET_ARG_ZIPCODE @"zipcode"              //邮编
#define NET_ARG_ISDEF @"isdef"                 // 是佛默认地址

//////////// delete address //////////////
//*********(api)***************
#define NET_API_DELTE_ADDRESS  @"cpord/a/deluaddr"
//********(arg)****************
#define NET_ARG__UAID @"uaid"                 //地址id


/////////////修改地址////////////////////
#define NET_API_EDITADDRESS @"cpord/a/editaddress" //修改地址
//*******(arg)*********
#define NET_ARG_UAIDEDIT        @"uaid"
#define NET_ARG_TRUENAMEEDIT    @"truename"
#define NET_ARG_TELEDIT         @"tel"
#define NET_ARG_ADDRESSEDIT      @"address"
#define NET_ARG_PROVINCEEDIT      @"province"
#define NET_ARG_CITYEDIT          @"city"
#define NET_ARG_ZIPCODEEDIT        @"zipcode"
#define NET_ARG_ISDEFEDIT          @"isdef"
#define NET_ARG_CAREAEDIT          @"carea"
#define NET_ARG_SENDIDEDIT        @"sendid"



///////// create order/////////////////
#define NET_API_CREATE_ORDER @"tmord/a/createtmorder"
//************(arg)*****************
#define NET_ARG_ADDRESSIDD @"addrid"     //生成订单时地址id
#define NET_ARG_PAYWAY @"paym"             //支付方式
#define NET_ARG_SENDIDD @"sendm"           // 送货方式
#define NET_ARG_INVOICE @"fapiao"            // 发票抬头
#define NET_ARG_LNGO @"lngo"                   // 经度
#define NET_ARG_LATO @"lato"                   //纬度
#define NET_ARG_SHOPIDD @"shop"              //商铺idd
#define NET_ARG_SPSU @"cpmx"            //商品数据



////////////////createpay////////////
#define NET_CREATEPAY @"tmord/a/createpaybych"
//************(ARG)*****************
#define NET_ARG_ORDNO @"ordno"             //订单号
#define NET_ARG_PAYM @"paym"                //支付方式

///////////////getmytmord////////
#define NET_GETMYTMORD @"my/a/getmytmordnocpmx"  
//****************(ARG)*****************
#define NET_ARG_ORDZT  @"ordzt"       //订单状态（0 待支付 1已支付）
#define  NET_ARG_DETAIL_ORDNO   @"ordno"   //订单号


/////////getmyfav//////////////////
//************(arg)*****************
#define NET_API_GETMYFAV  @"my/a/getmyfav"             //获得收藏列表
//****************(ARG)*****************
#define NET_ARG_ORDZT_UFLB   @"uflb"       //收藏类别
#define  NET_ARG_ORDZT_PAGE     @"page"   //页数


/////////ordrecgoods//////////////////
#define NET_API_ORDRECGOODS   @"tmord/a/ordrecgoods"         //订单收货
///***********(ARG)*****************
#define NET_ARG_ORDNO_ORDRECGOODS  @"ordno"        //订单号

/////////gettmrecm////////////////////////////////
////*************(api)***********************
#define NET_API_GETTMRECM_MY     @"my/a/gettmrecm"    //  获取我的特卖评价




///////////////gettmrecm//////////////////////
//************(api)***********************
#define NET_API_GETTMRECM     @"temai/a/gettmrecm"   //获取特卖评论
//***************(arg)*************************
#define NET_ARG_SHOPID_GETTMRECM @"shopid"           //店铺id
#define  NET_ARG_CPID_GETTMRECM  @"cpid"              //商品id
#define NET_ARG_PAGE_GETTMRECM   @"page"               //页数

//////////// login && register //////////
// *****(api)*******
#define NET_API_LOGIN @"user/a/login"               // 登陆
#define NET_API_REGISTER @"user/a/register"         // 注册
#define NET_API_GETYZM @"user/a/sendyzm"            // 获取验证码
#define NET_API_CHECKUSER @"user/a/checkusername"   // 检查用户是否存在
#define NET_API_CHPWD @"my/a/chpwd"
// ******(arg)******
#define NET_ARG_LOGIN_PHONE @"username"         // 用户名
#define NET_ARG_LOGIN_PASW @"password"          // 密码
#define NET_ARG_LOGIN_TOKEN @"acctoken"         // 用户token
#define NET_ARG_LOGIN_MOBILE @"mobile"          // 手机号码
#define NET_ARG_LOGIN_YZM @"mobyzm"             // 短信验证码

///////////       near       //////////
// ******(api)******
#define NET_API_PRODUCT_ALL @"cpmx/a/getallcpmx" // 获取所有商品
// ******(arg)******
#define NET_ARG_PRODUCT_CITYID @"cityid"    // 城市ID
#define NET_ARG_PRODUCT_PAGE @"page"        // 页码
#define NET_ARG_PRODUCT_PX  @"px"           // 排序

/////////  gettmlb  //////////////////
//********(api)*************
#define NET_API_GETTMLB  @"temai/a/gettmlb"     //获取商品的大类
//**************(arg)******************


/////////gettmshop/////////////////////////
//************(api)*******************
#define NET_API_GETTMSHOPBYID @"temai/a/gettmshopbyid"  //获取某一特卖店铺
//*******(arg)************************
#define NET_ARG_SHOPID_GETTMSHOP      @"shopid"            //店铺id

///////////////getatemai////////////////////
////////***************(api)****************
#define NET_API_GETATEMAI   @"temai/a/getatemai"  // 获取某一特卖
//**************(arg)**********************
#define  NET_ARG_TEMAI_TMID  @"tmid"              //   特卖商品id

/////////////gettmcima////////////////////
//***************(api)**********************
#define NET_API_GETTMCIMA  @"temai/a/gettmcima"           //获得特卖尺码
//******************(arg)******************
#define NET_ARG_TMID        @"tmid"                //特卖商品id


///////////       sale       //////////
// ******(api)******
#define NET_API_TEMAI_ALL @"temai/a/gettemai"
// ******(arg)******
#define NET_ARG_TEMAI_PAGE @"page"      // 页数
#define NET_ARG_TEMAI_CPDL @"cpdl"      // 大类id
#define NET_ARG_TEMAI_CPXL @"cpxl"      // 小类id
#define NET_ARG_TEMAI_SHOPID @"shopid"  // 特卖商铺id
#define NET_ARG_TMDLID        @"tmid"    //特卖商品id

///////////  getappady ///////////////
//******************getappady***********
#define NET_API_GETAPPADY  @"sys/a/getappadv" //app广告位
//**********(arg)*******************
#define NET_ARG_PAGEA     @"pagea"       //页面标识



/////////// gettminfo//////////////////
//*************(api)***********************
#define NET_API_GETTMINFO     @"temai/a/gettminfo" //获取特卖商品信息
//**********(arg)*****************
#define NET_ARG_TMID_GETTMINFO  @"tmid"  //商品id



///////////       activities       //////////
// ******(api)******
#define NET_API_ACTIVITIES_ALL @"cpmx/a/gethuodong"
// ******(arg)******
#define NET_ARG_ACTVT_AC @"ac"      //活动区号
#define NET_ARG_ACTVT_PAGE @"page"  //页数

//////////////gettmshop////////////////////////
//***********(api)*******************************
#define NET_API_GETTMSHOP    @"temai/a/gettmshop"  //获取特卖店铺｀
//*********(arg)*********************************
#define NET_ARG_GETTMSHOP_PAGE @"page"  //页数
#define NET_ARG_GETTMSHOP_CPDL  @"cpdl"  //大类id
#define NET_ARG_GETTMSHOP_CPXL  @"cpxl" //小类id





///////////       my       //////////
// ******(api)******
#define NET_API_MY_ADDRESS_ALL @"cpord/a/getaddress"
// ******(arg)******

//////////////getmyinfo//////////
//********(api)****************
#define NET_API_GETMYINFO  @"my/a/getmyinfo"   //我的

////////  addfav ////////////////////////////
//*************(api)******************  //提交收藏
#define NET_API_ADDFAV  @"my/a/addfav"
//*************(arg)******************
#define NET_ARG_UFLB   @"uflb"         //收藏类别
#define NET_ARG_LBID   @"lbid"        //对应ID
#define NET_ARG_LNGOADDFAV @"lngo"    //经度
#define NET_ARG_LATOADDFAV  @"lato"    // 纬度

//////////////feedback///////////////////
/////***********(api)********************
#define NET_API_FEEDBACK   @"my/a/feedback"  //反馈意见
/////***********(arg)********************
#define NET_ARG_FEEDBACK   @"feedback"//正文


//***************setavatar***********
//*************(api)********************
#define NET_API_SETAVATAR     @"my/a/setavatar" //提交头像
//************(arg)***********************
#define NET_ARG_AVANAME     @"avaname"    //头像选框名

//////////allowbuy/////////
//***********(api)**************
#define NET_API_ALLOWBUY @"tmord/a/allowbuy"     //限购次数
//***********(arg)**************
#define NET_ARG_ALLOWBUY_TMID   @"tmid"         //产品id
#define NET_ARG_ALLOWBUY_BUYTIMES  @"buytimes"        //次数





//////////////////edituser/////////////////
//**************(api)******************  //编辑个人信息
#define NET_API_EDITUSER      @"my/a/edituser"
//************(arg)******************
#define NET_ARG_NICKNAME       @"nickname"  //昵称
#define NET_ARG_BIRTHDAY        @"birthday"
#define NET_ARG_SEX              @"sex"
#define NET_ARG_EMAIL             @"email"
#define NET_ARG_SIGNATE          @"signate"


#pragma mark - VERIFICATION ERRORS(VER) ********************************

#define VER_PHONE @"手机号格式错误,请重新输入"
#define VER_PASSWORD @"密码格式错误,请重新输入"
#define VER_YZM @"验证码错误,请稍后再试"

#pragma mark - REGULARS(REG)

#define REG_PHONE @"^[1][3578]\\d{9}$"  // 手机号校验
#define REG_PASW @"\\w{6,}"             // 密码校验
#define REG_YZM @"\\d{6}"               // 验证码校验

#pragma mark - PLACEHOLDER **********************************

#define PH_PHONE @"请输入手机号码"
#define PH_PSWD @"请输入密码"

#pragma mark - COLORS(COL) **********************************

#define COL_LINEBREAK 0xc9c9c9
#define COL_INPUTBOX 0x646464

#pragma mark - DATA CENTER **********************************

#define CKEY_USER @"USER"
#define CKEY_TEAMBUY @"TEAMBUY"
#define CKEY_HUODONG @"HUO_DONG"
#define CKEY_TE_MAI @"TE_MAI"
#define CKEY_ADDRESS @"ADDRESS"
#define CKEY_PROVINCE @"PROVINCE"
#define CKEY_CITY @"CITY"
#define CKEY_AREA @"AREA"
#define CKEY_TMORD  @"TMORD"
#define CKEY_CXYM   @"CX"

#endif
