//
//  TGStaticTool.h
//  HTTPClientOS
//
//  Created by Barry Allen on 2019/3/11.
//  Copyright © 2019 Barry Allen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TGStaticTool : NSObject

//MD5加密
+ (NSString *)md5:(NSString *)input;

+ (NSString *)replaceSpace:(NSString *)originString;

+ (BOOL)validateMobile:(NSString *)candidate;
//验证字符串相等
+ (BOOL)validateSting:(NSString *)string1 withString:(NSString *)string2;
//验证密码
+ (BOOL)validatePasswordNew:(NSString *)password minLength:(NSString *)minLength maxLength:(NSString *)maxLength;
// 十进制转换十六进制
+ (NSString *)getHexByDecimal:(NSInteger)decimal;
// 十六进制转换为十进制
+ (UInt64)coverFromHexStrToInt:(NSString *)hexStr;
// 二进制转换为十六进制
+ (NSString *)getHexByBinary:(NSString *)binary;//2->16
// 十六进制转换为二进制
+ (NSString *)getBinaryByHex:(NSString *)hex;//16->2
//时间差
+ (NSTimeInterval)pleaseInsertStarTime:(NSString *)starTime andInsertEndTime:(NSString *)endTime format:(NSString *)format;

@end

NS_ASSUME_NONNULL_END
