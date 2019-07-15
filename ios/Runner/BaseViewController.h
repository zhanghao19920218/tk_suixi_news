//
//  BaseViewController.h
//  Runner
//
//  Created by Barry Allen on 2019/7/15.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController

- (void)showLoading:(NSString *)text;

- (void)showHudAndHide:(NSString *)text withImage:(NSString *)imageName afterDelay:(NSTimeInterval)Delay;

- (void)hideLoading;

@end

NS_ASSUME_NONNULL_END
