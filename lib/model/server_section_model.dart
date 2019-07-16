
class ServerSectionListModel {
  List<ServerSectionModel> _list;
  String _sectionImage;

  List<ServerSectionModel> get list => _list;

  String get sectionImage => _sectionImage;
  
  ServerSectionListModel(List<ServerSectionModel> list, String sectionImage) {
    this._list = list;
    this._sectionImage = _sectionImage;
  }
  
}

class ServerSectionModel {
  String _imageName;
  String _title;
  String _subTitle;

  String get imageName => this._imageName;

  String get title => this._title;

  String get subTitle => this._subTitle;
  
  ServerSectionModel(String imageName, String title, String subTitle) {
    this._imageName = imageName;
    this._title = title;
    this._subTitle = subTitle;
  }
}