//
//  TGHttpClient.h
//  HTTPClientOS
//
//  Created by Barry Allen on 2019/3/11.
//  Copyright © 2019 Barry Allen. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN
@class TGHttpParams;
@interface TGHttpClient : NSObject

/**
 * 发起网络请求
 *
 * @param params 请求参数, 利用HttpParamsHelper生成
 * @param successHandler 成功回调
 * @param failureHander 失败回调
 */
+ (void)startRequest:(TGHttpParams *)params
             success:(void (^)(id responseObject))successHandler
             failure:(void (^)(NSError *error))failureHander;

@end

@interface TGPostBody : NSObject

@property (nonatomic, strong) id data;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *fileName;

@property (nonatomic, strong) NSString *mimeType;

@property (nonatomic, strong) NSSet *contentType;

@end

NS_ASSUME_NONNULL_END
