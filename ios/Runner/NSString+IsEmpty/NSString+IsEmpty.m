//
//  NSString+IsEmpty.m
//  TGTransportIOS
//
//  Created by Barry Allen on 2019/3/20.
//  Copyright © 2019 Barry Allen. All rights reserved.
//

#import "NSString+IsEmpty.h"

@implementation NSString(IsEmpty)

+(BOOL)isEmpty:(NSString*)text{
    if ([text isEqual:[NSNull null]]) {
        return YES;
    }
    else if ([text isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    else if (text == nil){
        return YES;
    }
    return NO;
}

@end
