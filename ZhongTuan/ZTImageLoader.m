//
//  ZTImageLoader.m
//  ZhongTuan
//
//  Created by anddward on 15/2/2.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "ZTImageLoader.h"
@interface ZTImageLoader(){
    NSString *_tag;
    BOOL complete;
}
@end

@implementation ZTImageLoader

#pragma mark - public methods
-(void)setImageFromUrl:(NSString*)url{
    [self setImageFromUrl:url backgroundColor:[UIColor colorWithHex:0xE4E4A1]];
}

-(void)setImageFromUrl:(NSString *)url backgroundColor:(UIColor*)color{
   
        
    if ( !url || [url isEqualToString:@""] ){
        // return if url is not a valid string
        self.image = nil;
      
        return;
    }
    _tag = url;
    //self.backgroundColor = color;
    [self loadImageFromDisk:url];
    if (!complete) {
    
        self.image = nil;
        [[ZTNetWorkUtilities sharedInstance] getFile:url cancelIfExist:YES complete:^(NSString *url,NSData *data) {
        NSLog(@"netnetnet");
                     if ([url isEqualToString:_tag]) {
                [self saveImage:data withUrl:url];
                self.image = [UIImage imageWithData:data];
                [self setNeedsLayout];
                [self layoutIfNeeded];
            }
        }];
    }
}
#pragma mark - helpers

-(void)loadImageFromDisk:(NSString*)url{
    NSURL *fileUrl = [[self getImageCacheDir] URLByAppendingPathComponent:[self getFileName:url]];
    UIImage *image = [UIImage imageWithContentsOfFile:[fileUrl path]];
    
    if (nil != image) {
    
        self.image = image;
        complete = YES;
        return;
    }
     
         complete = NO;
}

-(void)saveImage:(NSData*)imgData withUrl:(NSString*)url{
    if ([@"" isEqualToString:url]) {
        return;
    }
    NSURL *fileUrl = [[self getImageCacheDir] URLByAppendingPathComponent:[self getFileName:url]];
    [imgData writeToURL:fileUrl atomically:YES];
    complete = YES;
}

-(NSString*)getFileName:(NSString*)url{
    NSString *patten = @"\\w*\\.\\w*$";
    NSRegularExpression *regp = [NSRegularExpression regularExpressionWithPattern:patten options:0 error:nil];
    NSTextCheckingResult *result = [regp firstMatchInString:url options:0 range:NSMakeRange(0, url.length)];
    return [url substringWithRange:[result range]];
}

-(NSURL*)getImageCacheDir{
    NSURL *cacheDir = [[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    NSURL *imgDir = [cacheDir URLByAppendingPathComponent:@"imageCache"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:[imgDir path]]) {
        [[NSFileManager defaultManager] createDirectoryAtURL:imgDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return imgDir;
}

@end
