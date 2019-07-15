//
//  TGHttpParams.m
//  HTTPClientOS
//
//  Created by Barry Allen on 2019/3/11.
//  Copyright © 2019 Barry Allen. All rights reserved.
//

#import "TGHttpParams.h"

@implementation TGHttpParams

- (instancetype)initWithUrl:(NSString *)url
                      argus:(NSArray *)argus
                   getArgus:(NSArray *)getArgus
                     method:(TGHttpMethod)method
                 identifier:(NSString *)identifier
{
    self = [super init];
    if (self) {
        _url = [url copy];
        _method = method;
        _argus = [self addPublicArgus:argus];
        _getArgus = [getArgus copy];
        _viewController = [NSString stringWithFormat:@"%@", NSStringFromClass([identifier class])];
        _identifier = [NSString stringWithFormat:@"%@_%@", url, NSStringFromClass([identifier class])];
    }
    
    return self;
}

- (instancetype)initWithUrl:(NSString *)url
                      argus:(NSArray *)argus
                   getArgus:(NSArray *)getArgus
                       data:(NSData *)data
                     method:(TGHttpMethod)method
                 identifier:(NSString *)identifier
{
    self = [super init];
    if (self) {
        _url = [url copy];
        _method = method;
        _argus = [self addPublicArgus:argus];
        _getArgus = [getArgus copy];
        _data = data;
        _viewController = [NSString stringWithFormat:@"%@", NSStringFromClass([identifier class])];
        _identifier = [NSString stringWithFormat:@"%@_%@", url, NSStringFromClass([identifier class])];
    }
    
    return self;
}

- (NSArray *)addPublicArgus:(NSArray *)argus
{
    NSMutableArray *modifiedArgus = [argus mutableCopy];
    
    return modifiedArgus;
}

@end
