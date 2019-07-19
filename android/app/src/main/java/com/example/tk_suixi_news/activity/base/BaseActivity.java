package com.example.tk_suixi_news.activity.base;

import android.app.Activity;
import android.util.Log;
import android.widget.Toast;

/**
 * Created by hzsunyj on 2019-04-25.
 */
public abstract class BaseActivity extends Activity {

    public final static String TAG = BaseActivity.class.getSimpleName();

    protected String mVideoPath; //文件路径

    protected void showToast(String msg) {
        Log.d(TAG, "showToast" + msg);
        try {
            Toast.makeText(BaseActivity.this, msg, Toast.LENGTH_SHORT).show();
        } catch (Throwable th) {
            th.printStackTrace(); // fuck oppo
        }
    }
}
