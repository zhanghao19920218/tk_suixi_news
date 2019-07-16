import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:tk_suixi_news/pages/news_detail_page/news_detail_bottom.dart';
import 'package:tk_suixi_news/pages/news_detail_page/news_detail_commnet_item.dart';

class NewsDetailPage extends StatelessWidget {
  final TextStyle style = TextStyle(
      fontSize: ScreenUtil().setSp(26), color: Colors.black38); //观察的页面

  //获取新闻数据
  final Map _infos = {
    'title': '濉溪县第十七届人大常委会第二十二次会议于今日顺利召开',
    'writer': '发布者名称',
    'time': '8',
    'watch': '1265',
    'html': '''
    <p><span style="background-color: rgb(255, 255, 0); font-size: 55px;"><b><u>测试文字</u></b></span></p><p><span style="background-color: rgb(255, 255, 0); font-size: 36px;"><b><u>? ? 换行</u></b></span></p><p><span style="background-color: rgb(255, 255, 0);"><b><u><br></u></b></span></p><p><span style="background-color: rgb(255, 255, 0);"><b><u><br></u></b></span></p><p class="MsoNormal"><span 微软雅黑","sans-serif""="" style="font-size: 14pt;">襄缘大米，大米的革命回归。原生态、现碾现卖，实现从稻谷到餐桌只是一顿饭的功夫。<span lang="EN-US"><o:p></o:p></span></span></p><p class="MsoNormal"><span lang="EN-US" 微软雅黑","sans-serif""="" style="font-size: 14pt;"><o:p>?</o:p></span></p><p></p><p class="MsoNormal"><span 微软雅黑","sans-serif""="" style="font-size: 14pt;">襄缘三号是优质香粳，其米香味浓郁，做饭时将会满屋飘香，其香气可以消除疲劳，增进食欲。用其做的米饭粒粒晶莹剔透，熬粥更佳。虽是我大无为本地所产，她完全可以和东北大米相媲美。</span></p><p class="MsoNormal"><span 微软雅黑","sans-serif""="" style="font-size: 14pt;"><span lang="EN-US"><o:p><br></o:p></span></span></p><p><span style="background-color: rgb(255, 255, 0); font-size: 36px;"><b><u>哈哈哈哈哈</u></b></span></p><p><span style="background-color: rgb(255, 255, 0);"><b><u><br></u></b></span></p><p><span style="background-color: rgb(255, 255, 0); font-size: 36px;"><b><u>表情</u></b></span></p><p><br></p><p><img src="/uploads/20190614/02790efd0571fb4567cb3f75bf274fc3.png" data-filename="filename" style="width: 460px;"><img src="/uploads/20190614/dad009181b01a253238d89d04f518ff0.jpg" style="width: 470px;" data-filename="filename"><img src="/uploads/20190614/4a50a04ad7e943da6a0a1582861607bd.png" style="width: 470px;" data-filename="filename"><img src="/uploads/20190614/9e27698f02fedec371021dd9cd5037c8.png" data-filename="filename" style="width: 460px;"><img src="/uploads/20190614/2ba49d44fa4cce0821102267cb3360e3.jpg" data-filename="filename" style="width: 470px;"><img src="/uploads/20190614/38e93d5d19d8a6dcd9f9b15f08bff158.png" data-filename="filename" style="width: 470px;"><br></p><p><img src="https://test.ahxtao.com/uploads/20190612/b5acabd29b8596e1fe40e74dbf074869.jpg" data-filename="filename" style="width: 551px;"><br></p>

    ''',
    'commnetNum': '2368',
    'likes': '23'
  };

  //获取新闻的id
  final String news_id;

  //根据新闻id获取数据
  NewsDetailPage({Key key, this.news_id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text('文章'),
          actions: <Widget>[_favoButton()],
        ),
        body: Container(
            color: Color.fromRGBO(245, 245, 245, 1),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: _newsListView(),
                ),
                NewsDetailBottom()
              ],
            )));
  }

  //设置上方的ListView
  Widget _newsListView() {
    return Container(
      width: ScreenUtil().setWidth(750),
      child: ListView(
        children: <Widget>[
          _titlePaper(),
          _combineWirteTimeNum(),
          _loadWeb(),
          _shareContent(),
          _commentTitle(),
          NewsDetailCommnetItem(
            avatar:
                'https://b-ssl.duitang.com/uploads/item/201603/16/20160316192951_nF4jS.jpeg',
            nickname: '微信用户',
            commnetDate: '2019－09-09 23:00',
            commentDetail: '濉溪县，隶属于安徽省淮北市。位于安徽省北部，总面积1987平方公里。',
          ),
          NewsDetailCommnetItem(
            avatar:
                'https://b-ssl.duitang.com/uploads/item/201603/16/20160316192951_nF4jS.jpeg',
            nickname: '微信用户',
            commnetDate: '2019－09-09 23:00',
            commentDetail: '濉溪县，隶属于安徽省淮北市。位于安徽省北部，总面积1987平方公里。',
          ),
        ],
      ),
    );
  }

  //设置右侧的收藏按钮
  Widget _favoButton() {
    return Container(
        padding: const EdgeInsets.only(right: 23.0),
        child: InkWell(
          child: Icon(
            Icons.star,
            color: Colors.white,
            size: 30.0,
          ),
        ));
  }

  //文章标题
  Widget _titlePaper() {
    return Container(
      padding: const EdgeInsets.fromLTRB(13, 25, 13, 25),
      color: Colors.white,
      child: Text(
        _infos['title'],
        style: TextStyle(fontSize: ScreenUtil().setSp(32)),
      ),
    );
  }

  //发布者名称,时间,观看数量
  Widget _combineWirteTimeNum() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(left: 13.0, right: 13.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              _infos['writer'],
              style: style,
            ),
          ),
          _timesDate(),
          _watchTimes()
        ],
      ),
    );
  }

  //观看的数量
  Widget _watchTimes() {
    return Container(
      padding: const EdgeInsets.only(right: 0),
      child: Row(
        children: <Widget>[
          Icon(Icons.remove_red_eye, color: Colors.black38),
          Container(
            width: ScreenUtil().setWidth(16),
          ),
          Text(
            _infos['watch'],
            style: style,
          )
        ],
      ),
    );
  }

  //小时的数量
  Widget _timesDate() {
    return Container(
      padding: const EdgeInsets.only(right: 26),
      child: Text(
        '${_infos['time']}小时前',
        style: style,
      ),
    );
  }

  //设置html的webView
  Widget _loadWeb() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(13, 25, 13, 0),
      width: ScreenUtil().setWidth(700),
      child: Html(
        data: _infos['html'],
        useRichText: true,
      ),
    );
  }

  //文章收藏按钮
  Widget _shareContent() {
    return Container(
      width: ScreenUtil().setHeight(142),
      color: Colors.white,
      padding: const EdgeInsets.only(left: 26, right: 25, bottom: 27),
      child: Row(
        children: <Widget>[
          //分享到
          Expanded(
            child: Text('分享到', style: style),
          ),

          InkWell(
            onTap: () {
              print('点击了微博');
            },
            child: Image.asset(
              'lib/assets/weibo.png',
              width: ScreenUtil().setWidth(46),
              height: ScreenUtil().setHeight(37),
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(80),
          ),
          InkWell(
            onTap: () {
              print('点击了微信');
            },
            child: Image.asset(
              'lib/assets/wechat.png',
              width: ScreenUtil().setWidth(44),
              height: ScreenUtil().setHeight(36),
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(80),
          ),
          InkWell(
            onTap: () {
              print('点击了朋友圈');
            },
            child: Image.asset(
              'lib/assets/circle.png',
              width: ScreenUtil().setWidth(44),
              height: ScreenUtil().setHeight(44),
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(80),
          ),
          //显示分享标题
          InkWell(
            onTap: () {
              print('点击了QQ');
            },
            child: Image.asset(
              'lib/assets/qq.png',
              width: ScreenUtil().setWidth(42),
              height: ScreenUtil().setHeight(44),
            ),
          ),
        ],
      ),
    );
  }

  //显示评论的数量
  Widget _commentTitle() {
    return Container(
      color: Colors.white,
      height: ScreenUtil().setHeight(88),
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.only(left: 13, right: 14),
      child: Container(
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(color: Colors.black38, width: 1))),
        child: Row(
          children: <Widget>[
            //评论
            Text('评论', style: style),
            Container(
              width: ScreenUtil().setWidth(10),
            ),
            Expanded(
              child: Text(
                _infos['commnetNum'],
                style: style,
              ),
            ),

            //赞
            Text('赞', style: style),
            Container(
              width: ScreenUtil().setWidth(10),
            ),
            Text(_infos['likes'], style: style),
          ],
        ),
      ),
    );
  }
}
