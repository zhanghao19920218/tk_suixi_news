class MemberSignModel {
  int code;
  String msg;
  String time;
  MemeberModel data;

  MemberSignModel({this.code, this.msg, this.time, this.data});

  MemberSignModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    time = json['time'];
    data =
        json['data'] != null ? new MemeberModel.fromJson(json['data']) : null;
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

class MemeberModel {
  Userinfo userinfo;

  MemeberModel({this.userinfo});

  MemeberModel.fromJson(Map<String, dynamic> json) {
    userinfo = json['userinfo'] != null
        ? new Userinfo.fromJson(json['userinfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userinfo != null) {
      data['userinfo'] = this.userinfo.toJson();
    }
    return data;
  }
}

class Userinfo {
  int id;
  String username;
  String nickname;
  String mobile;
  String avatar;
  int score;
  String token;
  int userId;
  int createtime;
  int expiretime;
  int expiresIn;

  Userinfo(
      {this.id,
      this.username,
      this.nickname,
      this.mobile,
      this.avatar,
      this.score,
      this.token,
      this.userId,
      this.createtime,
      this.expiretime,
      this.expiresIn});

  Userinfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    nickname = json['nickname'];
    mobile = json['mobile'];
    avatar = json['avatar'];
    score = json['score'];
    token = json['token'];
    userId = json['user_id'];
    createtime = json['createtime'];
    expiretime = json['expiretime'];
    expiresIn = json['expires_in'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['nickname'] = this.nickname;
    data['mobile'] = this.mobile;
    data['avatar'] = this.avatar;
    data['score'] = this.score;
    data['token'] = this.token;
    data['user_id'] = this.userId;
    data['createtime'] = this.createtime;
    data['expiretime'] = this.expiretime;
    data['expires_in'] = this.expiresIn;
    return data;
  }
}
