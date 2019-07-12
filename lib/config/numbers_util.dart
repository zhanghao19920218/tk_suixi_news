//MARK: - 获取数字的参数

NumberUtil util;

class NumberUtil {
  //单例
  static NumberUtil instance() {
    if (util != null) {
      return util;
    }

    util = NumberUtil();
    return util;
  }

  //判断手机号码
  bool isChinaPhoneLegal(String str) {
    return new RegExp(
            '^((13[0-9])|(15[^4])|(166)|(17[0-8])|(18[0-9])|(19[8-9])|(147,145))\\d{8}\$')
        .hasMatch(str);
  }
}
