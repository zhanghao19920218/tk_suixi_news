import 'package:dio/dio.dart';
import 'dart:async'; //异步的包
import 'dart:io';

import 'package:tk_suixi_news/config/progress_hud.dart';
import 'package:tk_suixi_news/config/services_url.dart';
import 'package:tk_suixi_news/config/share_prefrence.dart'; //没法使用变量

Dio dio;

//单例化dio
class Http {
  static Dio instance() {
    if (dio != null) {
      return dio; //实例化dio
    }
    dio = new Dio();
    //增加拦截器
    dio.interceptors.add(
      InterceptorsWrapper(
        // 接口请求前数据处理
        onRequest: (options) {
          Loading.before(options.uri, '正在加载...');
          return options;
        },
        // 接口成功返回时处理
        onResponse: (Response resp) {
          Loading.complete(resp.request.uri);
        },
        // 接口报错时处理
        onError: (DioError error) {
          Loading.complete(error.request.uri);

          return error;
        },
      ),
    );
    return dio;
  }

  //请求参数
  static Future request(url, {formData}) async {
    try {
      print('请求接口${servicePath[url]}');
      Response response;
      instance().options.contentType =
          ContentType.parse('application/x-www-form-urlencoded');
      String token = await Prefenerce.share.getToken(); //获取token
      instance().options.headers['Authorization'] = token;
      if (formData == null) {
        response = await instance().post(servicePath[url]); //异步请求成功
      } else {
        print('请求参数: ${formData.toString()}');
        response = await instance().post(servicePath[url], data: formData); //异步请求成功
      }
      if (response.statusCode == 200) {
        print('请求获取的数据:${response.data}');
        int status = response.data['code'];
        String errorMessage = response.data['errmsg'];
        if (status == 1) {
          return response.data;
        } else {
          throw errorMessage;
        }
      } else {
        throw Exception('后端接口出现异常');
      }
    } catch (e) {
      Loading.alert('${e.toString()}', 1);
      return print('ERROR: ========>$e');
    }
  }
}
