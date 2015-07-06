//
//  ImageLoader.m
//  ZhongTuan
//
//  Created by anddward on 15/2/2.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "ZTImageLoader.h"

@interface ZTImageLoader()
-(NSString*)getFileName:(NSString*)url;
-(void)saveImage:(NSData*)imgData withUrl:(NSString*)url;
-(NSURL*)getImageCacheDir;
@end

@interface ImageLoaderTest : XCTestCase{
    ZTImageLoader *_imageLoader;
    NSString *_httpUrl;
}

@end

@implementation ImageLoaderTest

- (void)setUp {
    [super setUp];
    _imageLoader = [ZTImageLoader new];
    _httpUrl = @"http://www.baidu.png";

    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testImageFileNameFromUrl{
    NSString *imageFileName = [_imageLoader getFileName:_httpUrl];
    XCTAssertEqualObjects(imageFileName, @"baidu.png");
}

-(void)testImageSaveToDisk{
    NSFileManager *fmg = [NSFileManager defaultManager];
    NSURL *cacheDirectory = [fmg URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    UIImage *image = [UIImage imageNamed:@"welcome"];
    NSData *imgData = UIImagePNGRepresentation(image);
    [_imageLoader saveImage:imgData withUrl:_httpUrl];
    NSURL *cacheFile =[[cacheDirectory URLByAppendingPathComponent:@"imageCache"]
                       URLByAppendingPathComponent:@"baidu.png"];
    XCTAssertTrue([fmg fileExistsAtPath:[cacheFile path]]);
    // TODO: NOT EQUAL TEST
}

-(void)testImageLoadFromUrl{
    // TODO: NO TEST
}

-(void)testGetImageCacheDir{
    NSURL *dir = [_imageLoader getImageCacheDir];
    // true dir
    NSURL *cacheDir = [[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    NSURL *preUrl = [cacheDir URLByAppendingPathComponent:@"imageCache"];
    XCTAssertEqualObjects([dir absoluteString], [preUrl absoluteString]);
}

#pragma mark - system Test


@end
