#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import "NELivePlayerViewController.h" //视频直播的地址
#import "XFCameraController.h"

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
            [self jumpToShootVideoController:^(UIImage *image, NSError *error) {
                NSData *data = UIImageJPEGRepresentation(image, 0.8f);
                NSDictionary *dic = call.arguments;
                NSLog(@"arguments = %@", dic);
                NSDictionary *map = @{@"data":data};
                
                if (error == nil) {
                    if (result) {
                        result(map);
                    }
                }
                
                
            } videoBlock:^(NSURL *videoUrl, CGFloat videoTimeLength, UIImage *thumbnailImage, NSError *error) {
                NSData *data = UIImageJPEGRepresentation(thumbnailImage, 0.8f);
                NSDictionary *map = @{@"videoUrl":videoUrl, @"length":  [NSString stringWithFormat:@"%.2f", videoTimeLength], @"thumb": data};
                
                if (error == nil) {
                    if (result) {
                        result(map);
                    }
                }
//                if (result) {
//                    result(map);
//                }
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
- (void)jumpToShootVideoController:(TakePhotosCompletionBlock)photoBlock
                       videoBlock:(ShootCompletionBlock)shootBlock{
    XFCameraController *cameraController = [XFCameraController defaultCameraController];
    
    __weak XFCameraController *weakCameraController = cameraController;
    
    cameraController.takePhotosCompletionBlock = ^(UIImage *image, NSError *error) {
        NSLog(@"takePhotosCompletionBlock");
        
        photoBlock(image, error);
        
        [weakCameraController dismissViewControllerAnimated:YES completion:nil];
    };
    
    cameraController.shootCompletionBlock = ^(NSURL *videoUrl, CGFloat videoTimeLength, UIImage *thumbnailImage, NSError *error) {
        NSLog(@"shootCompletionBlock");
        
        shootBlock(videoUrl, videoTimeLength, thumbnailImage, error);
        
        [weakCameraController dismissViewControllerAnimated:YES completion:nil];
    };
    
    [self.controller presentViewController:cameraController animated:YES completion:nil];
}

@end
