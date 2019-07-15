//
//  TGHttpClient.m
//  HTTPClientOS
//
//  Created by Barry Allen on 2019/3/11.
//  Copyright © 2019 Barry Allen. All rights reserved.
//

#import "TGHttpClient.h"
#import "AFNetworking.h"
#import "TGHttpParamsManager.h"
#import "TGHttpParams.h"
#import "TGHttpArgu.h"
#import "BLEncodeHelper.h"
#import "TGStaticTool.h"

#define K_JT_token                  @"token"//定义token

#define validateString(string) ([string isKindOfClass:[NSString class]] && [string length])

@interface TGHttpClient()

@property (nonatomic, strong) NSMutableDictionary *requestMapping;
@property (nonatomic, strong) NSMutableDictionary *operationDictionary;

@end

@implementation TGHttpClient

#pragma mark - Singleton单例模式
+ (instancetype)sharedClient
{
    static TGHttpClient *client = nil;
    static dispatch_once_t onceToken; //线程仅运行一次
    
    
    dispatch_once(&onceToken, ^{
        if (client == nil) {
            client = [[super allocWithZone:NULL] init];
            client.operationDictionary = [NSMutableDictionary dictionary];
        }
    });
    
    return client;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    return [self sharedClient];
}

- (id)copy
{
    return self;
}

#pragma mark - Setup HTTPS
- (AFSecurityPolicy *)setupHttpsSecurityPolicy
{
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    return securityPolicy;
}

#pragma mark - start request
+ (void)startRequest:(TGHttpParams *)params
             success:(void (^)(id _Nonnull))successHandler
             failure:(void (^)(NSError * _Nonnull))failureHander
{
    TGHttpClient *client = [TGHttpClient sharedClient]; //创建HttpClient单例模式
    
    //check params
    if(![client verifyParams:params])
    {
        return;
    }
    
    if(![client verifyIdentifier:params])
    {
        return;
    }
    
    switch (params.method) {
        case TGHttpMethodPost:
        {
            NSString *formattedUrl = [client formatGetUrl:params];
            NSLog(@"%@",formattedUrl);
            NSDictionary *paramsDic = [client formatGetParams:params];
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:paramsDic options:NSJSONWritingPrettyPrinted error:nil];
            NSString *jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
            NSLog(@"---mParam--%@",jsonString);
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            //将token封装入请求头
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] objectForKey:K_JT_token] forHTTPHeaderField:@"token"];
            manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/json", @"text/javascript",@"image/jpeg",@"text/plain",@"multipart/form-data", nil];
            [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
            manager.requestSerializer.timeoutInterval = 15.0f;
            [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
            
            
            NSURLSessionTask *task = [manager POST:formattedUrl parameters:paramsDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (!responseObject)
                {
                    NSError *error = [NSError errorWithDomain:@"获取数值为nil" // 域名
                                                         code:01           // 错误代码
                                                     userInfo:nil];        // 字典描
                    failureHander(error);
                }
                else
                {
                    if (successHandler) {
                        
                        successHandler(responseObject);
                        
                    }
                    NSData *responseData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
                    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
                    NSLog(@"GLHResponse:%@",responseString);
                }
                [client removeRequestFromMapping:params];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failureHander) {
                    failureHander(error);
                }
                NSLog(@"GLH%@",error);
                [client removeRequestFromMapping:params];
            }];
            [client addOperation:task withIdentifier:params];
        }
            break;
        case TGHttpMethodPostImage:
        {
            NSString *formattedUrl = [client formatGetUrl:params];
            NSLog(@"%@",formattedUrl);
            NSDictionary *paramsDic = [client formatGetParams:params];
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:paramsDic options:NSJSONWritingPrettyPrinted error:nil];
            NSString *jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
            NSLog(@"---mParam--%@",jsonString);
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            //将token封装入请求头
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] objectForKey:K_JT_token] forHTTPHeaderField:@"token"];
            manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/json", @"text/javascript",@"image/jpeg",@"text/plain",@"multipart/form-data", nil];
            [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
            manager.requestSerializer.timeoutInterval = 15.0f;
            [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
            
            NSURLSessionTask *task = [manager POST:formattedUrl parameters:paramsDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                // 上传文件  服务器对应[file]
                [formData appendPartWithFileData:params.data name:@"file"  fileName:@"avatar.png" mimeType:@"image/png"];
            } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (!responseObject)
                {
                    
                } else
                {
                    if (successHandler) {
                        
                        successHandler(responseObject);
                        
                    }
                    NSData *responseData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
                    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
                    NSLog(@"GLHResponse:%@",responseString);
                }
                [client removeRequestFromMapping:params];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failureHander) {
                    failureHander(error);
                }
                NSLog(@"GLH%@",error);
                [client removeRequestFromMapping:params];
            }];
            [client addOperation:task withIdentifier:params];
            
        }
            break;
            
        case TGHttpMethodPostVideo:
        {
            NSString *formattedUrl = [client formatGetUrl:params];
            NSLog(@"%@",formattedUrl);
            NSDictionary *paramsDic = [client formatGetParams:params];
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:paramsDic options:NSJSONWritingPrettyPrinted error:nil];
            NSString *jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
            NSLog(@"---mParam--%@",jsonString);
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            //将token封装入请求头
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] objectForKey:K_JT_token] forHTTPHeaderField:@"token"];
            manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/json", @"text/javascript",@"image/jpeg",@"text/plain",@"multipart/form-data", nil];
            [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
            manager.requestSerializer.timeoutInterval = 15.0f;
            [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
            
            NSURLSessionTask *task = [manager POST:formattedUrl parameters:paramsDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                // 上传文件  服务器对应[file]
                [formData appendPartWithFileData:params.data name:@"file"  fileName:@"sample.mp4" mimeType:@"video/mp4"];
            } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (!responseObject)
                {
                    
                } else
                {
                    if (successHandler) {
                        
                        successHandler(responseObject);
                        
                    }
                    NSData *responseData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
                    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
                    NSLog(@"GLHResponse:%@",responseString);
                }
                [client removeRequestFromMapping:params];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failureHander) {
                    failureHander(error);
                }
                NSLog(@"GLH%@",error);
                [client removeRequestFromMapping:params];
            }];
            [client addOperation:task withIdentifier:params];
            
        }
            break;
            
    }
}

#pragma mark - verify request

- (BOOL)verifyParams:(TGHttpParams *)params
{
    if (!validateString(params.url))
    {
        NSAssert(NO, @"Error! no http url found");
        return NO;
    }
    
    if (!validateString(params.identifier)) {
        NSAssert(NO, @"Error! no http identifier found");
        return NO;
    }
    
    return YES;
}

- (BOOL)verifyIdentifier:(TGHttpParams *)params {
    BOOL alreadyInList = NO;
    
    NSString *identifier = params.identifier;
    if ([self.requestMapping objectForKey:identifier]) {
        alreadyInList = YES;
    } else {
        alreadyInList = NO;
        [self addRequestToMapping:params];
    }
    
    return !alreadyInList;
}

- (NSString *)formatGetUrl:(TGHttpParams *)params {
    NSString *url = params.url;
    NSString *urlFormatted = url;
    //    CXZHttpArgu *signArgu = [[CXZHttpArgu alloc] initWithKey:@"token" value:@"tengri"];
    NSMutableArray *argus = [params.getArgus mutableCopy];
    //    [argus addObject:signArgu];
    params.getArgus = argus;
    
    //encode arguments
    NSMutableArray *argusArr = [NSMutableArray array];
    for (TGHttpArgu *argu in params.getArgus) {
        if (!validateString(argu.key)) {
            continue;
        }
        if (!validateString(argu.value)) {
            continue;
        }
        NSString *encodedArgu = [self encodeArgument:argu.value];
        [argusArr addObject:[NSString stringWithFormat:@"%@=%@", argu.key, encodedArgu]];
    }
    
    //create arguments string
    NSInteger count = [argusArr count];
    if (count) {
        NSMutableString *argusStr = [NSMutableString string];
        [argusStr appendString:@"?"];
        for (int i = 0; i < count; i++) {
            NSString *arguStr = argusArr[i];
            [argusStr appendString:arguStr];
            if (i != count - 1) {
                [argusStr appendString:@"&"];
            }
        }
        urlFormatted = [NSString stringWithFormat:@"%@%@", url, argusStr];
    }
    NSLog(@"%@", urlFormatted);
    
    return urlFormatted;
}
- (NSDictionary *)formatGetParams:(TGHttpParams *)params {
    
    NSMutableArray *argus = [params.argus mutableCopy];
    params.argus = argus;
    
    //encode arguments
    NSMutableDictionary *argusDic = [NSMutableDictionary dictionary];
    for (TGHttpArgu *argu in params.argus) {
        if (!validateString(argu.key)) {
            continue;
        }
        if (!validateString(argu.value)) {
            continue;
        }
        [argusDic setObject:argu.value forKey:argu.key];
    }
    
    //create arguments string
    
    return argusDic;
}

- (NSString *)encodeArgument:(NSString *)argu {
    return [BLEncodeHelper urlEncode:argu];
}

- (NSString *)signParams:(TGHttpParams *)params {
    
    //sort argus array
    NSArray *argus = params.argus;
    NSArray *sortedArgus = [argus sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSString *key1 = ((TGHttpArgu *)obj1).key;
        NSString *key2 = ((TGHttpArgu *)obj2).key;
        return [key1 compare:key2];
    }];
    
    //create string
    NSMutableString *sortedStr = [NSMutableString string];
    for (TGHttpArgu *argu in sortedArgus) {
        [sortedStr appendFormat:@"%@%@", argu.key, argu.value];
    }
    
    //md5
    NSString *appSecret = @"heyBand";
    NSString *fullString = [NSString stringWithFormat:@"%@%@", sortedStr, appSecret];
    NSString *sign = [TGStaticTool md5:fullString];
    
    return sign;
}


#pragma mark - request mapping

- (void)addRequestToMapping:(TGHttpParams *)params {
    [self.requestMapping setObject:@(YES) forKey:params.identifier];
}

- (void)removeRequestFromMapping:(TGHttpParams *)params {
    [self.requestMapping removeObjectForKey:params.identifier];
}

#pragma mark - operation

- (void)addOperation:(NSURLSessionTask *)operation withIdentifier:(TGHttpParams *)params {
    // Identifier与url其他部分以_分割，目前参数没有以_命名
    NSString *identifier = [[params.identifier componentsSeparatedByString:@"_"] lastObject];
    TGHttpClient *client = [TGHttpClient sharedClient];
    
    NSMutableArray *array;
    if (!client.operationDictionary[identifier]) {  //不存在当前界面的请求
        array = [NSMutableArray array];
    } else {
        array = client.operationDictionary[identifier];
    }
    
    [array addObject:operation];
    client.operationDictionary[identifier] = array;
}

+ (void)cancelOperationsByIdentifier:(id)identifier {
    TGHttpClient *client = [TGHttpClient sharedClient];
    NSArray *operations = client.operationDictionary[NSStringFromClass([identifier class])];
    [operations makeObjectsPerformSelector:@selector(cancel)];
    [client.operationDictionary removeObjectForKey:identifier];
}


@end

@implementation TGPostBody


@end
