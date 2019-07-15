//
//  TGHttpParamsManager.m
//  HTTPClientOS
//
//  Created by Barry Allen on 2019/3/11.
//  Copyright © 2019 Barry Allen. All rights reserved.
//

#import "TGHttpParamsManager.h"
#import "TGHttpParams.h"
#import "TGHttpArgu.h"

@implementation TGHttpParamsManager


#pragma mark - 获取手机验证码
+ (TGHttpParams *)loginVC_getCode:(NSString *)mobile
                               By:(id)identifier
{
    NSString *url = [K_URL_BASE stringByAppendingString:K_URL_getCode];
    NSMutableArray *argus = [NSMutableArray array];
    NSMutableArray *getArgus = [NSMutableArray array];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"mobile" value:mobile]];
    return [[TGHttpParams alloc] initWithUrl:url argus:argus getArgus:getArgus method:TGHttpMethodPost identifier:identifier];
}

#pragma mark - 验证登录
+ (TGHttpParams *)loginVC_verifiedLogin:(NSString *)mobile
                               withCode:(NSString *)code
                          WithLoginType:(NSString *)loginCode
                                     By:(id)identifier
{
    NSString *url = [K_URL_BASE stringByAppendingString:K_URL_login];
    NSMutableArray *argus = [NSMutableArray array];
    NSMutableArray *getArgus = [NSMutableArray array];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"mobile" value:mobile]];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"code" value:code]];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"login_type" value:loginCode]];
    return [[TGHttpParams alloc] initWithUrl:url argus:argus getArgus:getArgus method:TGHttpMethodPost identifier:identifier];
}

#pragma mark - 获取所有车型接口
+ (TGHttpParams *)getCarTypeListBy:(id)identifier
{
    NSString *url = [K_URL_BASE stringByAppendingString:K_URL_cartypelist];
    NSMutableArray *argus = [NSMutableArray array];
    NSMutableArray *getArgus = [NSMutableArray array];
    return [[TGHttpParams alloc] initWithUrl:url argus:argus getArgus:getArgus method:TGHttpMethodPost identifier:identifier];
}

#pragma mark -  获取车型规格列表接口
+ (TGHttpParams *)getCarFormatsWithCateId:(NSString *)cate_id
                               WithLength:(NSString *)length
                                       By:(id)identifier
{
    NSString *url = [K_URL_BASE stringByAppendingString:K_URL_carformats];
    NSMutableArray *argus = [NSMutableArray array];
    NSMutableArray *getArgus = [NSMutableArray array];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"id" value:cate_id]];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"long" value:length]];
    return [[TGHttpParams alloc] initWithUrl:url argus:argus getArgus:getArgus method:TGHttpMethodPost identifier:identifier];
}

#pragma mark - 上传文件的接口
+ (TGHttpParams *)uploadFileInformationWithData:(NSData *)data
                                             By:(id)identifier
{
    NSString *url = [K_URL_BASE stringByAppendingString:K_URL_uploadFile];
    NSMutableArray *argus = [NSMutableArray array];
    NSMutableArray *getArgus = [NSMutableArray array];
    return [[TGHttpParams alloc] initWithUrl:url argus:argus getArgus:getArgus data:data method:TGHttpMethodPostImage identifier:identifier];
}

#pragma mark - 获取用户详情
+ (TGHttpParams *)getUserDetailInformationBy:(id)identifier
{
    NSString *url = [K_URL_BASE stringByAppendingString:K_URL_memberInfo];
    NSMutableArray *argus = [NSMutableArray array];
    NSMutableArray *getArgus = [NSMutableArray array];
    return [[TGHttpParams alloc] initWithUrl:url argus:argus getArgus:getArgus method:TGHttpMethodPost identifier:identifier];
}

#pragma mark - 编辑用户接口
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
                                      By:(id)identifier
{
    NSString *url = [K_URL_BASE stringByAppendingString:K_URL_editMember];
    NSMutableArray *argus = [NSMutableArray array];
    NSMutableArray *getArgus = [NSMutableArray array];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"name" value:name]];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"nickname" value:nickname]];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"avatar" value:avatar]];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"sex" value:sex]];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"id_number" value:id_number]];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"id_card_front" value:id_card_front]];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"id_card_back" value:id_card_back]];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"bank" value:bank]];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"driver_id" value:driver_id]];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"driver_year" value:driver_year]];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"tax" value:tax]];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"title" value:title]];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"scene" value:@"2"]];
    return [[TGHttpParams alloc] initWithUrl:url argus:argus getArgus:getArgus method:TGHttpMethodPost identifier:identifier];
}

#pragma mark - 司机端获取当前绑定车辆详情
+ (TGHttpParams *)getUserCarIdentifierInformationBy:(id)identifier
{
    NSString *url = [K_URL_BASE stringByAppendingString:K_URL_carInfo];
    NSMutableArray *argus = [NSMutableArray array];
    NSMutableArray *getArgus = [NSMutableArray array];
    return [[TGHttpParams alloc] initWithUrl:url argus:argus getArgus:getArgus method:TGHttpMethodPost identifier:identifier];
}

#pragma mark - 司机端车辆注册(绑定)接口
+ (TGHttpParams *)saveUserCarIdentifierInformationFormatID:(NSString *)format_id
                                                    number:(NSString *)number
                                                      name:(NSString *)name
                                                     thumb:(NSString *)thumb
                                                  motor_id:(NSString *)motor_id
                                               carriage_id:(NSString *)carriage_id
                                                    weight:(NSString *)weight
                                                      bulk:(NSString *)bulk
                                                        By:(id)identifier
{
    NSString *url = [K_URL_BASE stringByAppendingString:K_URL_saveCarInfo];
    NSMutableArray *argus = [NSMutableArray array];
    NSMutableArray *getArgus = [NSMutableArray array];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"format_id" value:format_id]];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"number" value:number]];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"name" value:name]];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"thumb" value:thumb]];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"motor_id" value:motor_id]];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"carriage_id" value:carriage_id]];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"weight" value:weight]];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"bulk" value:bulk]];
    return [[TGHttpParams alloc] initWithUrl:url argus:argus getArgus:getArgus method:TGHttpMethodPost identifier:identifier];
}

#pragma mark -  司机端接单列表(分页接口)
+ (TGHttpParams *)getCurrentOrderListWithType:(NSString *)type_id
                                     WithPage:(NSString *)page
                                           By:(id)identifier
{
    NSString *url = [K_URL_BASE stringByAppendingString:K_URL_carorderlist];
    NSMutableArray *argus = [NSMutableArray array];
    NSMutableArray *getArgus = [NSMutableArray array];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"city_type" value:type_id]];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"p" value:page]];
    return [[TGHttpParams alloc] initWithUrl:url argus:argus getArgus:getArgus method:TGHttpMethodPost identifier:identifier];
}

#pragma mark - 司机接单接口
+ (TGHttpParams *)driverConfirmOrderListPortWithOrderId:(NSString *)order_id
                                                 refuse:(NSString *)refuse
                                           By:(id)identifier
{
    NSString *url = [K_URL_BASE stringByAppendingString:K_URL_ordertaking];
    NSMutableArray *argus = [NSMutableArray array];
    NSMutableArray *getArgus = [NSMutableArray array];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"order_id" value:order_id]];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"refuse" value:refuse]];
    return [[TGHttpParams alloc] initWithUrl:url argus:argus getArgus:getArgus method:TGHttpMethodPost identifier:identifier];
}

#pragma mark - 司机端设置车辆接单状态
+ (TGHttpParams *)driverClientSettingDriverStatusByCurrent:(NSString *)current
                                                        By:(id)identifier
{
    NSString *url = [K_URL_BASE stringByAppendingString:K_URL_setCarstate];
    NSMutableArray *argus = [NSMutableArray array];
    NSMutableArray *getArgus = [NSMutableArray array];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"current" value:current]];
    return [[TGHttpParams alloc] initWithUrl:url argus:argus getArgus:getArgus method:TGHttpMethodPost identifier:identifier];
}

#pragma mark - 司机端订单列表(分页接口)
+ (TGHttpParams *)getDriverOrderListWithTypeId:(NSString *)type_id
                                   WithPageNum:(NSString *)page
                                            By:(id)identifier
{
    NSString *url = [K_URL_BASE stringByAppendingString:K_URL_driverOrderList];
    NSMutableArray *argus = [NSMutableArray array];
    NSMutableArray *getArgus = [NSMutableArray array];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"type" value:type_id]];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"p" value:page]];
    return [[TGHttpParams alloc] initWithUrl:url argus:argus getArgus:getArgus method:TGHttpMethodPost identifier:identifier];
}

#pragma mark - 获取订单详情接口
+ (TGHttpParams *)getDetailOrderInformationWithOrderId:(NSString *)order_id
                                                    By:(id)identifier
{
    NSString *url = [K_URL_BASE stringByAppendingString:K_URL_orderDetailInfo];
    NSMutableArray *argus = [NSMutableArray array];
    NSMutableArray *getArgus = [NSMutableArray array];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"order_id" value:order_id]];
    return [[TGHttpParams alloc] initWithUrl:url argus:argus getArgus:getArgus method:TGHttpMethodPost identifier:identifier];
}

#pragma mark - 获取历史消息接口
+ (TGHttpParams *)getHistoryMessagesPortWithNum:(NSString *)num
                                           page:(NSString *)page
                                           item:(NSString *)item
                                             By:(id)identifier
{
    NSString *url = [K_URL_BASE stringByAppendingString:K_URL_getmessage];
    NSMutableArray *argus = [NSMutableArray array];
    NSMutableArray *getArgus = [NSMutableArray array];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"num"   value:num]];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"p"  value:page]];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"item"  value:item]];
    return [[TGHttpParams alloc] initWithUrl:url argus:argus getArgus:getArgus method:TGHttpMethodPost identifier:identifier];
}

#pragma mark - 车辆到达取货地址
+ (TGHttpParams *)carsTruckArriveAtPickAddressWithOrderId:(NSString *)order_id
                                                       By:(id)identifier
{
    NSString *url = [K_URL_BASE stringByAppendingString:K_URL_carConfirm];
    NSMutableArray *argus = [NSMutableArray array];
    NSMutableArray *getArgus = [NSMutableArray array];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"order_id"   value:order_id]];
    return [[TGHttpParams alloc] initWithUrl:url argus:argus getArgus:getArgus method:TGHttpMethodPost identifier:identifier];
}

#pragma mark - 获取未读消息数量
+ (TGHttpParams *)unreadMessageCountValueByItem:(NSString *)item
                                             By:(id)identifier
{
    NSString *url = [K_URL_BASE stringByAppendingString:K_URL_messageCount];
    NSMutableArray *argus = [NSMutableArray array];
    NSMutableArray *getArgus = [NSMutableArray array];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"item"   value:item]];
    return [[TGHttpParams alloc] initWithUrl:url argus:argus getArgus:getArgus method:TGHttpMethodPost identifier:identifier];
}

#pragma mark - 获取常用发货类型接口
+ (TGHttpParams *)getUsualTruckTypePortBy:(id)identifier
{
    NSString *url = [K_URL_BASE stringByAppendingString:K_URL_getnormalTrucktype];
    NSMutableArray *argus = [NSMutableArray array];
    NSMutableArray *getArgus = [NSMutableArray array];
    return [[TGHttpParams alloc] initWithUrl:url argus:argus getArgus:getArgus method:TGHttpMethodPost identifier:identifier];
}

#pragma mark - 司机端发送订单核实
+ (TGHttpParams *)driverClientSendOrderConfirmWithOrderId:(NSString *)order_id
                                                   typeId:(NSString *)type
                                                   weight:(NSString *)weight
                                                     size:(NSString *)size
                                                     bulk:(NSString *)bulk
                                                      btw:(NSString *)btw
                                                    thumb:(NSString *)thumb
                                             packages_num:(NSString *)packages_num
                                                       By:(id)identifier
{
    NSString *url = [K_URL_BASE stringByAppendingString:K_URL_orderrecovery];
    NSMutableArray *argus = [NSMutableArray array];
    NSMutableArray *getArgus = [NSMutableArray array];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"order_id"   value:order_id]];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"type"   value:type]];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"weight"   value:weight]];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"size"   value:size]];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"bulk"   value:bulk]];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"btw"   value:btw]];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"thumb"   value:thumb]];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"packages_num"   value:packages_num]];
    return [[TGHttpParams alloc] initWithUrl:url argus:argus getArgus:getArgus method:TGHttpMethodPost identifier:identifier];
}

#pragma mark - 司机端订单异常
+ (TGHttpParams *)driverSendOrderDetailAbnormalWithOrderId:(NSString *)order_id
                                                       btw:(NSString *)btw
                                                    thumb:(NSString *)thumb
                                            abnormal_type:(NSString *)abnormal_type
                                                is_normal:(NSString *)is_normal
                                                       By:(id)identifier
{
    NSString *url = [K_URL_BASE stringByAppendingString:K_URL_orderrecovery];
    NSMutableArray *argus = [NSMutableArray array];
    NSMutableArray *getArgus = [NSMutableArray array];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"order_id"   value:order_id]];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"abnormal_type"   value:abnormal_type]];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"btw"   value:btw]];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"thumb"   value:thumb]];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"is_normal"   value:is_normal]];
    return [[TGHttpParams alloc] initWithUrl:url argus:argus getArgus:getArgus method:TGHttpMethodPost identifier:identifier];
}

#pragma mark - 司机发起确认收货
+ (TGHttpParams *)driverClientConfirmValidationCargoWithOrderId:(NSString *)order_id
                                                    ConfirmCode:(NSString *)confirmCode
                                                         mobile:(NSString *)mobile_phone
                                                            key:(NSString *)key
                                                             By:(id)identifier
{
    NSString *url = [K_URL_BASE stringByAppendingString:K_URL_orderConfirm];
    NSMutableArray *argus = [NSMutableArray array];
    NSMutableArray *getArgus = [NSMutableArray array];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"order_id"   value:order_id]];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"confirm_code"   value:confirmCode]];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"mobile"   value:mobile_phone]];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"key"   value:key]];
    return [[TGHttpParams alloc] initWithUrl:url argus:argus getArgus:getArgus method:TGHttpMethodPost identifier:identifier];
}

#pragma mark - 司机端重新发送验证码
+ (TGHttpParams *)driverClientResendVerifitedCodeWithOrderId:(NSString *)order_id
                                                            key:(NSString *)key
                                                          By:(id)identifier
{
    NSString *url = [K_URL_BASE stringByAppendingString:K_URL_retrycode];
    NSMutableArray *argus = [NSMutableArray array];
    NSMutableArray *getArgus = [NSMutableArray array];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"order_id"   value:order_id]];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"key"   value:key]];
    return [[TGHttpParams alloc] initWithUrl:url argus:argus getArgus:getArgus method:TGHttpMethodPost identifier:identifier];
}

#pragma mark - 订单扫码支付接口
+ (TGHttpParams *)driverClientOrderNeedCodeScanPayWithOrderId:(NSString *)order_id
                                                   andGateway:(NSString *)gateway
                                                          By:(id)identifier
{
    NSString *url = [K_URL_BASE stringByAppendingString:K_URL_codepay];
    NSMutableArray *argus = [NSMutableArray array];
    NSMutableArray *getArgus = [NSMutableArray array];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"order_id"   value:order_id]];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"gateway"   value:gateway]];
    return [[TGHttpParams alloc] initWithUrl:url argus:argus getArgus:getArgus method:TGHttpMethodPost identifier:identifier];
}

#pragma mark - 司机端解绑车辆
+ (TGHttpParams *)driverClientUnbidCarsBy:(id)identifier
{
    NSString *url = [K_URL_BASE stringByAppendingString:K_URL_unbind];
    NSMutableArray *argus = [NSMutableArray array];
    NSMutableArray *getArgus = [NSMutableArray array];
    return [[TGHttpParams alloc] initWithUrl:url argus:argus getArgus:getArgus method:TGHttpMethodPost identifier:identifier];
}

#pragma mark - 获得明细接口
+ (TGHttpParams *)getDriverDetailsMoneyListWithType:(NSString *)type_id
                                               andP:(NSString *)page
                                                 By:(id)identifier
{
    NSString *url = [K_URL_BASE stringByAppendingString:K_URL_moneyDetails];
    NSMutableArray *argus = [NSMutableArray array];
    NSMutableArray *getArgus = [NSMutableArray array];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"type"   value:type_id]];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"p"   value:page]];
    return [[TGHttpParams alloc] initWithUrl:url argus:argus getArgus:getArgus method:TGHttpMethodPost identifier:identifier];
}

#pragma mark - 用户提现接口
+ (TGHttpParams *)userGetCashMoneySuccessfullyWithPrice:(NSString *)price
                                                   bank:(NSString *)bank_card
                                                     By:(id)identifier
{
    NSString *url = [K_URL_BASE stringByAppendingString:K_URL_getCashOut];
    NSMutableArray *argus = [NSMutableArray array];
    NSMutableArray *getArgus = [NSMutableArray array];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"price"   value:price]];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"bank_card"   value:bank_card]];
    return [[TGHttpParams alloc] initWithUrl:url argus:argus getArgus:getArgus method:TGHttpMethodPost identifier:identifier];
}

#pragma mark - 取消订单
+ (TGHttpParams *)cancelOrderDetailsInfoWithOrderId:(NSString *)order_id
                                           isDriver:(NSString *)is_driver
                                             reason:(NSString *)reason
                                             advice:(NSString *)advice
                                                 By:(id)identifier
{
    NSString *url = [K_URL_BASE stringByAppendingString:K_URL_cancelOrder];
    NSMutableArray *argus = [NSMutableArray array];
    NSMutableArray *getArgus = [NSMutableArray array];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"order_id" value:order_id]];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"is_driver" value:is_driver]];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"reason" value:reason]];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"advice" value:advice]];
    return [[TGHttpParams alloc] initWithUrl:url argus:argus getArgus:getArgus method:TGHttpMethodPost identifier:identifier];
}

#pragma mark - 司机端获取当前车辆状态
+ (TGHttpParams *)driverClientGetCarCurrentStatusBy:(id)identifier
{
    NSString *url = [K_URL_BASE stringByAppendingString:K_URL_getCarState];
    NSMutableArray *argus = [NSMutableArray array];
    NSMutableArray *getArgus = [NSMutableArray array];
    return [[TGHttpParams alloc] initWithUrl:url argus:argus getArgus:getArgus method:TGHttpMethodPost identifier:identifier];
}

#pragma mark - 司机端设置车辆负载状态
+ (TGHttpParams *)driverClientSettingCarLoadStatusWithLoad:(NSString *)load
                                                        By:(id)identifier
{
    NSString *url = [K_URL_BASE stringByAppendingString:K_URL_setCarLoad];
    NSMutableArray *argus = [NSMutableArray array];
    NSMutableArray *getArgus = [NSMutableArray array];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"load" value:load]];
    return [[TGHttpParams alloc] initWithUrl:url argus:argus getArgus:getArgus method:TGHttpMethodPost identifier:identifier];
}

#pragma mark - 司机端获取统计数据
+ (TGHttpParams *)driverClientGetTotalCountDataBasesBy:(id)identifier
{
    NSString *url = [K_URL_BASE stringByAppendingString:K_URL_totalCount];
    NSMutableArray *argus = [NSMutableArray array];
    NSMutableArray *getArgus = [NSMutableArray array];
    return [[TGHttpParams alloc] initWithUrl:url argus:argus getArgus:getArgus method:TGHttpMethodPost identifier:identifier];
}

#pragma mark - 获取订单照片
+ (TGHttpParams *)getOrderDetailPhotosArrayWithOrderId:(NSString *)order_id
                                                    By:(id)identifier
{
    NSString *url = [K_URL_BASE stringByAppendingString:K_URL_orderthumb];
    NSMutableArray *argus = [NSMutableArray array];
    NSMutableArray *getArgus = [NSMutableArray array];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"order_id" value:order_id]];
    return [[TGHttpParams alloc] initWithUrl:url argus:argus getArgus:getArgus method:TGHttpMethodPost identifier:identifier];
}

#pragma mark - 获核实记录照片
+ (TGHttpParams *)getOrderRecoveryPhotosArrayWithOrderId:(NSString *)order_id
                                                      By:(id)identifier
{
    NSString *url = [K_URL_BASE stringByAppendingString:K_URL_recoverythumb];
    NSMutableArray *argus = [NSMutableArray array];
    NSMutableArray *getArgus = [NSMutableArray array];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"recovery_id" value:order_id]];
    return [[TGHttpParams alloc] initWithUrl:url argus:argus getArgus:getArgus method:TGHttpMethodPost identifier:identifier];
}

#pragma mark - 获取APP配置
+ (TGHttpParams *)getApplicationConfigureResultionWithColumn:(NSString *)column
                                                          By:(id)identifier
{
    NSString *url = [K_URL_BASE stringByAppendingString:K_URL_appconfig];
    NSMutableArray *argus = [NSMutableArray array];
    NSMutableArray *getArgus = [NSMutableArray array];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"column" value:column]];
    return [[TGHttpParams alloc] initWithUrl:url argus:argus getArgus:getArgus method:TGHttpMethodPost identifier:identifier];
}

#pragma mark - 获取订单取消原因
+ (TGHttpParams *)getCancelOrderReasonTitleWithReasonId:(NSString *)reason_id
                                                     By:(id)identifier
{
    NSString *url = [K_URL_BASE stringByAppendingString:K_URL_cancelreason];
    NSMutableArray *argus = [NSMutableArray array];
    NSMutableArray *getArgus = [NSMutableArray array];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"id" value:reason_id]];
    return [[TGHttpParams alloc] initWithUrl:url argus:argus getArgus:getArgus method:TGHttpMethodPost identifier:identifier];
}

#pragma mark - 获取APP版本号
+ (TGHttpParams *)getApplicationVersionByItem:(NSString *)item
                                           By:(id)identifier
{
    NSString *url = [K_URL_BASE stringByAppendingString:K_URL_appversion];
    NSMutableArray *argus = [NSMutableArray array];
    NSMutableArray *getArgus = [NSMutableArray array];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"item" value:item]];
    return [[TGHttpParams alloc] initWithUrl:url argus:argus getArgus:getArgus method:TGHttpMethodPost identifier:identifier];
}

#pragma mark - 司机直接发起确认收货
+ (TGHttpParams *)logitserClientConfirmOrderWithCode:(NSString *)confirm_code
                                           By:(id)identifier
{
    NSString *url = [K_URL_BASE stringByAppendingString:K_URL_confirmLogisterOrder];
    NSMutableArray *argus = [NSMutableArray array];
    NSMutableArray *getArgus = [NSMutableArray array];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"confirm_code" value:confirm_code]];
    return [[TGHttpParams alloc] initWithUrl:url argus:argus getArgus:getArgus method:TGHttpMethodPost identifier:identifier];
}

#pragma mark - 获取订单价格明细
+ (TGHttpParams *)getOrderDetailsInformationsWithOrderId:(NSString *)orderId
                                                      By:(id)identifier
{
    NSString *url = [K_URL_BASE stringByAppendingString:K_URL_detailsPrices];
    NSMutableArray *argus = [NSMutableArray array];
    NSMutableArray *getArgus = [NSMutableArray array];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"order_id" value:orderId]];
    return [[TGHttpParams alloc] initWithUrl:url argus:argus getArgus:getArgus method:TGHttpMethodPost identifier:identifier];
}

#pragma mark - 获取车型规格收费标准接口
+ (TGHttpParams *)getCarFormatStandardFeesAccordingSizeWithId:(NSString *)format_id
                                                           By:(id)identifier
{
    NSString *url = [K_URL_BASE stringByAppendingString:K_URL_getfeestandard];
    NSMutableArray *argus = [NSMutableArray array];
    NSMutableArray *getArgus = [NSMutableArray array];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"id" value:format_id]];
    return [[TGHttpParams alloc] initWithUrl:url argus:argus getArgus:getArgus method:TGHttpMethodPost identifier:identifier];
}

#pragma mark - 获取车型规格详情接口
+ (TGHttpParams *)getCarFormatDetailInfomationWithFormatId:(NSString *)format_id
                                                        By:(id)identifier
{
    NSString *url = [K_URL_BASE stringByAppendingString:K_URL_getcarformat];
    NSMutableArray *argus = [NSMutableArray array];
    NSMutableArray *getArgus = [NSMutableArray array];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"id" value:format_id]];
    return [[TGHttpParams alloc] initWithUrl:url argus:argus getArgus:getArgus method:TGHttpMethodPost identifier:identifier];
}

#pragma mark - 司机端手签
+ (TGHttpParams *)orderSignatureHandsSuccessCode:(NSString *)confirmCode
                                       Signature:(NSString *)signature
                                              By:(id)identifier
{
    NSString *url = [K_URL_BASE stringByAppendingString:K_URL_ordersignature];
    NSMutableArray *argus = [NSMutableArray array];
    NSMutableArray *getArgus = [NSMutableArray array];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"confirm_code" value:confirmCode]];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"signature" value:signature]];
    return [[TGHttpParams alloc] initWithUrl:url argus:argus getArgus:getArgus method:TGHttpMethodPost identifier:identifier];
}

#pragma mark - 订单支付接口
+ (TGHttpParams *)orderPaymentByDrivderWithItem:(NSString *)item
                                        orderId:(NSString *)orderId
                                        Gateway:(NSString *)gateway
                                             By:(id)identifier
{
    NSString *url = [K_URL_BASE stringByAppendingString:K_URL_payment];
    NSMutableArray *argus = [NSMutableArray array];
    NSMutableArray *getArgus = [NSMutableArray array];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"item" value:item]];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"order_id" value:orderId]];
    [argus addObject:[[TGHttpArgu alloc] initWithKey:@"gateway" value:gateway]];
    return [[TGHttpParams alloc] initWithUrl:url argus:argus getArgus:getArgus method:TGHttpMethodPost identifier:identifier];
}

@end
