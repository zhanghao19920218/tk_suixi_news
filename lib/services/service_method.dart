import 'package:dio/dio.dart';
import 'dart:async'; //异步的包
import 'dart:io';

import 'package:tk_suixi_news/config/progress_hud.dart';
import 'package:tk_suixi_news/config/services_url.dart';
import 'package:tk_suixi_news/config/share_prefrence.dart'; //没法使用变量

Dio dio;

//代理的Proxy地址
const String proxy = 'PROXY 192.168.0.101:8888';
//单例化dio
class Http {
  static Dio instance() {
    if (dio != null) {
      return dio; //实例化dio
    }
    dio = new Dio();

    //--------flutter抓包---------- // ip:port
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      // config the http client
      client.findProxy = (uri) {
        //proxy all request to localhost:8888
        return proxy;
      };
      // you can also create a new HttpClient to dio
      // return new HttpClient();
    };
    //----------------------------------------

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
      instance().options.headers['token'] = token;
      print('请求头' +instance().options.headers.toString());
      if (formData == null) {
        response = await instance().post(servicePath[url]); //异步请求成功
      } else {
        print('请求参数: ${formData.toString()}');
        response =
            await instance().post(servicePath[url], data: formData); //异步请求成功
      }
      if (response.statusCode == 200) {
        print('请求获取的数据:${response.data}');
        int status = response.data['code'];
        String errorMessage = response.data['msg'];
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
      return 'ERROR: ========>$e';
    }
  }
}
