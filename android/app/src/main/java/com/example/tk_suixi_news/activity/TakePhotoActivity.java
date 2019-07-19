package com.example.tk_suixi_news.activity;

import android.Manifest;
import android.annotation.TargetApi;
import android.app.Activity;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.graphics.Bitmap;
import android.media.MediaPlayer;
import android.os.Build;
import android.os.Bundle;
import android.os.Environment;
import android.util.Log;
import android.view.View;
import android.widget.Toast;


import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import com.blankj.utilcode.util.ToastUtils;
import com.cjt2325.cameralibrary.JCameraView;
import com.cjt2325.cameralibrary.listener.ClickListener;
import com.cjt2325.cameralibrary.listener.JCameraListener;
import com.example.tk_suixi_news.R;
import com.example.tk_suixi_news.activity.base.BaseActivity;
import com.example.tk_suixi_news.api.RetrofitHelper;
import com.example.tk_suixi_news.model.BaseResult;
import com.example.tk_suixi_news.model.UploadModel;
import com.example.tk_suixi_news.util.DateUtils;
import com.example.tk_suixi_news.util.ImageUtils;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

import org.json.JSONObject;

import java.io.File;

import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.functions.Consumer;
import io.reactivex.schedulers.Schedulers;
import okhttp3.MediaType;
import okhttp3.MultipartBody;
import okhttp3.RequestBody;

public class TakePhotoActivity extends BaseActivity {

    private final int GET_PERMISSION_REQUEST = 100; //权限申请自定义码
    private JCameraView jCameraView;
    private boolean granted = false;
    private String token;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_take_photo);

        token = getIntent().getStringExtra("token");
        jCameraView = findViewById(R.id.jcameraview);

        //设置视频保存路径
        jCameraView.setSaveVideoPath(Environment.getExternalStorageDirectory().getPath() + File.separator + "JCamera");

        //JCameraView监听
        jCameraView.setJCameraLisenter(new JCameraListener() {
            @Override
            public void captureSuccess(Bitmap bitmap) {
                File file = ImageUtils.saveBitmapFile(TakePhotoActivity.this, bitmap);
                final RequestBody requestFile = RequestBody.create(MediaType.parse("image/jpeg"), file);
                MultipartBody.Part body = MultipartBody.Part.createFormData("file", file.getName(), requestFile);
                RetrofitHelper.getInstance(token).getServer()
                        .upload(body)
                        .observeOn(AndroidSchedulers.mainThread())
                        .subscribeOn(Schedulers.io())
                        .subscribe(new Consumer<BaseResult<UploadModel>>() {
                            @Override
                            public void accept(BaseResult<UploadModel> result) throws Exception {
                                ToastUtils.showShort(result.getMsg());
                                if (result.getCode() == 1) {
                                    String url = result.getData().getUrl();
                                    Intent data = new Intent();
                                    data.putExtra("imageUrl", url);
                                    data.putExtra("isSuccess", "success");
                                    data.putExtra("image", "1");
                                    setResult(Activity.RESULT_OK, data);
                                    finish();
                                }
                            }
                        }, new Consumer<Throwable>() {
                            @Override
                            public void accept(Throwable throwable) {
                                throwable.printStackTrace();
                                Intent data = new Intent();
                                data.putExtra("imageUrl", "");
                                data.putExtra("isSuccess", "failure");
                                data.putExtra("image", "1");
                                setResult(Activity.RESULT_OK, data);
                                finish();
                            }
                        });
            }

            @Override
            public void recordSuccess(String videoUrlPath, Bitmap firstFrame) {
                //获取视频首帧图片以及视频地址
                File file = ImageUtils.saveBitmapFile(TakePhotoActivity.this, firstFrame);
                final RequestBody requestFile = RequestBody.create(MediaType.parse("image/jpeg"), file);
                MultipartBody.Part body = MultipartBody.Part.createFormData("file", file.getName(), requestFile);
                RetrofitHelper.getInstance(token).getServer()
                        .upload(body)
                        .observeOn(AndroidSchedulers.mainThread())
                        .subscribeOn(Schedulers.io())
                        .subscribe(new Consumer<BaseResult<UploadModel>>() {
                            @Override
                            public void accept(BaseResult<UploadModel> result) throws Exception {
                                if (result.getCode() == 1) {
                                    String imageUrl = result.getData().getUrl();

                                    File videoFile = new File(videoUrlPath);
                                    final RequestBody requestFile = RequestBody.create(MediaType.parse("image/jpeg"), videoFile);
                                    MultipartBody.Part videoBody = MultipartBody.Part.createFormData("file", videoFile.getName(), requestFile);
                                    RetrofitHelper.getInstance(token).getServer()
                                            .upload(videoBody)
                                            .observeOn(AndroidSchedulers.mainThread())
                                            .subscribeOn(Schedulers.io())
                                            .subscribe(new Consumer<BaseResult<UploadModel>>() {
                                                @Override
                                                public void accept(BaseResult<UploadModel> result) throws Exception {
                                                    if (result.getCode() == 1) {
                                                        String videoUrl = result.getData().getUrl();
                                                        MediaPlayer meidaPlayer = new MediaPlayer();
                                                        meidaPlayer.setDataSource(videoFile.getPath());
                                                        meidaPlayer.prepare();
                                                        long time = meidaPlayer.getDuration();//获得了视频的时长（以毫秒为单位）

                                                        Intent data = new Intent();
                                                        data.putExtra("videoUrl", videoUrl);
                                                        data.putExtra("videoTimeLength", DateUtils.millsToMMss(time));
                                                        data.putExtra("imageUrl", imageUrl);
                                                        data.putExtra("isSuccess", "success");
                                                        data.putExtra("image", "2");
                                                        setResult(Activity.RESULT_OK, data);
                                                        finish();
                                                    }
                                                }
                                            }, new Consumer<Throwable>() {
                                                @Override
                                                public void accept(Throwable throwable) {
                                                    throwable.printStackTrace();
                                                    Intent data = new Intent();
                                                    data.putExtra("videoUrl", "");
                                                    data.putExtra("videoTimeLength", "");
                                                    data.putExtra("imageUrl", "");
                                                    data.putExtra("isSuccess", "failure");
                                                    data.putExtra("image", "2");
                                                    setResult(Activity.RESULT_OK, data);
                                                    finish();
                                                }
                                            });

                                }
                            }
                        }, new Consumer<Throwable>() {
                            @Override
                            public void accept(Throwable throwable) {
                                throwable.printStackTrace();
                                Intent data = new Intent();
                                data.putExtra("videoUrl", "");
                                data.putExtra("videoTimeLength", "");
                                data.putExtra("imageUrl", "");
                                data.putExtra("isSuccess", "failure");
                                data.putExtra("image", "2");
                                setResult(Activity.RESULT_OK, data);
                                finish();
                            }
                        });

            }

        });

        jCameraView.setLeftClickListener(new ClickListener() {
            @Override
            public void onClick() {
                finish();
            }
        });
        //6.0动态权限获取
        getPermissions();
    }

    @Override
    protected void onStart() {
        super.onStart();
        //全屏显示
        if (Build.VERSION.SDK_INT >= 19) {
            View decorView = getWindow().getDecorView();
            decorView.setSystemUiVisibility(
                    View.SYSTEM_UI_FLAG_LAYOUT_STABLE
                            | View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION
                            | View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN
                            | View.SYSTEM_UI_FLAG_HIDE_NAVIGATION
                            | View.SYSTEM_UI_FLAG_FULLSCREEN
                            | View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY);
        } else {
            View decorView = getWindow().getDecorView();
            int option = View.SYSTEM_UI_FLAG_FULLSCREEN;
            decorView.setSystemUiVisibility(option);
        }
    }

    @Override
    protected void onResume() {
        super.onResume();
        if (granted) {
            jCameraView.onResume();
        }
    }

    @Override
    protected void onPause() {
        super.onPause();
        jCameraView.onPause();
    }

    /**
     * 获取权限
     */
    private void getPermissions() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            if (ContextCompat.checkSelfPermission(this, Manifest.permission.WRITE_EXTERNAL_STORAGE) == PackageManager.PERMISSION_GRANTED &&
                    ContextCompat.checkSelfPermission(this, Manifest.permission.RECORD_AUDIO) == PackageManager.PERMISSION_GRANTED &&
                    ContextCompat.checkSelfPermission(this, Manifest.permission.CAMERA) == PackageManager.PERMISSION_GRANTED) {
                //具有权限
                granted = true;
            } else {
                //不具有获取权限，需要进行权限申请
                ActivityCompat.requestPermissions(TakePhotoActivity.this, new String[]{
                        Manifest.permission.WRITE_EXTERNAL_STORAGE,
                        Manifest.permission.RECORD_AUDIO,
                        Manifest.permission.CAMERA}, GET_PERMISSION_REQUEST);
                granted = false;
            }
        }
    }

    @TargetApi(23)
    @Override
    public void onRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        if (requestCode == GET_PERMISSION_REQUEST) {
            int size = 0;
            if (grantResults.length >= 1) {
                int writeResult = grantResults[0];
                //读写内存权限
                boolean writeGranted = writeResult == PackageManager.PERMISSION_GRANTED;//读写内存权限
                if (!writeGranted) {
                    size++;
                }
                //录音权限
                int recordPermissionResult = grantResults[1];
                boolean recordPermissionGranted = recordPermissionResult == PackageManager.PERMISSION_GRANTED;
                if (!recordPermissionGranted) {
                    size++;
                }
                //相机权限
                int cameraPermissionResult = grantResults[2];
                boolean cameraPermissionGranted = cameraPermissionResult == PackageManager.PERMISSION_GRANTED;
                if (!cameraPermissionGranted) {
                    size++;
                }
                if (size == 0) {
                    granted = true;
                    jCameraView.onResume();
                } else {
                    Toast.makeText(this, "请到设置-权限管理中开启", Toast.LENGTH_SHORT).show();
                    finish();
                }
            }
        }
    }
}