import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tk_suixi_news/pages/normal_page/bottom_shoot_sheet.dart';
import 'package:tk_suixi_news/provide/send_images_page_provider.dart';

class SendImagesItem extends StatelessWidget {
  //获取照片的数组
  // final List<String> imageUrls;

  // SendImagesItem({Key key, this.imageUrls}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(imageUrls);
    return StreamBuilder(
      stream: Provider.of<SendImagesPageProvider>(context).stream,
      builder: (context, AsyncSnapshot<List<String>> snapshot) {
        //获取一组照片的数据
        if (snapshot.hasData) {
          var lists = snapshot.data.map((val) {
            return _wrapItem(val.toString());
          }).toList();
          lists.add(_addMorePhotoItem(context));

          //更新页面
          return Container(
            width: ScreenUtil().setWidth(660),
            height: ScreenUtil().setHeight(630),
            child: Wrap(
              spacing: 10,
              children: lists,
              runSpacing: 10,
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  //显示一个ImageView的子项
  Widget _wrapItem(String imageUrl) {
    return Stack(
      children: <Widget>[
        _image(imageUrl),
        _closeBtnItem(),
      ],
    );
  }

  //显示一个照片
  Widget _image(String imageUrl) {
    return InkWell(
      onTap: () {
        print('点击了一张照片');
      },
      child: Image.network(
        imageUrl,
        width: ScreenUtil().setWidth(200),
        height: ScreenUtil().setWidth(200),
        fit: BoxFit.fill,
      ),
    );
  }

  //显示关闭的按钮
  Widget _closeBtnItem() {
    return Positioned(
      top: 5,
      left: 5,
      child: InkWell(
        onTap: () {
          print('点击了删除照片按钮');
        },
        child: Image.asset(
          'lib/assets/delete.png',
          width: ScreenUtil().setWidth(36),
          height: ScreenUtil().setHeight(36),
        ),
      ),
    );
  }

  //增加照片的item
  Widget _addMorePhotoItem(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(context:context, builder: (BuildContext context){
              return BottomShootSheetAlert();
            });
        // addPhotosEvent(context);
      },
      child: Image.asset('lib/assets/add_photo.png',
          width: ScreenUtil().setWidth(200),
          height: ScreenUtil().setWidth(200),
          fit: BoxFit.fill),
    );
  }

}
