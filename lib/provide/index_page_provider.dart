import 'dart:async';

class IndexPageProvider {
  StreamController<int> _streamController;
  Stream<int> _stream;
  int _currentIndex; //当前页面的索引

  IndexPageProvider() {
    _streamController = StreamController<int>.broadcast();
    _stream = _streamController.stream;
    _currentIndex = 0; //默认首页
  }

  //获取stream
  Stream<int> get stream => _stream;

  //获取当前索引
  int get currentIndex => _currentIndex;

  //更改页面的首页index
  changeIndexPage(int index){
    _currentIndex = index;
    _streamController.sink.add(_currentIndex);
  }

  dispose(){
    _streamController.close();
  }
}