import 'package:sync_webdav/model/model.dart';

initDatabaseData() async {
  await WebSite.saveAll(initWebSiteData);
}

List<WebSite> initWebSiteData = [
  WebSite(
      id: 1,
      name: 'google',
      icon: 'google',
      url: 'google',
      webKey: './ico/google.ico'),
  WebSite(
      id: 2,
      name: '腾讯',
      icon: 'tx',
      url: 'tx',
      webKey: 'http://mat1.gtimg.com/www/icon/favicon2.ico'),
  WebSite(
      id: 3,
      name: 'steam',
      icon: 'steam',
      url: 'steam',
      webKey: 'https://store.steampowered.com/favicon.ico'),
  WebSite(
      id: 4,
      name: 'github',
      icon: 'github',
      url: 'github',
      webKey: './ico/github.ico'),
  WebSite(
      id: 5,
      name: 'bilibili',
      icon: 'bilibili',
      url: 'bilibili',
      webKey: 'https://www.bilibili.com/favicon.ico'),
  WebSite(
      id: 6,
      name: '豆瓣',
      icon: 'douban',
      url: 'douban',
      webKey: 'https://book.douban.com/favicon.ico'),
  WebSite(
      id: 7,
      name: '煎蛋',
      icon: 'jiandan',
      url: 'jiandan',
      webKey: '//cdn.jandan.net/static/img/favicon.ico'),
  WebSite(
      id: 8,
      name: '12306',
      icon: '12306',
      url: '12306',
      webKey: 'https://kyfw.12306.cn/otn/images/favicon.ico'),
  WebSite(
      id: 9,
      name: '三大妈',
      icon: '3dm',
      url: '3dm',
      webKey: 'https://www.3dmgame.com/favicon.ico'),
  WebSite(
      id: 10,
      name: '百度网盘',
      icon: 'baiduPan',
      url: 'baiduPan',
      webKey: 'https://pan.baidu.com/sns/ppres/static/images/favicon.ico'),
  WebSite(
      id: 11,
      name: '百度贴吧',
      icon: 'baidutieba',
      url: 'baidutieba',
      webKey: 'http://tb1.bdstatic.com/tb/favicon.ico'),
  WebSite(
      id: 12,
      name: '学信网',
      icon: 'chsi',
      url: 'chsi',
      webKey: 'https://account.chsi.com.cn/favicon.ico'),
  WebSite(
      id: 13,
      name: '当当网',
      icon: 'dangdang',
      url: 'dangdang',
      webKey: 'http://shopping.dangdang.com/favicon.ico'),
  WebSite(
      id: 14,
      name: '斗鱼',
      icon: 'douyu',
      url: 'douyu',
      webKey: 'https://www.douyu.com/favicon.ico'),
  WebSite(
      id: 15,
      name: 'facebook',
      icon: 'facebook',
      url: 'facebook',
      webKey: './ico/facebook.ico'),
  WebSite(
      id: 16,
      name: '码云',
      icon: 'gitee',
      url: 'gitee',
      webKey: 'https://gitee.com/favicon.ico'),
  WebSite(
      id: 17,
      name: 'instagram',
      icon: 'instagram',
      url: 'instagram',
      webKey: './ico/instagram.ico'),
  WebSite(
      id: 18,
      name: '京东',
      icon: 'jd',
      url: 'jd',
      webKey: 'https://www.jd.com/favicon.ico'),
  WebSite(
      id: 19,
      name: '力扣',
      icon: 'leetcode',
      url: 'leetcode',
      webKey: 'https://leetcode-cn.com/favicon.ico'),
  WebSite(
      id: 20,
      name: '米哈游',
      icon: 'mihoyo',
      url: 'mihoyo',
      webKey:
          'https://uploadstatic.mihoyo.com/bh3/upload/officialsites/202004/favicon_1588243960_6169.ico'),
  WebSite(
      id: 21,
      name: '原神',
      icon: 'ys',
      url: 'ys',
      webKey: 'https://ys.mihoyo.com/main/favicon.ico'),
  WebSite(
      id: 22,
      name: 'nc台服',
      icon: 'nctw',
      url: 'nctw',
      webKey: 'https://tw.ncsoft.com/static/common/plaync.ico'),
  WebSite(
      id: 23,
      name: '牛客网',
      icon: 'nowcoder',
      url: 'nowcoder',
      webKey: 'https://www.nowcoder.com/favicon.ico'),
  WebSite(
      id: 24,
      name: 'pinterest',
      icon: 'pinterest',
      url: 'pinterest',
      webKey: './ico/pinterest.ico'),
  WebSite(
      id: 25,
      name: 'p站',
      icon: 'pixiv',
      url: 'pixiv',
      webKey: './ico/pixiv.ico'),
  WebSite(
      id: 26,
      name: '汤不热',
      icon: 'tumblr',
      url: 'tumblr',
      webKey: './ico/tumblr.ico'),
  WebSite(
      id: 27,
      name: '推特',
      icon: 'twitter',
      url: 'twitter',
      webKey: './ico/twitter.ico'),
  WebSite(
      id: 28,
      name: '微博',
      icon: 'weibo',
      url: 'weibo',
      webKey: 'https://weibo.com/favicon.ico'),
  WebSite(
      id: 29,
      name: 'v2论坛',
      icon: 'v2ex',
      url: 'v2ex',
      webKey: './ico/v2ex.ico'),
  WebSite(
      id: 30,
      name: '小米',
      icon: 'xiaomi',
      url: 'xiaomi',
      webKey: 'https://account.xiaomi.com/favicon.ico'),
  WebSite(
      id: 31,
      name: '宣城论坛',
      icon: 'xuancheng',
      url: 'xuancheng',
      webKey: './ico/xuancheng.ico'),
  WebSite(
      id: 32,
      name: '智联',
      icon: 'zhilian',
      url: 'zhilian',
      webKey: 'https://www.zhaopin.com/favicon.ico'),
  WebSite(
      id: 33,
      name: '知乎',
      icon: 'zhihu',
      url: 'zhihu',
      webKey: 'https://static.zhihu.com/heifetz/favicon.ico'),
  WebSite(
      id: 42,
      name: 'a站',
      icon: 'acfun',
      url: 'acfun',
      webKey: '//cdn.aixifan.com/ico/favicon.ico'),
  WebSite(
      id: 43,
      name: '163',
      icon: '163mail',
      url: '163mail',
      webKey: 'https://mail.163.com/favicon.ico'),
  WebSite(
      id: 44,
      name: '服务器',
      icon: 'server',
      url: 'server',
      webKey: './ico/server.ico'),
  WebSite(
      id: 45,
      name: 'iccard',
      icon: 'iccard',
      url: 'iccard',
      webKey: './ico/paypalobjects.ico'),
  WebSite(
      id: 46,
      name: 'ohttps',
      icon: 'ohttps',
      url: 'ohttps',
      webKey: 'https://ohttps-static.wawoo.fun/favicon.ico'),
  WebSite(
      id: 47,
      name: '七牛',
      icon: 'qiniu',
      url: 'qiniu',
      webKey: 'https://sso.qiniu.com/asserts/favicon.ico'),
  WebSite(
      id: 48,
      name: 'cgray翻墙',
      icon: 'cgray',
      url: 'cgray',
      webKey: 'https://portal.cgray.net/favicon.ico'),
  WebSite(
      id: 49,
      name: 'hostinger vps服务商',
      icon: 'hostinger',
      url: 'hostinger',
      webKey:
          'https://assets.hostinger.com/images/favicons/favicon-97d9192479.ico'),
  WebSite(
      id: 50,
      name: 'artstation',
      icon: 'artstation',
      url: 'artstation',
      webKey: './ico/artstation.ico'),
  WebSite(
      id: 51,
      name: '东方航空',
      icon: 'dfhk',
      url: 'dfhk',
      webKey: 'http://static-cdn.ceair.com/resource/images/AirlineLogo/mu.png'),
  WebSite(id: 52, name: '交通部', icon: '123123', url: '123123', webKey: ''),
  WebSite(
      id: 55,
      name: 'ucloud',
      icon: 'ucloud',
      url: 'ucloud',
      webKey: 'https://www.ucloud.cn/favicon.ico?v=2021081001'),
  WebSite(
      id: 56,
      name: 'unsplash',
      icon: 'https://unsplash.com/apple-touch-icon.png',
      url: 'https://unsplash.com/apple-touch-icon.png',
      webKey: 'unsplash'),
  WebSite(id: 57, name: '个税', icon: 'geshui', url: 'geshui', webKey: ''),
  WebSite(
      id: 58,
      name: '阿里巴巴矢量图标库',
      icon: 'iconfont',
      url: 'iconfont',
      webKey:
          '//img.alicdn.com/imgextra/i2/O1CN01ZyAlrn1MwaMhqz36G_!!6000000001499-73-tps-64-64.ico'),
];
