import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../provide/home_page_tab_provider.dart';
import 'package:provider/provider.dart';

//首页上方的tabBars
class HomePageIndicator extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(82),
      width: ScreenUtil().setWidth(750),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          _homeTabBars(context),
          _addMoreBtn(),
        ],
      ),
    );
  }

  //设置点击的TextStyle
  final TextStyle _seletedStyle =
      TextStyle(color: Color.fromRGBO(255, 74, 92, 1.0));

  //设置没有点击的状态
  final TextStyle _normalStyle =
      TextStyle(color: Color.fromRGBO(136, 136, 136, 1));

  //TabBar里面的每一个项目
  Widget _homeTabBarItem(context, int index, bool isSelected, String title) {
    return Container(
      width: ScreenUtil().setWidth(110.0),
      height: ScreenUtil().setHeight(82),
      child: Center(
        child: InkWell(
          child: Text(
            title,
            style: isSelected ? _seletedStyle : _normalStyle,
          ),
          onTap: () {
            Provider.of<HomePageTabProvider>(context).changeIndexPage(index);
            //更改首页的子页面
            Provider.of<HomePageTabProvider>(context).changeParentVC(index);
          },
        ),
      ),
    );
  }

  //滚动的一个ListView
  Widget _homeTabBars(context) {
    return StreamBuilder(
      initialData: HomePageTabProviderModel(),
      stream: Provider.of<HomePageTabProvider>(context).stream,
      builder: (conext, AsyncSnapshot<HomePageTabProviderModel> snapshot) {
        return Container(
          height: ScreenUtil().setHeight(82),
          width: ScreenUtil().setWidth(670),
          child: ListView.builder(
            // controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data.titles.length,
            itemBuilder: (context, index) {
              return _homeTabBarItem(
                  context,
                  index,
                  snapshot.data.currentIndex == index,
                  snapshot.data.titles[index]);
            },
          ),
        );
      },
    );
  }

  //增加的按钮
  Widget _addMoreBtn() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      height: ScreenUtil().setHeight(82),
      width: ScreenUtil().setWidth(80),
      child: InkWell(
        child: Icon(Icons.add),
      ),
    );
  }
}
