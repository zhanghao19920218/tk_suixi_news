//
//  FileModel.m
//  Runner
//
//  Created by Barry Allen on 2019/7/15.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import "FileModel.h"
#import "NSString+IsEmpty.h"

@implementation FileModel

- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property
{
    if ([NSString isEmpty:oldValue]) {// 以字符串类型为例
        return  @"";
    }
    return oldValue;
}

@end
