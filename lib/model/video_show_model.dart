//V视频列表的model
class VideoShowModel {
  int code;
  String msg;
  String time;
  VideoListModel data;

  VideoShowModel({this.code, this.msg, this.time, this.data});

  VideoShowModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    time = json['time'];
    data = json['data'] != null ? new VideoListModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    data['time'] = this.time;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class VideoListModel {
  int total;
  int perPage;
  int currentPage;
  int lastPage;
  List<VideoVPlayerListModel> data;

  VideoListModel({this.total, this.perPage, this.currentPage, this.lastPage, this.data});

  VideoListModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    perPage = json['per_page'];
    currentPage = json['current_page'];
    lastPage = json['last_page'];
    if (json['data'] != null) {
      data = new List<VideoVPlayerListModel>();
      json['data'].forEach((v) {
        data.add(new VideoVPlayerListModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['per_page'] = this.perPage;
    data['current_page'] = this.currentPage;
    data['last_page'] = this.lastPage;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VideoVPlayerListModel {
  String id;
  String userId;
  String adminId;
  String module;
  String moduleSecond;
  String name;
  String image;
  String images;
  String video;
  String audio;
  String content;
  String nickname;
  String avatar;
  String status;
  String visitNum;
  String commentNum;
  String likeNum;
  String createtime;
  String updatetime;
  String voteId;
  String weigh;
  String time;

  VideoVPlayerListModel(
      {this.id,
      this.userId,
      this.adminId,
      this.module,
      this.moduleSecond,
      this.name,
      this.image,
      this.images,
      this.video,
      this.audio,
      this.content,
      this.nickname,
      this.avatar,
      this.status,
      this.visitNum,
      this.commentNum,
      this.likeNum,
      this.createtime,
      this.updatetime,
      this.voteId,
      this.weigh,
      this.time});

  VideoVPlayerListModel.fromJson(Map<String, dynamic> json) {
    id = '${json['id']}';
    userId = '${json['user_id']}';
    adminId = '${json['admin_id']}';
    module = '${json['module']}';
    moduleSecond = '${json['module_second']}';
    name = '${json['name']}';
    image = '${json['image']}';
    images = '${json['images']}';
    video = '${json['video']}';
    audio = '${json['audio']}';
    content = '${json['content']}';
    nickname = '${json['nickname']}';
    avatar = '${json['avatar']}';
    status = '${json['status']}';
    visitNum = '${json['visit_num']}';
    commentNum = '${json['comment_num']}';
    likeNum = '${json['like_num']}';
    createtime = '${json['createtime']}';
    updatetime = '${json['updatetime']}';
    voteId = '${json['vote_id']}';
    weigh = '${json['weigh']}';
    time = '${json['time']}';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['admin_id'] = this.adminId;
    data['module'] = this.module;
    data['module_second'] = this.moduleSecond;
    data['name'] = this.name;
    data['image'] = this.image;
    data['images'] = this.images;
    data['video'] = this.video;
    data['audio'] = this.audio;
    data['content'] = this.content;
    data['nickname'] = this.nickname;
    data['avatar'] = this.avatar;
    data['status'] = this.status;
    data['visit_num'] = this.visitNum;
    data['comment_num'] = this.commentNum;
    data['like_num'] = this.likeNum;
    data['createtime'] = this.createtime;
    data['updatetime'] = this.updatetime;
    data['vote_id'] = this.voteId;
    data['weigh'] = this.weigh;
    data['time'] = this.time;
    return data;
  }
}
