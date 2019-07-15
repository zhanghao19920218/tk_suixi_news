//
//  UploadMethod.m
//  Runner
//
//  Created by Barry Allen on 2019/7/15.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import "UploadMethod.h"
#import "BaseViewController.h"
//网络请求模块
#import "TGHttpClient.h"
#import "TGHttpParamsManager.h"
//获取文件的model
#import "FileModel.h"

#define K_JT_msg                    @"msg"
#define K_JT_code                   @"code"
#define K_JT_data                   @"data"

@implementation UploadMethod

static UploadMethod *_instance = nil;

//创造单例模式
+(instancetype) shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init] ;
    }) ;
    
    return _instance ;
}

//上传一个视频文件
- (void)uploadAnVideoFile:(NSData *)data  andCamer:(BaseViewController *)cameraController  SuccessBlock:(VoidCallBackBlock)block
{
    //文件的id
    __block NSString *url = @"";
    
    __weak BaseViewController *weakCameraController = cameraController;
    
    [weakCameraController showLoading:@""];
    
    //上传照片
    TGHttpParams *params = [TGHttpParamsManager uploadVideoInformationWithData:data
                                                                            By:self];
    
    [TGHttpClient startRequest:params success:^(id responseObject) {
        [weakCameraController hideLoading];
        
        if (![responseObject isKindOfClass:[NSDictionary class]]){
            [weakCameraController showHudAndHide:@"上传视频文件失败" withImage:@"" afterDelay:1.0];
            //关闭当前的页面
            [weakCameraController dismissViewControllerAnimated:YES completion:nil];
            return;
        }
        NSInteger erroCode = [[responseObject objectForKey:K_JT_code] integerValue];
        NSString *erroMessage = [responseObject objectForKey:K_JT_msg];
        if (erroCode != 1){
            [weakCameraController showHudAndHide:erroMessage withImage:@"" afterDelay:1.0];
            //关闭当前的页面
            [weakCameraController dismissViewControllerAnimated:YES completion:nil];
            return;
        }
        NSDictionary *dict = [responseObject objectForKey:K_JT_data];
        FileModel *model = [FileModel mj_objectWithKeyValues:dict];
        url = model.url;
        block(url, YES);
        
    } failure:^(NSError *error) {
        [weakCameraController hideLoading];
        //关闭当前页面
        [weakCameraController dismissViewControllerAnimated:YES completion:nil];
    }];
}

//上传一个图片文件
- (void)uploadAnImageFile:(UIImage *)image andCamer:(BaseViewController *)cameraController SuccessBlock:(VoidCallBackBlock)block
{
    //文件的id
    __block NSString *url = @"";
    
    __weak BaseViewController *weakCameraController = cameraController;
    NSData *data = UIImagePNGRepresentation(image);
    //打开HUD
    [weakCameraController showLoading:@""];
    
    //上传照片
    TGHttpParams *params = [TGHttpParamsManager uploadFileInformationWithData:data
                                                                           By:self];
    
    [TGHttpClient startRequest:params success:^(id  _Nonnull responseObject) {
        [weakCameraController hideLoading];
        
        if (![responseObject isKindOfClass:[NSDictionary class]]){
            [weakCameraController showHudAndHide:@"上传视频文件失败" withImage:@"" afterDelay:1.0];
            //关闭当前的页面
            [weakCameraController dismissViewControllerAnimated:YES completion:nil];
            return;
        }
        NSInteger erroCode = [[responseObject objectForKey:K_JT_code] integerValue];
        NSString *erroMessage = [responseObject objectForKey:K_JT_msg];
        if (erroCode != 1){
            [weakCameraController showHudAndHide:erroMessage withImage:@"" afterDelay:1.0];
            //关闭当前的页面
            [weakCameraController dismissViewControllerAnimated:YES completion:nil];
            return;
        }
        NSDictionary *dict = [responseObject objectForKey:K_JT_data];
        FileModel *model = [FileModel mj_objectWithKeyValues:dict];
        url = model.url;
        block(url, YES); //返回文件名称
    } failure:^(NSError * _Nonnull error) {
        [weakCameraController hideLoading];
        //关闭当前页面
        [weakCameraController dismissViewControllerAnimated:YES completion:nil];
    }];
}

@end
