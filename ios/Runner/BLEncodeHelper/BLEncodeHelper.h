//
//  BLEncodeHelper.h
//  HTTPClientOS
//
//  Created by Barry Allen on 2019/3/11.
//  Copyright © 2019 Barry Allen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BLEncodeHelper : NSObject

+ (NSString *)urlEncode:(NSString *)input; //编码Url
+ (NSString *)urlDecode:(NSString *)input; //解析Url

@end

NS_ASSUME_NONNULL_END
