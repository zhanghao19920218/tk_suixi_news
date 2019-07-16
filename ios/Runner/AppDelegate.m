#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import "NELivePlayerViewController.h" //视频直播的地址
#import "XFCameraController.h"

#import "UploadMethod.h"

@interface AppDelegate ()

@property (nonatomic, strong) FlutterViewController *controller;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
    self.controller = (FlutterViewController *)self.window.rootViewController; //初始化FlutterViewController页面
    
    //设置MethodChannel来和Flutter进行通知
    FlutterMethodChannel *channel = [FlutterMethodChannel methodChannelWithName:@"com.example.tkSuixiNews/videoShow" binaryMessenger:self.controller];
    
    [channel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        NSLog(@"method=%@ \narguments = %@", call.method, call.arguments);
        //跳转到直播的界面
        if ([@"jumpVideoOnlineShow" isEqualToString:call.method]) {
            NSDictionary *dic = call.arguments;
            NSString *videoStr = dic[@"address"];
            [self jumpToMainVCController:videoStr];
        } else if ([@"jumpShootVideo" isEqualToString:call.method]) {
            //保存token到本地
            NSDictionary *dic = call.arguments;
            NSString *token = dic[@"token"];
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:token forKey:@"token"];
            
            [self jumpToShootVideoController:^(NSString *imageUrl, BOOL isSuccess) {
                NSString *success = isSuccess ? @"success" : @"failure";
                NSDictionary *map = @{
                                      @"imageUrl":imageUrl,
                                      @"isSuccess":success,
                                      @"image":@"1"
                                      };
                if (result) {
                    result(map);
                }
                
            } videoBlock:^(NSString *videoUrl, CGFloat videoTimeLength, NSString *imageUrl, BOOL isSuccess) {
                NSString *success = isSuccess ? @"success" : @"failure";
                NSDictionary *map = @{
                                      @"videoUrl":videoUrl,
                                      @"videoTimeLength" : [NSString stringWithFormat:@"%.2f", videoTimeLength] ,
                                      @"imageUrl": imageUrl,
                                      @"isSuccess": success,
                                      @"image": @"2"
                                      };
                if (result) {
                    result(map);
                }
            }];
        }else { //显示没有方法返回
            result(FlutterMethodNotImplemented);
        }
    }];
    
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

//跳转到视频播放页面
- (int)jumpToMainVCController:(NSString *)_playUrl {
    if (_playUrl == nil) {
        _playUrl = @""; //默认为""
    }
    NELivePlayerViewController *player = [[NELivePlayerViewController alloc] initWithURL:[NSURL URLWithString:_playUrl]];
    //    playerController.playUrl = _playUrl; //播放的地址
    if (self.controller != nil) {
        [self.controller presentViewController:player animated:YES completion:nil]; //跳转页面
        return 1;
    } else {
        return -1;
    }
}

//跳转微信拍摄页面
- (int)jumpToShootVideoController:(ImageCompletionBlock)photoBlock
                       videoBlock:(CompletionBlock)shootBlock{
    
    XFCameraController *cameraController = [XFCameraController defaultCameraController];
    
    __weak XFCameraController *weakCameraController = cameraController;
    
    //拍照的Block
    cameraController.takePhotosCompletionBlock = ^(UIImage *image, NSError *error) {
        NSLog(@"takePhotosCompletionBlock");
        
        //在主线程里面调用
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [[UploadMethod shareInstance] uploadAnImageFile:image
                               andCamer:weakCameraController
                           SuccessBlock:^(NSString *fileId, BOOL isSuccess) {
                               if (isSuccess) {
                                   photoBlock(fileId, isSuccess);
                                   [weakCameraController dismissViewControllerAnimated:YES completion:nil];
                               } else {
                                   [weakCameraController dismissViewControllerAnimated:YES completion:nil];
                               }
                           }];
        }];
        
    };
    
    //录像的Block
    cameraController.shootCompletionBlock = ^(NSURL *videoUrl, CGFloat videoTimeLength, UIImage *thumbnailImage, NSError *error) {
        NSLog(@"shootCompletionBlock");
        
        //上传视频的数据
        NSString *path = [videoUrl path];
        NSData *data = [NSData dataWithContentsOfFile:path];
        
        //在主线程里面调用
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [[UploadMethod shareInstance] uploadAnVideoFile:data
                                                   andCamer:weakCameraController
                                               SuccessBlock:^(NSString *fileId, BOOL isSuccess) {
                                                   if (isSuccess) { //如果成功再上传照片
                                                       NSString *videosUrl = fileId; //视频的地址
                                                       [[UploadMethod shareInstance] uploadAnImageFile:thumbnailImage
                                                                                              andCamer:weakCameraController
                                                                                          SuccessBlock:^(NSString *fileId, BOOL isSuccess) {
                                                                                              if (isSuccess) { //上传照片成功
                                                                                                  
                                                                                                  shootBlock(videosUrl, videoTimeLength, fileId, isSuccess);
                                                                                                  [weakCameraController dismissViewControllerAnimated:YES completion:nil];
                                                                                                  
                                                                                              } else {
                                                                                                  [weakCameraController dismissViewControllerAnimated:YES completion:nil];
                                                                                              }
                                                                                          }];
                                                   } else {
                                                       [weakCameraController dismissViewControllerAnimated:YES completion:nil];
                                                   }
                                               }];
        }];
        
        
    };
    
    
    if (self.controller != nil) {
        [self.controller presentViewController:cameraController animated:YES completion:nil]; //跳转页面
        return 1;
    } else {
        return -1;
    }
}

@end
