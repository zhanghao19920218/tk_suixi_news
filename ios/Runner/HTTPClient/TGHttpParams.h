//
//  TGHttpParams.h
//  HTTPClientOS
//
//  Created by Barry Allen on 2019/3/11.
//  Copyright © 2019 Barry Allen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TGHttpParams : NSObject
@property (nonatomic, copy) NSString *url; //请求地址
@property (nonatomic, strong) NSArray *argus; //请求参数
@property (nonatomic, strong) NSArray *getArgus; //获取参数
@property (nonatomic, assign) TGHttpMethod method; //请求方法
@property (nonatomic, copy) NSString *identifier; //认证方法
@property (nonatomic, copy) NSString *viewController;
@property (nonatomic, strong) NSData *data; //上传图片的数据

/**
 * HTTP请求参数的请求
 * @method 初始化TGHttpParams
 * @param url 请求网络地址
 * @param argus 请求参数
 * @param getArgus 获取参数
 * @param method 请求方法Get或者Post
 * @param identifier 请求对象
 */
- (instancetype)initWithUrl:(NSString *)url
                      argus:(NSArray *)argus
                   getArgus:(NSArray *)getArgus
                     method:(TGHttpMethod)method
                 identifier:(NSString *)identifier;

/**
 * HTTP上传图片的请求
 * @method 初始化TGHttpParams
 */
- (instancetype)initWithUrl:(NSString *)url
                      argus:(NSArray *)argus
                   getArgus:(NSArray *)getArgus
                       data:(NSData *)data
                     method:(TGHttpMethod)method
                 identifier:(NSString *)identifier;


@end

NS_ASSUME_NONNULL_END
