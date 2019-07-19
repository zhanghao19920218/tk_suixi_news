package com.example.tk_suixi_news.api;

import com.example.tk_suixi_news.model.BaseResult;
import com.example.tk_suixi_news.model.UploadModel;

import io.reactivex.Observable;
import okhttp3.MultipartBody;
import retrofit2.http.Multipart;
import retrofit2.http.POST;
import retrofit2.http.Part;

public interface ApiService {

    /**
     * 单文件上传接口
     */
    @Multipart
    @POST("api/common/upload")
    Observable<BaseResult<UploadModel>> upload(@Part MultipartBody.Part file);


}