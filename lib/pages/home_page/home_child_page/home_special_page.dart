import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tk_suixi_news/pages/home_page/special_home_page/special_diy_swiper_item.dart';
import 'package:tk_suixi_news/model/video_show_model.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart'; //刷新页面
import 'package:flutter_easyrefresh/bezier_circle_header.dart';
import 'package:flutter_easyrefresh/bezier_bounce_footer.dart';
import 'package:tk_suixi_news/pages/show_page/show_page_list_item.dart';
import 'package:tk_suixi_news/provide/home_special_page_provider.dart';
import 'package:tk_suixi_news/pages/normal_page/loading_without_data.dart';

class HomeSpecialPage extends StatelessWidget {
  final GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  final GlobalKey<RefreshHeaderState> _headerKey =
      new GlobalKey<RefreshHeaderState>();
  final GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();

  final String title; //获取当前页面的请求标题
  HomeSpecialPage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //请求网络数据
    Provider.of<HomeSpecialPageProvider>(context).sendVVideoPort('V视频', () {});

    return Container(
      width: ScreenUtil().setWidth(750),
      child: StreamBuilder(
        builder: (BuildContext context,
            AsyncSnapshot<List<VideoVPlayerListModel>> snapshot) {
          if (snapshot.hasData) {
            return _listBuilder(snapshot.data);
          } else {
            return emptyDataWidget();
          }
        },
        stream: Provider.of<HomeSpecialPageProvider>(context).stream,
      ),
    );
  }

  //获取一个页面
  Widget _listBuilder(List<VideoVPlayerListModel> datas) {
    return ListView.builder(
      itemCount: 1 + datas.length, //页面的数量
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return SpecialDiySwiperItem(); //显示Banner的view
        }
        return ShowPageListItem(
          video_first_img: datas[index - 1].image,
          video_desc: datas[index - 1].name,
          video_length: '09:53',
          avatar: datas[index - 1].avatar,
          nick_name: datas[index - 1].nickname,
          commentNum: int.parse(datas[index - 1].commentNum),
          goodLookNum: int.parse(datas[index - 1].likeNum),
          videoUrl: datas[index - 1].video,
          videoId: datas[index - 1].id,
        );
      },
    );
  }
}
