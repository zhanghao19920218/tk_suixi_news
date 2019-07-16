//
//  TGHttpParamsManager.m
//  HTTPClientOS
//
//  Created by Barry Allen on 2019/3/11.
//  Copyright © 2019 Barry Allen. All rights reserved.
//

#import "TGHttpParamsManager.h"
#import "TGHttpParams.h"
#import "TGHttpArgu.h"
#import "TGAPIs.h"

#define K_URL_BASE          @"http://medium.tklvyou.cn/"

@implementation TGHttpParamsManager

#pragma mark - 上传文件的接口
+ (TGHttpParams *)uploadFileInformationWithData:(NSData *)data
                                             By:(id)identifier
{
    NSString *url = [K_URL_BASE stringByAppendingString:K_URL_uploadFile];
    NSMutableArray *argus = [NSMutableArray array];
    NSMutableArray *getArgus = [NSMutableArray array];
    return [[TGHttpParams alloc] initWithUrl:url argus:argus getArgus:getArgus data:data method:TGHttpMethodPostImage identifier:identifier];
}

#pragma mark - 上传视频的接口
+ (TGHttpParams *)uploadVideoInformationWithData:(NSData *)data
                                             By:(id)identifier
{
    NSString *url = [K_URL_BASE stringByAppendingString:K_URL_uploadFile];
    NSMutableArray *argus = [NSMutableArray array];
    NSMutableArray *getArgus = [NSMutableArray array];
    return [[TGHttpParams alloc] initWithUrl:url argus:argus getArgus:getArgus data:data method:TGHttpMethodPostVideo identifier:identifier];
}

@end
