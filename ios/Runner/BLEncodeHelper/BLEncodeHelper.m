//
//  BLEncodeHelper.m
//  HTTPClientOS
//
//  Created by Barry Allen on 2019/3/11.
//  Copyright © 2019 Barry Allen. All rights reserved.
//

#import "BLEncodeHelper.h"

@implementation BLEncodeHelper

+ (NSString *)urlEncode:(NSString *)input
{
    if (!input) {
        return nil;
    }
    
    NSString *outputStr = (NSString*)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)input,NULL,(CFStringRef)@"!*'();:@&=+$,/?%#[]",kCFStringEncodingUTF8));
    
    return outputStr;
    
}

+ (NSString *)urlDecode:(NSString *)input
{
    if (!input) {
        return nil;
    }
    
    NSMutableString *outputStr = [NSMutableString stringWithString:input];
    [outputStr replaceOccurrencesOfString:@"+"
                               withString:@" "
                                  options:NSLiteralSearch
                                    range:NSMakeRange(0, [outputStr length])];
    
    return [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

@end
