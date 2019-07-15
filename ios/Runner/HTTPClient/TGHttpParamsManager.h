//
//  TGHttpParamsManager.h
//  HTTPClientOS
//
//  Created by Barry Allen on 2019/3/11.
//  Copyright © 2019 Barry Allen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TGHttpMethod) {
    TGHttpMethodPost,
    TGHttpMethodPostImage,
    TGHttpMethodPostVideo
};

@class TGHttpParams;

@interface TGHttpParamsManager : NSObject

#pragma mark - 上传文件的接口
/*
 * 上传文件的接口
 * 请求方式: POST
 * @param identifier: Controller控制器
 */
+ (TGHttpParams *)uploadFileInformationWithData:(NSData *)data
                                             By:(id)identifier;

/*
 * 上传视频文件的接口
 * 请求方式: POST
 * @param identifier: Controller控制器
 */
+ (TGHttpParams *)uploadVideoInformationWithData:(NSData *)data
                                              By:(id)identifier;


@end


NS_ASSUME_NONNULL_END
