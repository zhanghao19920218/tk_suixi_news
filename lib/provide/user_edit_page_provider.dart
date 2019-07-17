//用户编辑个人信息的Provider
class UserEidtInfoModel 
{
  String username;
  String avatar; //用户的头像地址
  String mobile; //修改手机号码
  String password; //用户的密码

  UserEidtInfoModel(){
    username = '';
    avatar = '';
    mobile = '';
    password = '';
  }
}

class UserEditPageProvider
{
  UserEidtInfoModel _model; //用户编辑的个人信息

  //编辑上传用户的信息
  updateUserInfo(String avatar, String mobile, String nickname){
    
  }

  //获取用户的个人信息
  getUserInformation() {

  }
}