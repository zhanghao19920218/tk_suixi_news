//
//  UIImage+HJImage.h
//  CDBDTransport_IOS
//
//  Created by Barry Allen on 2019/7/3.
//  Copyright © 2019 Barry Allen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (HJImage)

/**
 压缩图片到指定大小
 
 @param maxSize 例如100 * 1024  100kb以内
 @return data
 */
- (NSData *)compressImageToSize:(NSInteger)maxSize;

/**
 无损压缩
 
 @return data
 */
- (NSData *)compressImageNoAffectQuality;

/**
 拉伸图片
 
 @return 返回拉伸图
 */
- (UIImage *)tensileImage;

@end

NS_ASSUME_NONNULL_END
