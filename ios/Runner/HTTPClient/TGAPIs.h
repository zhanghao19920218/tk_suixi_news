//
//  TGAPIs.h
//  HTTPClientOS
//
//  Created by Barry Allen on 2019/3/11.
//  Copyright © 2019 Barry Allen. All rights reserved.
//

#ifndef TGAPIs_h
#define TGAPIs_h

#define K_URL_getCode                @"api/login/getcode" //获取验证码
#define K_URL_login                  @"api/login/login"   //登录
#define K_URL_cartypelist            @"api/info/getcartypelist"   //获取所有车型接口
#define K_URL_carformats             @"api/info/getcarformats" //车型规格列表接口
#define K_URL_uploadFile             @"api/file/upload" //文件上传接口
#define K_URL_memberInfo             @"api/member/get" //获取用户详情
#define K_URL_editMember             @"api/member/edit" //编辑用户接口
#define K_URL_carInfo                @"api/car/carinfo" //司机端获取当前绑定车辆详情
#define K_URL_saveCarInfo            @"api/car/save" //司机端车辆注册(绑定)接口
#define K_URL_carorderlist           @"api/order/carorderlist" //司机端接单列表(分页接口)
#define K_URL_ordertaking            @"api/order/ordertaking" //司机接单接口
#define K_URL_setCarstate            @"api/car/setcarstate" //司机端设置车辆接单状态
#define K_URL_driverOrderList        @"api/order/driverorderlist" //司机端订单列表(分页接口)
#define K_URL_orderDetailInfo        @"api/order/orderdetail" //获取订单详情接口
#define K_URL_getmessage             @"api/message/getmessage" //获取历史消息接口
#define K_URL_carConfirm             @"api/order/carconfirm"  //车辆到达取货地点
#define K_URL_messageCount           @"api/message/messagecount" //获取未读消息数量
#define K_URL_getnormalTrucktype     @"api/info/gettype" //获取常用发货类型接口
#define K_URL_orderrecovery          @"api/order/orderrecovery" //司机端发送订单核实
#define K_URL_orderConfirm           @"api/order/orderconfirm" //司机发起确认收货
#define K_URL_retrycode              @"api/order/retrycode" //司机端重新发送验证码
#define K_URL_codepay                @"api/order/codepay" //订单扫码支付接口
#define K_URL_unbind                 @"api/car/unbind" //司机端解绑车辆
#define K_URL_moneyDetails           @"api/member/getmoneydetail" //获得明细接口
#define K_URL_getCashOut             @"api/member/cash" //用户提现接口
#define K_URL_cancelOrder            @"api/order/ordercancel" //取消订单
#define K_URL_getCarState            @"api/car/getcarstate" //司机端获取当前车辆状态
#define K_URL_setCarLoad             @"api/car/setcarload" //司机端设置车辆负载状态
#define K_URL_totalCount             @"api/car/countdata" //司机端获取统计数据
#define K_URL_orderthumb             @"api/order/orderthumb" //获取订单照片
#define K_URL_recoverythumb          @"api/order/recoverythumb" //获核实记录照片
#define K_URL_appconfig              @"api/info/appconfig" //获取APP配置
#define K_URL_cancelreason           @"api/order/cancelreason" //获取订单取消原因
#define K_URL_appversion             @"api/info/appversion" //获取APP版本号
#define K_URL_confirmLogisterOrder   @"api/order/ordercodeconfirm" //司机直接发起确认收货
#define K_URL_detailsPrices          @"api/order/orderprice" //获取订单价格明细
#define K_URL_getfeestandard         @"api/info/getfeestandard" //获取车型规格收费标准接口
#define K_URL_getcarformat           @"api/info/getcarformat" //获取车型规格详情接口
#define K_URL_ordersignature         @"api/order/ordersignature" //司机端手签
#define K_URL_payment                @"api/order/pay" //订单支付接口

#endif /* TGAPIs_h */
