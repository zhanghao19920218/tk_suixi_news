//
//  TGHttpParamsManager.h
//  HTTPClientOS
//
//  Created by Barry Allen on 2019/3/11.
//  Copyright © 2019 Barry Allen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TGHttpMethod) {
    TGHttpMethodGet,
    TGHttpMethodPost,
    TGHttpMethodPostImage
};

@class TGHttpParams;

@interface TGHttpParamsManager : NSObject

#pragma mark - 获取手机验证码
/*
 * 获取手机验证码
 * 请求方式: POST
 * @param mobile: 电话号码
 * @param identifier: Controller控制器
 */
+ (TGHttpParams *)loginVC_getCode:(NSString *)mobile
                               By:(id)identifier;

#pragma mark - 验证登录
/*
 * 验证登录
 * 请求方式: POST
 * @param mobile: 电话号码
 * @param code: 验证码
 * @param login_type: 区分用户端1是用户端,2是司机端
 * @param identifier: Controller控制器
 */
+ (TGHttpParams *)loginVC_verifiedLogin:(NSString *)mobile
                               withCode:(NSString *)code
                          WithLoginType:(NSString *)loginCode
                                     By:(id)identifier;

#pragma mark - 获取所有车型接口
/*
 * 获取所有车型接口
 * 请求方式: POST
 * @param identifier: Controller控制器
 */
+ (TGHttpParams *)getCarTypeListBy:(id)identifier;

#pragma mark -  获取车型规格列表接口
/*
 * 获取车型规格列表接口
 * 请求方式: POST
 * @param cate_id: 车型ID
 * @param length:车长
 * @param identifier: Controller控制器
 */
+ (TGHttpParams *)getCarFormatsWithCateId:(NSString *)cate_id
                               WithLength:(NSString *)length
                                       By:(id)identifier;

#pragma mark - 上传文件的接口
/*
 * 上传文件的接口
 * 请求方式: POST
 * @param identifier: Controller控制器
 */
+ (TGHttpParams *)uploadFileInformationWithData:(NSData *)data
                                             By:(id)identifier;

#pragma mark - 获取用户详情
/*
 * 获取用户详情
 * 请求方式: POST
 * @param identifier: Controller控制器
 */
+ (TGHttpParams *)getUserDetailInformationBy:(id)identifier;

#pragma mark - 编辑用户接口
/*
 * 编辑用户接口
 * 请求方式: POST
 * @param identifier: Controller控制器
 */
+ (TGHttpParams *)editMemberInfoWithName:(NSString *)name
                                NickName:(NSString *)nickname
                                  avatar:(NSString *)avatar
                                     sex:(NSString *)sex
                                idNumber:(NSString *)id_number
                             idCardFront:(NSString *)id_card_front
                              idCardBack:(NSString *)id_card_back
                                    bank:(NSString *)bank
                                 driveId:(NSString *)driver_id
                              driverYear:(NSString *)driver_year
                               driverTax:(NSString *)tax
                                   title:(NSString *)title
                                   scene:(NSString *)scene
                                      By:(id)identifier;


#pragma mark - 司机端获取当前绑定车辆详情
/*
 * 司机端获取当前绑定车辆详情
 * 请求方式: POST
 * @param identifier: Controller控制器
 */
+ (TGHttpParams *)getUserCarIdentifierInformationBy:(id)identifier;

#pragma mark - 司机端车辆注册(绑定)接口
/*
 * 司机端车辆注册(绑定)接口
 * 请求方式: POST
 * @param identifier: Controller控制器
 */
+ (TGHttpParams *)saveUserCarIdentifierInformationFormatID:(NSString *)format_id
                                                    number:(NSString *)number
                                                      name:(NSString *)name
                                                     thumb:(NSString *)thumb
                                                  motor_id:(NSString *)motor_id
                                               carriage_id:(NSString *)carriage_id
                                                    weight:(NSString *)weight
                                                      bulk:(NSString *)bulk
                                                        By:(id)identifier;

#pragma mark -  司机端接单列表(分页接口)
/*
 * 司机端订单列表(分页接口)
 * 请求方式: POST
 * @param identifier: Controller控制器
 */
+ (TGHttpParams *)getCurrentOrderListWithType:(NSString *)type_id
                                     WithPage:(NSString *)page
                                           By:(id)identifier;

#pragma mark - 司机接单接口
/*
 * 司机接单接口(分页接口)
 * 请求方式: POST
 * @param identifier: Controller控制器
 */
+ (TGHttpParams *)driverConfirmOrderListPortWithOrderId:(NSString *)order_id
                                                 refuse:(NSString *)refuse
                                                     By:(id)identifier;

#pragma mark - 司机端设置车辆接单状态
/*
 * 司机端设置车辆接单状态
 * 请求方式: POST
 * @param identifier: Controller控制器
 */
+ (TGHttpParams *)driverClientSettingDriverStatusByCurrent:(NSString *)current
                                                        By:(id)identifier;

#pragma mark - 司机端订单列表(分页接口)
/*
 * 司机端订单列表(分页接口)
 * 请求方式: POST
 * @param identifier: Controller控制器
 */
+ (TGHttpParams *)getDriverOrderListWithTypeId:(NSString *)type_id
                                   WithPageNum:(NSString *)page
                                            By:(id)identifier;

#pragma mark - 获取订单详情接口
/*
 * 获取订单详情接口
 * 请求方式: POST
 * @param identifier: Controller控制器
 */
+ (TGHttpParams *)getDetailOrderInformationWithOrderId:(NSString *)order_id
                                                    By:(id)identifier;

#pragma mark - 获取历史消息接口
/*
 * 获取历史消息接口
 * 请求方式: POST
 * @param identifier: Controller控制器
 */
+ (TGHttpParams *)getHistoryMessagesPortWithNum:(NSString *)num
                                           page:(NSString *)page
                                           item:(NSString *)item
                                             By:(id)identifier;

#pragma mark - 车辆到达取货地址
/*
 * 车辆到达取货地址
 * 请求方式: POST
 * @param identifier: Controller控制器
 */
+ (TGHttpParams *)carsTruckArriveAtPickAddressWithOrderId:(NSString *)order_id
                                                       By:(id)identifier;

#pragma mark - 获取未读消息数量
/*
 * 获取未读消息数量
 * 请求方式: POST
 * @param identifier: Controller控制器
 */
+ (TGHttpParams *)unreadMessageCountValueByItem:(NSString *)item
                                             By:(id)identifier;

#pragma mark - 获取常用发货类型接口
/*
 * 获取常用发货类型接口
 * 请求方式: POST
 * @param identifier: Controller控制器
 */
+ (TGHttpParams *)getUsualTruckTypePortBy:(id)identifier;

#pragma mark - 司机端发送订单核实
/*
 * 司机端发送订单核实
 * 请求方式: POST
 * @param identifier: Controller控制器
 */
+ (TGHttpParams *)driverClientSendOrderConfirmWithOrderId:(NSString *)order_id
                                                   typeId:(NSString *)type
                                                   weight:(NSString *)weight
                                                     size:(NSString *)size
                                                     bulk:(NSString *)bulk
                                                      btw:(NSString *)btw
                                                    thumb:(NSString *)thumb
                                             packages_num:(NSString *)packages_num
                                                       By:(id)identifier;

#pragma mark - 司机端订单异常
/*
 * 司机端订单异常
 * 请求方式: POST
 * @param identifier: Controller控制器
 */
+ (TGHttpParams *)driverSendOrderDetailAbnormalWithOrderId:(NSString *)order_id
                                                       btw:(NSString *)btw
                                                     thumb:(NSString *)thumb
                                             abnormal_type:(NSString *)abnormal_type
                                                 is_normal:(NSString *)is_normal
                                                        By:(id)identifier;

#pragma mark - 司机发起确认收货
/*
 * 司机发起确认收货
 * 请求方式: POST
 * @param identifier: Controller控制器
 */
+ (TGHttpParams *)driverClientConfirmValidationCargoWithOrderId:(NSString *)order_id
                                                    ConfirmCode:(NSString *)confirmCode
                                                         mobile:(NSString *)mobile_phone
                                                            key:(NSString *)key
                                                             By:(id)identifier;

#pragma mark - 司机端重新发送验证码
/*
 * 司机端重新发送验证码
 * 请求方式: POST
 * @param identifier: Controller控制器
 */
+ (TGHttpParams *)driverClientResendVerifitedCodeWithOrderId:(NSString *)order_id
                                                         key:(NSString *)key
                                                          By:(id)identifier;

#pragma mark - 订单扫码支付接口
/*
 * 订单扫码支付接口
 * 请求方式: POST
 * @param identifier: Controller控制器
 */
+ (TGHttpParams *)driverClientOrderNeedCodeScanPayWithOrderId:(NSString *)order_id
                                                   andGateway:(NSString *)gateway
                                                           By:(id)identifier;

#pragma mark - 司机端解绑车辆
/*
 * 司机端解绑车辆
 * 请求方式: POST
 * @param identifier: Controller控制器
 */
+ (TGHttpParams *)driverClientUnbidCarsBy:(id)identifier;


#pragma mark - 获得明细接口
/*
 * 获得明细接口
 * 请求方式: POST
 * @param identifier: Controller控制器
 */
+ (TGHttpParams *)getDriverDetailsMoneyListWithType:(NSString *)type_id
                                               andP:(NSString *)page
                                                 By:(id)identifier;

#pragma mark - 用户提现接口
/*
 * 用户提现接口
 * 请求方式: POST
 * @param identifier: Controller控制器
 */
+ (TGHttpParams *)userGetCashMoneySuccessfullyWithPrice:(NSString *)price
                                                   bank:(NSString *)bank_card
                                                     By:(id)identifier;

#pragma mark - 取消订单
/*
 * 取消订单
 * 请求方式: POST
 * @param identifier: Controller控制器
 */
+ (TGHttpParams *)cancelOrderDetailsInfoWithOrderId:(NSString *)order_id
                                           isDriver:(NSString *)is_driver
                                             reason:(NSString *)reason
                                             advice:(NSString *)advice
                                                 By:(id)identifier;

#pragma mark - 司机端获取当前车辆状态
/*
 * 司机端获取当前车辆状态
 * 请求方式: POST
 * @param identifier: Controller控制器
 */
+ (TGHttpParams *)driverClientGetCarCurrentStatusBy:(id)identifier;

#pragma mark - 司机端设置车辆负载状态
/*
 * 司机端设置车辆负载状态
 * 请求方式: POST
 * @param identifier: Controller控制器
 */
+ (TGHttpParams *)driverClientSettingCarLoadStatusWithLoad:(NSString *)load
                                                        By:(id)identifier;

#pragma mark - 司机端获取统计数据
/*
 * 司机端获取统计数据
 * 请求方式: POST
 * @param identifier: Controller控制器
 */
+ (TGHttpParams *)driverClientGetTotalCountDataBasesBy:(id)identifier;


#pragma mark - 获取订单照片
/*
 * 获取订单照片
 * 请求方式: POST
 * @param identifier: Controller控制器
 */
+ (TGHttpParams *)getOrderDetailPhotosArrayWithOrderId:(NSString *)order_id
                                                    By:(id)identifier;


#pragma mark - 获核实记录照片
/*
 * 获核实记录照片
 * 请求方式: POST
 * @param identifier: Controller控制器
 */
+ (TGHttpParams *)getOrderRecoveryPhotosArrayWithOrderId:(NSString *)order_id
                                                      By:(id)identifier;

#pragma mark - 获取APP配置
/*
 * 获取APP配置
 * 请求方式: POST
 * @param identifier: Controller控制器
 */
+ (TGHttpParams *)getApplicationConfigureResultionWithColumn:(NSString *)column
                                                          By:(id)identifier;

#pragma mark - 获取订单取消原因
/*
 * 获取订单取消原因
 * 请求方式: POST
 * @param identifier: Controller控制器
 */
+ (TGHttpParams *)getCancelOrderReasonTitleWithReasonId:(NSString *)reason_id
                                                     By:(id)identifier;

#pragma mark - 获取APP版本号
/*
 * 获取APP版本号
 * 请求方式: POST
 * @param identifier: Controller控制器
 */
+ (TGHttpParams *)getApplicationVersionByItem:(NSString *)item
                                           By:(id)identifier;

#pragma mark - 司机直接发起确认收货
/*
 * 司机直接发起确认收货
 * 请求方式: POST
 * @param identifier: Controller控制器
 */
+ (TGHttpParams *)logitserClientConfirmOrderWithCode:(NSString *)confirm_code
                                                  By:(id)identifier;

#pragma mark - 获取订单价格明细
/*
 * 获取订单价格明细
 * 请求方式: POST
 * @param identifier: Controller控制器
 */
+ (TGHttpParams *)getOrderDetailsInformationsWithOrderId:(NSString *)orderId
                                                      By:(id)identifier;

#pragma mark - 获取车型规格收费标准接口
/*
 * 获取车型规格收费标准接口
 * 请求方式: POST
 * @param identifier: Controller控制器
 */
+ (TGHttpParams *)getCarFormatStandardFeesAccordingSizeWithId:(NSString *)format_id
                                                           By:(id)identifier;

#pragma mark - 获取车型规格详情接口
/*
 * 获取车型规格详情接口
 * 请求方式: POST
 * @param identifier: Controller控制器
 */
+ (TGHttpParams *)getCarFormatDetailInfomationWithFormatId:(NSString *)format_id
                                                        By:(id)identifier;

#pragma mark - 司机端手签
/*
 * 司机端手签
 * 请求方式: POST
 * @param identifier: Controller控制器
 */
+ (TGHttpParams *)orderSignatureHandsSuccessCode:(NSString *)confirmCode
                                       Signature:(NSString *)signature
                                              By:(id)identifier;

#pragma mark - 订单支付接口
/*
 * 司机端手签
 * 请求方式: POST
 * @param identifier: Controller控制器
 */
+ (TGHttpParams *)orderPaymentByDrivderWithItem:(NSString *)item
                                        orderId:(NSString *)orderId
                                        Gateway:(NSString *)gateway
                                             By:(id)identifier;

@end


NS_ASSUME_NONNULL_END
