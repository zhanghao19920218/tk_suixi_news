//
//  UploadMethod.h
//  Runner
//
//  Created by Barry Allen on 2019/7/15.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import <UIKit/UIKit.h>

//上传文件的object

NS_ASSUME_NONNULL_BEGIN

/**
 *  拍摄完成后的Block回调
 *
 *  @param videoUrl 拍摄后返回的小视频地址
 *  @param videoTimeLength 小视频时长
 *  @param thumbnailImage 小视频缩略图
 */
typedef void(^CompletionBlock)(NSString *videoUrl, CGFloat videoTimeLength, NSString *imageUrl, BOOL isSuccess);

/**
 *  拍完照片后的Block
 *
 *  @param image 拍照后返回的image
 */
typedef void(^ImageCompletionBlock)(NSString* imageUrl, BOOL isSuccess);


/**
 *  返回为id的Block
 *
 *  @param image 拍照后返回的文件的id
 */
typedef void(^VoidCallBackBlock)(NSString *fileId, BOOL isSuccess);

@class BaseViewController;
@interface UploadMethod : NSObject

//创造单例模式
+(instancetype) shareInstance;

/**
 *  @method 上传文件
 *
 *  @param image 拍照后返回的文件的id
 */
- (void)uploadAnVideoFile:(NSData *)data  andCamer:(BaseViewController *)cameraController  SuccessBlock:(VoidCallBackBlock)block;

/**
 *  @method 上传一张照片
 *
 *  @param image 拍照后返回的文件的id
 */
- (void)uploadAnImageFile:(UIImage *)image andCamer:(BaseViewController *)cameraController SuccessBlock:(VoidCallBackBlock)block;

@end

NS_ASSUME_NONNULL_END
