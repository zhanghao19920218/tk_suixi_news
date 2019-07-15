import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tk_suixi_news/services/service_method.dart';
import 'package:tk_suixi_news/provide/send_images_page_provider.dart';
import 'package:tk_suixi_news/model/file_upload_model.dart';
import 'package:image_picker/image_picker.dart';

const BaseUrl = 'http://medium.tklvyou.cn/'; //视频播放的基本地址

class BottomShootSheetAlert extends StatelessWidget {
  final List<String> _list = ['拍照', '从手机相册选择', '取消'];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(311),
      width: ScreenUtil().setWidth(750),
      child: Column(
        children: <Widget>[
          _alertViewItem(0, context),
          _alertViewItem(1, context),
          Container(
            height: ScreenUtil().setHeight(10),
            color: Colors.black12,
          ),
          _alertViewItem(2, context),
        ],
      ),
    );
  }

  //设置一个Item
  Widget _alertViewItem(int index, BuildContext context) {
    BoxDecoration border = null;
    if (index == 0) {
      border = BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black12, width: 1)));
    }

    return Container(
        padding: const EdgeInsets.only(left: 13, right: 13),
        height: ScreenUtil().setHeight(100),
        child: InkWell(
          onTap: () {
            if (index == 0) {
              //如果是1拍摄就显示下个页面
              addPhotosEvent(context);
            }

            if (index == 1) {
              //从相册选择照片
              addPhotoImage(context); 
            }

            if (index == 2) {
              Navigator.pop(context);
            }
          },
          child: Container(
            decoration: border,
            child: Center(
              child: Text(
                _list[index],
                style: TextStyle(fontSize: ScreenUtil().setSp(32)),
              ),
            ),
          ),
        ));
  }

  //跳转直播的页面
  //点击增加图片的事件
  Future addPhotosEvent(BuildContext context) async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    print('更新页面');
    if (image == null) {
      //没有照片直接返回
      return;
    }

    FormData formData = new FormData.from({
      "file": new UploadFileInfo(image, "avatar.png"),
    });

    Http.request('uploadFile', formData: formData).then((val) {
      print('刷新页面了');
      UploadFileModel model = UploadFileModel.fromJson(val);
      //成功后更新图片
      if (model.code == 1) {
        print('更细图片');
        Provider.of<SendImagesPageProvider>(context)
            .setImage(BaseUrl + model.data.url);
        Navigator.pop(context); //关闭子页面
      }
    });
  }
 
  //从相册里面选择
  Future addPhotoImage(BuildContext context) async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    print('更新页面');
    if (image == null) {
      //没有照片直接返回
      return;
    }

    FormData formData = new FormData.from({
      "file": new UploadFileInfo(image, "avatar.png"),
    });

    Http.request('uploadFile', formData: formData).then((val) {
      print('刷新页面了');
      UploadFileModel model = UploadFileModel.fromJson(val);
      //成功后更新图片
      if (model.code == 1) {
        print('更细图片');
        Provider.of<SendImagesPageProvider>(context)
            .setImage(BaseUrl + model.data.url);
        Navigator.pop(context); //关闭子页面
      }
    });
  }
}
