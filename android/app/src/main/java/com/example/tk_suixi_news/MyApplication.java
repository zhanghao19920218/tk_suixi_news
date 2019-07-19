package com.example.tk_suixi_news;

import com.blankj.utilcode.util.Utils;

import io.flutter.app.FlutterApplication;

public class MyApplication extends FlutterApplication {

    @Override
    public void onCreate() {
        super.onCreate();
        Utils.init(this);
    }
}
