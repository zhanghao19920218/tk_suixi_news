//
//  TGArgu.m
//  HTTPClientOS
//
//  Created by Barry Allen on 2019/3/11.
//  Copyright © 2019 Barry Allen. All rights reserved.
//

#import "TGHttpArgu.h"

@implementation TGHttpArgu

- (instancetype)initWithKey:(NSString *)key
              value:(NSString *)value
{
    self = [super init];
    if (self) {
        _key = [key copy];
        _value = [value copy];
    }
    
    return self;
}

@end
