//
//  TGStaticTool.m
//  HTTPClientOS
//
//  Created by Barry Allen on 2019/3/11.
//  Copyright © 2019 Barry Allen. All rights reserved.
//

#import "TGStaticTool.h"
#include <sys/sysctl.h>
#import <CommonCrypto/CommonDigest.h>

@implementation TGStaticTool

+ (NSString *)md5:(NSString *)input {
    if (!input) {
        return nil;
    }
    
    const char *cStr = [input UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

//去空格
+ (NSString *)replaceSpace:(NSString *)originString {
    return [originString stringByReplacingOccurrencesOfString:@" " withString:@""];
}
//验证手机号
+ (BOOL)validateMobile:(NSString *)candidate
{
    
    NSString *emailCharacters =@"^(1)[0-9]{10}$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailCharacters];
    
    NSString *proceedString = [self replaceSpace:candidate];
    return [emailTest evaluateWithObject:proceedString];
}

+ (BOOL)validateSting:(NSString *)string1 withString:(NSString *)string2{
    NSString *proceedString1 = [self replaceSpace:string1];
    NSString *proceedString2 = [self replaceSpace:string2];
    BOOL result = [proceedString1 caseInsensitiveCompare:proceedString2] == NSOrderedSame;
    return result;
}


//必须是数字和字母
+ (BOOL)validatePasswordNew:(NSString *)password minLength:(NSString *)minLength maxLength:(NSString *)maxLength{
    [self replaceSpace:password];
    NSString *passwordCharacters = [NSString stringWithFormat:@"^[A-Za-z0-9_-]{%@,%@}$",minLength,maxLength];
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passwordCharacters];
    BOOL pass = [passwordTest evaluateWithObject:password];
    
    //    NSString *passwordCharacters1 = @".*[A-Za-z].*";
    //    NSPredicate *passwordTest1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passwordCharacters1];
    //    BOOL pass1 = [passwordTest1 evaluateWithObject:password];
    //
    //    NSString *passwordCharacters2 = @".*[0-9].*";
    //    NSPredicate *passwordTest2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passwordCharacters2];
    //    BOOL pass2 = [passwordTest2 evaluateWithObject:password];
    
    //    return (pass && pass1 && pass2);
    return pass;
}

/**
 十进制转换十六进制
 
 @param decimal 十进制数
 @return 十六进制数
 */
+ (NSString *)getHexByDecimal:(NSInteger)decimal {
    
    NSString *hex =@"";
    NSString *letter;
    NSInteger number;
    for (int i = 0; i<9; i++) {
        
        number = decimal % 16;
        decimal = decimal / 16;
        switch (number) {
                
            case 10:
                letter =@"A"; break;
            case 11:
                letter =@"B"; break;
            case 12:
                letter =@"C"; break;
            case 13:
                letter =@"D"; break;
            case 14:
                letter =@"E"; break;
            case 15:
                letter =@"F"; break;
            default:
                letter = [NSString stringWithFormat:@"%ld", (long)number];
        }
        hex = [letter stringByAppendingString:hex];
        if (decimal == 0) {
            
            break;
        }
    }
    return hex;
}



/**
 十六进制转换为十进制
 @param hexStr 十六进制数
 @return 十进制数
 */

+ (UInt64)coverFromHexStrToInt:(NSString *)hexStr{
    UInt64 mac1 =  strtoul([hexStr UTF8String], 0, 16);
    return mac1;
}

/**
 时间差转换
 @param starTime 起始时间
 @param format 时间格式
 @param endTime 结束时间
 @return 十进制数
 */
+ (NSTimeInterval)pleaseInsertStarTime:(NSString *)starTime andInsertEndTime:(NSString *)endTime format:(NSString *)format{
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:format];//根据自己的需求定义格式
    NSDate* startDate = [formater dateFromString:starTime];
    NSDate* endDate = [formater dateFromString:endTime];
    NSTimeInterval time = [endDate timeIntervalSinceDate:startDate];
    return time;
}


/**
 二进制转换成十六进制
 
 @param binary 二进制数
 @return 十六进制数
 */
+ (NSString *)getHexByBinary:(NSString *)binary {
    
    NSMutableDictionary *binaryDic = [[NSMutableDictionary alloc] initWithCapacity:16];
    [binaryDic setObject:@"0" forKey:@"0000"];
    [binaryDic setObject:@"1" forKey:@"0001"];
    [binaryDic setObject:@"2" forKey:@"0010"];
    [binaryDic setObject:@"3" forKey:@"0011"];
    [binaryDic setObject:@"4" forKey:@"0100"];
    [binaryDic setObject:@"5" forKey:@"0101"];
    [binaryDic setObject:@"6" forKey:@"0110"];
    [binaryDic setObject:@"7" forKey:@"0111"];
    [binaryDic setObject:@"8" forKey:@"1000"];
    [binaryDic setObject:@"9" forKey:@"1001"];
    [binaryDic setObject:@"A" forKey:@"1010"];
    [binaryDic setObject:@"B" forKey:@"1011"];
    [binaryDic setObject:@"C" forKey:@"1100"];
    [binaryDic setObject:@"D" forKey:@"1101"];
    [binaryDic setObject:@"E" forKey:@"1110"];
    [binaryDic setObject:@"F" forKey:@"1111"];
    
    if (binary.length % 4 != 0) {
        
        NSMutableString *mStr = [[NSMutableString alloc]init];;
        for (int i = 0; i < 4 - binary.length % 4; i++) {
            
            [mStr appendString:@"0"];
        }
        binary = [mStr stringByAppendingString:binary];
    }
    NSString *hex = @"";
    for (int i=0; i<binary.length; i+=4) {
        
        NSString *key = [binary substringWithRange:NSMakeRange(i, 4)];
        NSString *value = [binaryDic objectForKey:key];
        if (value) {
            
            hex = [hex stringByAppendingString:value];
        }
    }
    return hex;
}


/**
 十六进制转换为二进制
 
 @param hex 十六进制数
 @return 二进制数
 */
+ (NSString *)getBinaryByHex:(NSString *)hex {
    
    NSMutableDictionary *hexDic = [[NSMutableDictionary alloc] initWithCapacity:16];
    [hexDic setObject:@"0000" forKey:@"0"];
    [hexDic setObject:@"0001" forKey:@"1"];
    [hexDic setObject:@"0010" forKey:@"2"];
    [hexDic setObject:@"0011" forKey:@"3"];
    [hexDic setObject:@"0100" forKey:@"4"];
    [hexDic setObject:@"0101" forKey:@"5"];
    [hexDic setObject:@"0110" forKey:@"6"];
    [hexDic setObject:@"0111" forKey:@"7"];
    [hexDic setObject:@"1000" forKey:@"8"];
    [hexDic setObject:@"1001" forKey:@"9"];
    [hexDic setObject:@"1010" forKey:@"A"];
    [hexDic setObject:@"1011" forKey:@"B"];
    [hexDic setObject:@"1100" forKey:@"C"];
    [hexDic setObject:@"1101" forKey:@"D"];
    [hexDic setObject:@"1110" forKey:@"E"];
    [hexDic setObject:@"1111" forKey:@"F"];
    
    NSString *binary = @"";
    for (int i=0; i<[hex length]; i++) {
        
        NSString *key = [hex substringWithRange:NSMakeRange(i, 1)];
        NSString *value = [hexDic objectForKey:key.uppercaseString];
        if (value) {
            
            binary = [binary stringByAppendingString:value];
        }
    }
    return binary;
}


@end
