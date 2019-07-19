package com.example.tk_suixi_news.api;

import android.util.Log;

import com.blankj.utilcode.util.LogUtils;
import com.example.tk_suixi_news.common.Contacts;
import com.example.tk_suixi_news.util.JsonHandleUtils;

import java.io.IOException;
import java.nio.charset.Charset;
import java.util.concurrent.TimeUnit;

import okhttp3.FormBody;
import okhttp3.Interceptor;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;
import okhttp3.ResponseBody;
import okio.BufferedSource;
import retrofit2.Retrofit;
import retrofit2.adapter.rxjava2.RxJava2CallAdapterFactory;
import retrofit2.converter.gson.GsonConverterFactory;


/**
 * Retrofit 辅助类
 */

public class RetrofitHelper {
    private static String TGA = "RetrofitHelper";
    private long CONNECT_TIMEOUT = 60L;
    private long READ_TIMEOUT = 30L;
    private long WRITE_TIMEOUT = 30L;
    private static RetrofitHelper mInstance = null;
    private Retrofit mRetrofit = null;


    public static RetrofitHelper getInstance(String token) {
        synchronized (RetrofitHelper.class) {
            if (mInstance == null) {
                mInstance = new RetrofitHelper(token);
            }
        }
        return mInstance;
    }

    private RetrofitHelper(String token) {
        init(token);
    }

    private void init(String token) {
        resetApp(token);
    }

    private void resetApp(String token) {
        mRetrofit = new Retrofit.Builder()
                .baseUrl(Contacts.DEV_BASE_URL)
                .client(getOkHttpClient(token))
                .addConverterFactory(GsonConverterFactory.create())
                .addCallAdapterFactory(RxJava2CallAdapterFactory.create())
                .build();
    }


    /**
     * 获取OkHttpClient实例
     *
     * @return
     */

    private OkHttpClient getOkHttpClient(String token) {
        OkHttpClient okHttpClient = new OkHttpClient.Builder()
                .retryOnConnectionFailure(true)
                .connectTimeout(CONNECT_TIMEOUT, TimeUnit.SECONDS)
                .readTimeout(READ_TIMEOUT, TimeUnit.SECONDS)
                .writeTimeout(WRITE_TIMEOUT, TimeUnit.SECONDS)
                .addInterceptor(new RqInterceptor(token))
                .addInterceptor(new ResponseInterceptor())
                .addInterceptor(new LoggingInterceptor())
                .build();
        return okHttpClient;
    }


    private static final String TAG = "RetrofitHelper";

    /**
     * 添加返回结果统一处理拦截器
     */
    private class ResponseInterceptor implements Interceptor {

        @Override
        public Response intercept(final Chain chain) throws IOException {
            // 原始请求
            Request request = chain.request();
            Response response = chain.proceed(request);
            ResponseBody responseBody = response.body();
            BufferedSource source = responseBody.source();
            source.request(Long.MAX_VALUE);
            String respString = source.buffer().clone().readString(Charset.defaultCharset());
//            BaseResult<Object> result = new Gson().fromJson(respString, BaseResult.class);

            return response;

        }
    }

    /**
     * 请求拦截器
     */
    private class RqInterceptor implements Interceptor {

        private String token;
        public RqInterceptor(String token) {
            this.token = token;
        }

        @Override
        public Response intercept(Interceptor.Chain chain) throws IOException {
            Request request = chain.request()
                    .newBuilder()
                    .addHeader("token", token)
                    .addHeader("X-APP-TYPE", "android")
                    .build();
            Response response = chain.proceed(request);
            return response;
        }
    }

    /**
     * 日志拦截器
     */
    private class LoggingInterceptor implements Interceptor {
        @Override
        public Response intercept(Chain chain) throws IOException {
            Request request = chain.request();
            long t1 = System.nanoTime();//请求发起的时间

            String method = request.method();
            if ("POST".equals(method)) {
                StringBuilder sb = new StringBuilder();
                if (request.body() instanceof FormBody) {
                    FormBody body = (FormBody) request.body();
                    for (int i = 0; i < body.size(); i++) {
                        sb.append(body.encodedName(i))
                                .append("=")
                                .append(body.encodedValue(i))
                                .append(",");
                    }
                    sb.delete(sb.length() - 1, sb.length());
                    Log.d("---POST---",
                            String.format("发送请求 %s on %s %n%s %nRequestParams:{%s}",
                                    request.url(),
                                    chain.connection(),
                                    request.headers(),
                                    sb.toString()));
                }
            } else {
                Log.d("---GET---", String.format("发送请求 %s on %s%n%s",
                        request.url(),
                        chain.connection(),
                        request.headers()));
            }


            Response response = chain.proceed(request);
            long t2 = System.nanoTime();//收到响应事件

            ResponseBody responseBody = response.peekBody(1024 * 1024);//关键代码

            String responseString = JsonHandleUtils.jsonHandle(responseBody.string());
            LogUtils.d(String.format("接收响应: [%s] %n返回json:【%s】 %.1fms %n%s",
                    response.request().url(),
                    responseString,
                    (t2 - t1) / 1e6d,
                    response.headers()
            ));

            return response;
        }
    }


    public ApiService getServer() {
        return mRetrofit.create(ApiService.class);
    }
}
