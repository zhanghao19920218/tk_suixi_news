//
//  TGArgu.h
//  HTTPClientOS
//
//  Created by Barry Allen on 2019/3/11.
//  Copyright © 2019 Barry Allen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TGHttpArgu : NSObject

@property (nonatomic, copy) NSString *key;

@property (nonatomic, copy) NSString *value;

- (instancetype)initWithKey:(NSString *)key value:(NSString *)value;

@end

NS_ASSUME_NONNULL_END
