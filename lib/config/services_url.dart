const serviceUrl = 'http://medium.tklvyou.cn/'; //基本的URL
const servicePath={
  'userloginIn': serviceUrl+'api/user/login', //用户登录信息
  'userGetCode': serviceUrl+'api/login/getcode',
  'sendCode': serviceUrl+'api/sms/send', //请求获取验证码
  'registerUser': serviceUrl+'api/user/register', //注册会员
  'resetPassword': serviceUrl + 'api/user/resetpwd', //重置密码
  'articleIndex': serviceUrl + 'api/article/index', //内容列表
  'uploadFile': serviceUrl + 'api/common/upload', //上传文件的接口
  'like': serviceUrl + 'api/like/add', //点赞文章
  'uploadVideo': serviceUrl + 'api/article/addv', //上传V视频的接口
};