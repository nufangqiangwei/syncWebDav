import 'dart:convert' as convert;

import 'package:encrypt/encrypt.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pointycastle/export.dart';
import 'package:sync_webdav/utils/rsaUtils.dart';

const web_pub = """-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAueCsckXrWhnTk9WsHo7l
dlfoA0OMRRjp6/Gyu39G/Lbln3jsYwDhhW0b4t+xyUABH9DQX+LTb023y0OWqKtP
iJguyd+PqE2Zzqo4iDfJmd6zj6x6ScMJmVhZtiNVJ2unQXj5p6iVPhnBQi95NtY8
ODhvpyEIifUM5d7v2Y/VQEoqv4BE548XPqpTci0qGHXkSgW30WyOpQJoQO6XbhFS
5fCNKZgioJy6ECu6WIk8FHa12RsA5rXbdDlE4Ru32kO+V283svtd4tBW7sZsEq3b
DmwtgVk3DL7kwhSn3EmbtwDHLrbiRESUb8MzXKml7GPNSLHhAOEcATSjGjzlhO41
QQIDAQAB
-----END PUBLIC KEY-----""";
const web_priv = """-----BEGIN PRIVATE KEY-----
MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC54KxyRetaGdOT
1awejuV2V+gDQ4xFGOnr8bK7f0b8tuWfeOxjAOGFbRvi37HJQAEf0NBf4tNvTbfL
Q5aoq0+ImC7J34+oTZnOqjiIN8mZ3rOPrHpJwwmZWFm2I1Una6dBePmnqJU+GcFC
L3k21jw4OG+nIQiJ9Qzl3u/Zj9VASiq/gETnjxc+qlNyLSoYdeRKBbfRbI6lAmhA
7pduEVLl8I0pmCKgnLoQK7pYiTwUdrXZGwDmtdt0OUThG7faQ75Xbzey+13i0Fbu
xmwSrdsObC2BWTcMvuTCFKfcSZu3AMcutuJERJRvwzNcqaXsY81IseEA4RwBNKMa
POWE7jVBAgMBAAECggEBAJCVC24DpvK5vhJzFOPcIO5xqD3Jr/UbUPE/WthvQydV
mLz30V+dEs63NQa/G0pAZ994jGzZQb+FA16vXyQpxL6qKVLLe7HdUrMnQrvqMP1n
9eHetmxjsja+O2Hqj9UO7tWFpSPdhOD+JY424SFfeQ3+EBM/JaYxn2u6gnSHZcgP
09cM6OOG6KzUjYNwZ5mU0hBr0aUlZ3eerxXcw/FmLl3FPp6+kQ3sRjj03DPvUk1J
Vf+YEnlnCws8R5fCWfxthDURPL3xqlChpFSKzDLhtyempsBNXmrEEG2aEkWQDxZW
gN4ceTz2VZ0BOO8k9cfs7NyaVzH9tDn5IfTRAh7GZ9UCgYEA7920T+4r4tQmU15H
Vqdl2JxZjHsDdDY/bUltLtijYIEwDQGbmxyaLY0bzLoGO1zTmHKFtiTS1M+eoeS9
pxd8YcZddsmGVzH+ugvEe7momgQLyGEBqZbZuWppPoA0P7Tb171n41jmwe+dlkWd
WCzUw58zBHp+wwnUbtyz2X6JGZMCgYEAxmFVXFZRe0aohxX2UAOouO1BSyBMtN17
rmfXLEziBMD3LUKciYrDQep44nEH8MzKhmsgqzHtXmdheoOsCpcPkqtd3bOQvEuR
adVeFiTajtPXCOUVU1Yx2Oj8KKy/hGwjUoBAgDr9jNIE86FPj+B6hPn+wm37v+Qm
d8t72EQAKlsCgYAzy+RL/lpruPQtvIYbKDrN87VCqK2uQqifqONy4kUlacA+jsJT
VHHWtEn0g5ck6n6mxNQq6Pi+C7dtrj9l/aRWWMeGBy6DVcBz3GapcQX/fDAvLQN2
46RQbbIcVQLzXtK6W6Q7a88owd19vbqkd8naFF6n8Ou+ojjFV9Nee/yPEQKBgD+z
OWmw/fELu0nFL5Z51k+rP3AUKw1YoUJbbah394t3Oud5oDI6MICV/cMYcGhOGioX
dCIEoifSImboqPGtl/6MsFNkOXF9AnBtZwzNQLDkLQRaKwLbhp4UEgQtlEG9R4pS
TGPgjVIOjjB898NHXZAdhkSAdHollISa/mVvUG5JAoGAKSEYpn1eILMSESKjJXi0
xvaThRnJzRSHM4OmFRsyrY/crts0JYHCt5tAAm+6CdB+CYGgB31tcd1ixBJ3SU6W
9h+FuP7qtQ5kQ9S7j5LxzJSK5yb5WkFFLT/j4BuVoI+0sxxkgoA8dmb2cNURRPK+
VrhAegWp3ToX4IqUcw8cyWs=
-----END PRIVATE KEY-----""";

const pub_1024 = """-----BEGIN RSA PUBLIC KEY-----
MIGJAoGBAKOXRuEquzfnfC0SV/hymeg31ICCqcUsY7YMrgtsQwnYkVei+1OG747X
nIl7gaW38Fk70YOW/dCCjB0y/wzdQJCdWccUYAS6YTYGT9xY8B111QbY43+ij/OX
qRXQ5InvFKMX+OxWhpvHXbFo4jm3rRY77ul9SBxG+LaMsJmJxAh9AgMBAAE=
-----END RSA PUBLIC KEY-----
""";
const pri_1024 = """-----BEGIN RSA PRIVATE KEY-----
MIICXQIBAAKBgQCjl0bhKrs353wtElf4cpnoN9SAgqnFLGO2DK4LbEMJ2JFXovtT
hu+O15yJe4Glt/BZO9GDlv3QgowdMv8M3UCQnVnHFGAEumE2Bk/cWPAdddUG2ON/
oo/zl6kV0OSJ7xSjF/jsVoabx12xaOI5t60WO+7pfUgcRvi2jLCZicQIfQIDAQAB
AoGBAJ79kWeZLiehFPCBGXpfdvFYAXF8jB8Tiz0NicGUUHsrPeacggKl7AE5z+tW
W6SB5lfzaSapArk5h4+BVpxcFDhqslapS4JqO09Ui8MfFo3K9DMsgk0YC7s9sP7f
mMSvqUfdFOAmyAl93xe4TdQF+wqJ9jKoaTWQezLZVlYEt/vBAkEA0VCPaftLVUpp
C4mjHLhSUjLcDkesAeLQuzqbpPmOoTn/HL2Yp7HFVnqLwpy2lYq98hg8Ku/++7Xg
OHNJa77raQJBAMgT+8XP1mYJ6KgP/l3JqdaDRFOiSonuqQp5iS1LPaKzKmw3jUmo
rnM7b1Dt5miknRforj5ehWrEx/yA1qDQNfUCQCyfAuOx+X5GLZyTC92sgYgaZYT5
zHZedubi+Jkzxi8ioPrshCWDpTDpUO/83oOEnzeD6ReyL+ZTAGioUweQHLkCQQCK
OewebIlls4DN40bLytAQSF4DHcM7aevVNcQEy8+IQRmU7AgrlGL5b11nXwRo1RlG
9FS0+B5adhroIqalMVOlAkBVKmfszFi4df72luhEtDRRyZqepHxvnF312UYPNHQK
zy3/VO+HGgJMvctsI0xRST0WM4Kd2xqBsuXubJvfSkiK
-----END RSA PRIVATE KEY-----
""";

const pub_2048 = """-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA9bZqZJ3VLG9JJfDhExnX
FvGGueVIFfRtqSAvFjBtg36d7DcwBRVglOMqjkDMpeH01PaYnMNbLJ08LJ+c/vqm
l1A8sNJqRGpv/tamgYJjeYf9IutaD2YGFvlM4Wm9a++0vox4733at7YMM/UUnsHd
x8Dym07KUihW49bMY589JVktrwOUdB185d0hKjVwzRrZVwuftlZjBKUNTuQl1QR9
FvjNS/WHB1MhvRE302dOI0PBmEkuNuhvid7wrYhjVG3L6GUWcg92Uu2tp/jOiE3j
etBr/JbvAUfO8lVfHwVuLEGbYnEfXF10FrQ6TBAtSydUXq8Li4qpe2/JkYN0AYFM
OQIDAQAB
-----END PUBLIC KEY-----
""";
const pri_2048 = """-----BEGIN PRIVATE KEY-----
MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQD1tmpkndUsb0kl
8OETGdcW8Ya55UgV9G2pIC8WMG2Dfp3sNzAFFWCU4yqOQMyl4fTU9picw1ssnTws
n5z++qaXUDyw0mpEam/+1qaBgmN5h/0i61oPZgYW+Uzhab1r77S+jHjvfdq3tgwz
9RSewd3HwPKbTspSKFbj1sxjnz0lWS2vA5R0HXzl3SEqNXDNGtlXC5+2VmMEpQ1O
5CXVBH0W+M1L9YcHUyG9ETfTZ04jQ8GYSS426G+J3vCtiGNUbcvoZRZyD3ZS7a2n
+M6ITeN60Gv8lu8BR87yVV8fBW4sQZticR9cXXQWtDpMEC1LJ1RerwuLiql7b8mR
g3QBgUw5AgMBAAECggEAH1MhHzCr851AYxDhcNDzhd5Gwb5EQWBG9q++sQJ9g60J
rwqeGZfPF0waqcYDEQbMcrX5YMra/cYR3NKAblVAFbxJ8HTyzUQQgRmWYp5f1ieL
Ev+UHLByCE3CCl6zomYN0dkQtd+CmbcguSL+fPrULlof08Losi6oXSWOKwkq/26u
G5x8d016ivDS8ba/vSBIFnKRQ3Pp9AvkRjg4++HTG0im0yqtrPhVczV5f/WfABep
Godv9XC8/lQ+TTiN7USYvhvp5nbwLlvGG0NZUjsOSuyL7rr7QAzqpfRWyKHuYbM/
WubraIhH2hxcJUxPorI/hvEmHOSGCNQUoef9wNANAQKBgQD9ZK2sSrMB8HRcdOit
X1/YujVD3C+We89K4ILzFxx8pZBHM2LgK8DN7m6NhIhMuSJxeHaB62DAcwgbQRe5
IQH0PiDV9oR8Lwn4hvKxu4zAQ5i4/AjYUzDIjsbTuGjui4bvCv+rSdaQjLGUHVOo
6dKfNJH/C1Puh/3es8dlbTbqoQKBgQD4PYJ8d6xM7Ir/RqrBCuJWiVR7t6z9vn2w
ePdMiaucJ2N+1vyz69dguIPxIp9tlW9wmOWf29rzefQTbOdz8TjbSiiNgDSFXFxq
jJ5oXyxNKbXJ4ct2NzNI2gsbA1CSRLpF797Uc/kDJd8Jh20ZcfjfKqTv4alEHfCK
MkCOYtfSmQKBgCvRbir+G+h48VZPrTDV7lgnEzDx8ZS/QkB7hImO9JElfEajvzRu
vH+f/KQiSAOkfC1NHIko7+k3uy4jWnvcFl9rIvh9Ebn71GiSxYMwoI1a4x0SEGGA
OU5lSkKwgAzIOgQ6Ta4MLbt/aPHpBF+QV6jKSXjmN5RnFeKeChwi/70hAoGBAPgP
718V77YHAndKVMQHblpvbV8cEuCWBN/eYbG4OScYLVLI30mkOVvLxv2mTY6iL/Ri
tcPjXY7EpWTsBPZVbS2lk5SjMti5jRhkYL+Hq6uILMMKwdjmHHeGfGaID3G7ADF3
HENNiN7eb10EWb99pubLpHqaFB2flYlj4iLnHyixAoGAaimOMlgl6+FnhK9E6D2T
LGiAT6ahLvjVU5OOGweXftbHtFbej9AofMAKwRrJdw3DLaUwr8E191rTfDhGuSBf
HpPtkjElGzdvDuGpAKUACCZIrL1dD4mKLWfQx2UcpvB66KTdPejg/nMRL7PyKC93
9vF+xFpm/Rlp6UvgQK53qHg=
-----END PRIVATE KEY-----
""";

const pub_4096 = '''-----BEGIN PUBLIC KEY-----
MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA1k0/nL1v2jEbqPSrjVZK
t6j122VdXwizeHl9b7OuQNn2gBcTOSsgLOmRAeGYaP0/tgqGW+RptPBWi6B6eY5z
D3Odb00YNisGCCxqKlphJu2cXhFg8Pg454NbE6Jno0RZmESPcReJUFQX2Q9NmNfJ
jBtJioGghrYiYjPUcIazbhRAGuVVatNSFvXjpJRQk/wRQfk/ZZkN7M1MYO0M/5SF
pfEPWL/i4+uC6L3RjV8MDURBUE1Ou9RxHXjetegRxwtvvZJI5M181d1A93t4JZ8F
YKJ6qZKZmH0nVbpYu3p/EPep/vZxlcTobGajQe83Dtmhe9qWvo9bvzfVKNE8MhaP
2bvd6J0HikhXmM+DeIM52Mb5KuFC8t4wKlfXXLM8QMEibyN3atpV5rIpzibj1oWv
sU8Mxqmt0v0NQD5MbTlkjQcK3Tj8QPUQKKSoaJoySds5yD/w8rCEhPXG3+PlnfXD
PZiUGY/lF+vb2pK2QzZqUB1OLKocHewZuh1qJKQgBLXuuzx+xy8jFmOsKaJu3oWu
M4dfd3lahW0+Oj5dAwf/qtJ7xkzPANp/RS85KBsQNyxR8x77RBSRbLhBhtvbAQoI
VJL+BFR5hpnGiov2+42wIE5SpNlRptSrwHpZYDoDs0wW4x9vreTW6uFiPPnuA0DO
1QySWDNEX+/BDYT2Yzr8S1MCAwEAAQ==
-----END PUBLIC KEY-----
''';
const pri_4096 = '''-----BEGIN PRIVATE KEY-----
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
N7ErCJV5MPpB5FuvJr3uCmtx17exoD62hg==
-----END PRIVATE KEY-----
''';

const text =
    """项目共计 4 个，每个项目（只支持 IE ）都需要和额外的客户自研中间件、插件（ ActiveX ）、多种硬件设备对接。此前未做过和硬件对接的设备，低估了对接的难度
中间件、插件、硬件设备的对接我万万没想到，什么文档都没有。只能去搜历史代码学习测试，或者到相关部门去问问。而此前沟通过程中，我心中默认对接是有文档或专人指导的，没有问清楚
前端使用框架（ 2006 年的框架和版本）过于老旧，由于对前端了解不足，错误的估计了学习曲线，团队前端同事开发前期非常吃力，进度在这块也拖延了一大段
跨部门沟通的难度远超我的想象，此前沟通过程中，明确好跨部门沟通有专人负责，但到了实际工作中，都变成了我们自己去对接。各个部门互相踢皮球，一个摄像头到底是什么型号的问题（测试需要特定型号的摄像头，对接人不清楚借来的是什么型号），我能花 3 个小时跑遍五层楼才得到答案。更不用说代码层面的指导了
没有了解到客户方框架的真实情况，心中以为是在 spring 上封装的脚手架。没想到框架中包含了快 2000 张表，数百万的历史代码。光用户模块就有不同的三套（该框架会在各个定制的基础上，定期的把定制内容合到框架主干上，导致了各种没有用的历史遗留代码），找想要使用的功能搜索难度大增
反思：

经验很重要，但经验也很致命
在此次前期沟通中，很多我以为，我认为都是经验主义所害。比如对接文档的问题，多问一句，可能情况就很不一样
经验也可能成为风险之一，需要警惕
想法设法获取更多信息
四个项目的对接人了解的信息都不全面，到我这的信息就缺失更多，而我当时以为这就是全部的情况。信息的缺失是会让判断失去方向
在现有信息中，要去挖掘出更多的问题和信息，并找对接人确认。越多的信息越能为判断提供更准确的方向
对接人也不清晰的情况，需要推动对接人去找相应人员获取，得到相对准确和完善的信息
锁定项目核心重难点
在这几个项目中，有的项目没有在一开始就抓住项目核心重难点。比如甲项目中核心功能是存储，且需要使用客户自研存储设备，项目初期未锁定该重点问题，导致后期项目核心功能全部返工
一般采取排除法来锁定核心重难点。把所有的页面可见功能点和隐含功能点列上，以排除法排除独立的关联少的模块。留下的就是重难点的核心要素
针对每个核心要素搞清楚联系关系，得到最终的功能关系图（业务架构图）""";

const signStr = "JJDdjIJRq2";

const dartSignStr = 'A/J3EEJCqW6qCXNiN/ivgfiLtIzVp7oYxIQmSRMgqp/YkrFrsWqi5/wqUO72+RkE2ABgay2heYjChwkjHQc69TSIrjkrzMvQbDqmKVpds60u2JwrSwzpiTDEiOMmaJpIA/gmyAA6gh/upwDrQe66EtwPlwORLhIvi0uuxe1ngXAsVgQCqizDjzUgayUgpjFy4DdWTZD6qZ3ngCRZnTheyokCq7c9K08Anbt2bUJpsmLyMOel5kX1/BQE1sO9XOs1QfZMjkRs/6mmHBCruO1mQwGHdM6o2lgB6CnrEUOgivSKviuU3G79CmdTHlzqeQJtY4kNfXhJ/e7/FXhc0P8gLw==';
const pythonSignStr = 'AnPuTlfUqiaBYmVhkVtlTnX2Kofxtxl6TyD27WOLaMlHHgpOO0BjDRfYEGHELpse/mBDU0xBJGv6zfOYT9WPcQyjSAbkwrxezSLeOWdVFZQWc5q1KgIzmAWKT4V4/8AdIEvKYNIlLOiZZJbg+Uczivq7yyGdqZgfrs6qIHQutpqqmDc3+ZRCPLic4NzNjpZRfR8aqOklC2F7rALgjAjDo85uL6KDBjokTXgKuFxn1MZB9lbejUk9w8j8HXy3y2Z6ZrABiz3Dk/RuStZBJfj4A8CAsk7aKGyt03rogVm4xE+ndEWJZDXvF5HKaxhnK6fvFDAfIsL4+qHiFrLiXMKi/g==';
const goSHA256SignStr = 'df396O0kACD4f6zfLF7Y7P2TNN6K7XrsaWgVmXDlssPq0OZIWjh3PpQHCVBGYniARHUCkHUlsPMkqIAQZ9vKTlgfm66HLiSVm3mCgVe9l0MdSNL5G+iad1ye0tcV8RKxH5qaigK0X7s3HV1vTxOGLUF3PloVffUx3gzFm1BYebf564HmHM3MfeVWkUJFOEgks3vuwiYC1Pnq0Ez+bfjDpcK7ubYN0OKPCx0F6xm666HCqUB0jk07nWUx+69zFMiZbZmZ5JnLQ65QzMuUGnUBpQP8Wl8gDn0s9PKqcNooya2EgmcjWZ9/rTfSRn6tqHGF1GLSAdqR94vMBE+n8eUlOg==';
Future<void> main() async {
  RSAUtils client = RSAUtils.initRsa(web_pub, web_priv);
  // String str = rsaClient.encodeString(text);
  // print(rsaClient.decodeString(str)==text);
  // print("1024 BlockSize: inputBlockSize:${a1.inputBlockSize}; outputBlockSize: ${a1.outputBlockSize}");
  // print("2048 BlockSize: inputBlockSize:${a2.inputBlockSize}; outputBlockSize: ${a2.outputBlockSize}");
  // print("4096 BlockSize: inputBlockSize:${a3.inputBlockSize}; outputBlockSize: ${a3.outputBlockSize}");
  // RSAPublicKey publicKey = RSAKeyParser().parse(pub_4096) as RSAPublicKey;
  // final modulus = publicKey.modulus;
  // if (modulus != null) {
  //   var outputBlockSize = modulus.bitLength ~/ 8;
  //   var inputBlockSize = outputBlockSize - 11;
  //   print(
  //       "1024 BlockSize: inputBlockSize:$inputBlockSize; outputBlockSize: $outputBlockSize");
  // }
  // await yaunshenTest();

  String s = client.sign(signStr);
  print(s);
  print(client.verify(signStr,s));
  print(client.verify(signStr,dartSignStr));
  print(client.verify(signStr,pythonSignStr));
  print(client.verify(signStr,goSHA256SignStr));

  // String b = base64Encode(rsaClient.decryptByPublicKey(Uint8List.fromList(utf8.encode(a))));
  // print(b);
}

yaunshenTest() async {
  final RSAPublicKey publicKey = RSAKeyParser().parse(pub_4096) as RSAPublicKey;
  final RSAPrivateKey privateKey =
      RSAKeyParser().parse(pri_4096) as RSAPrivateKey;
  RSA r = RSA(publicKey: publicKey, privateKey: privateKey);

  final encrypter = Encrypter(r);
  final encrypted = encrypter.encrypt(text);
  print(encrypted.base64);
  print(encrypter.decrypt(encrypted));
}


// base64Test(){
//   const base64Str = "AA0OEwRDFA==";
//   print(base64.decode(base64Str));
// }

encodeSignStrTest(){
  print(convert.utf8.encode(signStr));
}