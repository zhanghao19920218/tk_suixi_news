//
//  BaseViewController.m
//  Runner
//
//  Created by Barry Allen on 2019/7/15.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import "BaseViewController.h"
#import "MBProgressHUD.h"

@interface BaseViewController ()

@property (nonatomic, strong) MBProgressHUD *HUD;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark --  提示框 MBProgressHUD ---
- (void)showLoading:(NSString *)text {
    self.HUD = [MBProgressHUD HUDForView:self.view];
    self.HUD.userInteractionEnabled = YES;
    if (self.HUD) {
        return;
    }
    CABasicAnimation *animation =  [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
    animation.fromValue = [NSNumber numberWithFloat:0.f];
    animation.toValue =  [NSNumber numberWithFloat: M_PI *2];
    animation.duration  = 1;
    animation.autoreverses = NO;
    animation.fillMode =kCAFillModeForwards;
    animation.repeatCount = MAXFLOAT;
    self.HUD =  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.HUD.mode = MBProgressHUDModeIndeterminate;
    self.HUD.bezelView.backgroundColor = [UIColor blackColor];
    CGFloat xOffset = self.HUD.offset.x;
    [self.HUD setOffset:CGPointMake(xOffset, -80)];
}

- (void)hideLoading {
    [self.HUD hideAnimated:YES afterDelay:1.0f];
}

//hud
- (void)showHudAndHide:(NSString *)text withImage:(NSString *)imageName afterDelay:(NSTimeInterval)Delay{
    MBProgressHUD *loadingView = [MBProgressHUD showHUDAddedTo:self.view animated:NO];
    loadingView.userInteractionEnabled = YES;
    loadingView.animationType = MBProgressHUDAnimationZoomOut;
    loadingView.mode = MBProgressHUDModeCustomView;
    loadingView.label.text = text;
    loadingView.label.numberOfLines = 0;
    loadingView.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    loadingView.label.textColor = [UIColor whiteColor];
    loadingView.bezelView.backgroundColor = [UIColor blackColor];
    loadingView.minSize = CGSizeMake(200, 40);
    if ((imageName != nil) && (![imageName isEqualToString:@""])){
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        loadingView.customView = imageView;
    }
    [loadingView.label setFont:[UIFont systemFontOfSize:15]];
    [loadingView setRemoveFromSuperViewOnHide:YES];
    [loadingView hideAnimated:YES afterDelay:Delay];
}


@end
