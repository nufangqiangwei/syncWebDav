import 'dart:convert';
import 'dart:typed_data';

import 'package:sync_webdav/Net/myServer.dart';
import 'package:sync_webdav/common/Global.dart';
import 'package:sync_webdav/utils/rsaUtils.dart';

const pub = """-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAsq9jCIg+991u8mAGvjIp
MT+WpFy2ZoOXCuztW8z1hiaT5ORgIf5Du+dEMR47KLcC25BaUgoTU5hfvZskc5Xy
XBwcLmfHqmwGLBJMBSfhL/CsX5nLVrYbl90bVtz7oScAs0MN0Kh7GzsENNY/fvSR
mPYf3gD2zdiUYIJZ5JTj/GrP2ptm0XJWpy9XaXBFYeiqCBAnASG/08vQjw94Sog6
icRA16AOhTgttXf2uyzvwq+EndEp63Vkx9s+EnUMu5wWBQiDOjlaoGGNkwAm5jF5
LxM4mSR86bIjqjhMkKbwh5mG2IvIPJMRj0JORN4xUQlurKnJru0M6eqTYp/7/zRs
wQIDAQAB
-----END PUBLIC KEY-----
""";
const pri = """-----BEGIN PRIVATE KEY-----
MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCyr2MIiD733W7y
YAa+MikxP5akXLZmg5cK7O1bzPWGJpPk5GAh/kO750QxHjsotwLbkFpSChNTmF+9
myRzlfJcHBwuZ8eqbAYsEkwFJ+Ev8KxfmctWthuX3RtW3PuhJwCzQw3QqHsbOwQ0
1j9+9JGY9h/eAPbN2JRgglnklOP8as/am2bRclanL1dpcEVh6KoIECcBIb/Ty9CP
D3hKiDqJxEDXoA6FOC21d/a7LO/Cr4Sd0SnrdWTH2z4SdQy7nBYFCIM6OVqgYY2T
ACbmMXkvEziZJHzpsiOqOEyQpvCHmYbYi8g8kxGPQk5E3jFRCW6sqcmu7Qzp6pNi
n/v/NGzBAgMBAAECggEBAJpyXLB4S60lOgvIEqv9YXuPEh+Zf5OWdEzeQ7/QpfxB
hh4XhDx9sYBOQrQOBGaJ4a90040L5m6gS0jxO42o8ybIqVc3Hu9gleksG4dtVAiD
CAtOPOMDX1BhrorjUaCWvNU1xVAxAM+lsFoXQiTzMpI7U4op3SpJ5N6SbS7Vv0Zi
fnybjLxaiDXpP6m7CZ7i6eWHhnqTJDCh++nstYu8Eur5V9fta11SkyLECCjFXOMi
BIbKH1QUNyV4RJkaX7aIoJObyE5yaMoxDEeNSEn69AeE4cekgt61yZrfmscoqEVo
3wKAlFCmfHtf0DI1cTtIm+VZqnDLhaq92vRkvQKKFEECgYEA4LrofP+QBsZQ5hPC
x/dRhXdH4veASXG7QO+8/magmiNvYXmluTSC7U17lVN6fxTEAg05nxwKl1IwEGd9
pariEOjC/ri3XubtGi035DlskVGfoON+p8aRFGPD6BdIDfeHMhnr1/uuzpb17vs7
2VUbkoXHA3UA3n8Y9PjgDXBS2qkCgYEAy4xQRDDoip390lEv29Bn6dq7mlczQy5u
juiidIBX+vgX12KLrKegWR/wlMagFIMjEPdWgXM0ZQySizkT6kf7RuVFZV4RwIUe
W4recizXtvORqFjROCAHzzQMBKwdbT+HjZXsCvvNguLEd8ErRiAaBoPkrYf7sG3r
0WzD87/cKFkCgYAxHGeGOYtOD7TKMvNUI9Yq5qBNF21vn20eicWxitf6F1hV4vG2
gaVDGrWxMmcIso8LK7y16rjdzNY4H4Wz2J5Ct7s1U0SvdqPGHq+iLnJtZ3sM++pH
2/sEi7DaXYwfkUJ4TnXd42CWQSNJsJmpqxG1eYq+VKl19iyMDH9aMHvK0QKBgDyw
NS5ftrW9rXQLqM1NMe5TvSOjZDFfoq8RRX6e1ZyKY/Ff/G0Z/YEVONHi9s+m2cmx
NSWbh7+pI/hGqF1t4MmeijZS+dAA4LBCk1hPbnGp5X/gG2E0i5+H0R2Dg7KTAoOA
c8RCl1+y5QkfmxtpbtkKciAbLzvHSkxCtZnzVlzhAoGAYGVq9qB/prIY/b1vqfS+
EuehEg5Z7LIpvRM5yYVHjv9v6hZ2dOx6dDCh8tWkO7RceA8vEF4JVDk2cEq9o/B9
33JTdFZLh+qbZaXMgmaQFBNC+Q9ZGuHiT4+pwOxENJ6jLxQCkF1rYOSlCYiC3xQu
R74+BFFE9GsISP04MxBGYsQ=
-----END PRIVATE KEY-----
""";


const encryptStr = "wil3ekj23r8dfusrj234r2iwq3rj";



const webPubKey = """-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC+XpiP5bcOmzgOHG0eRDVx41kP
ECiMCx14KduElU53kCyY02xETFC/KxF8mpFCEM9b8iTSAKjRbAs8CXQtSJIxv9d9
/a6OhXKg6WadljRmVoZZm9MD2MGixMGYN2W3noEkfUHeWUtghk8ohcAMdl4mwanm
+JBAkTEOsVlegk/27QIDAQAB
-----END PUBLIC KEY-----""";
const webPriKey="""-----BEGIN PRIVATE KEY-----
MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAL5emI/ltw6bOA4c
bR5ENXHjWQ8QKIwLHXgp24SVTneQLJjTbERMUL8rEXyakUIQz1vyJNIAqNFsCzwJ
dC1IkjG/1339ro6FcqDpZp2WNGZWhlmb0wPYwaLEwZg3ZbeegSR9Qd5ZS2CGTyiF
wAx2XibBqeb4kECRMQ6xWV6CT/btAgMBAAECgYBFaYiHL2NH2CDgRE0lNAmotRTM
AUBHj+X24oxAE5DA17jrIGvhm1H14mZF4LYGOMri46+5QrRLZ/HQukG6ITPsfd60
PdsRmqyUh+xBkkc1kUgjdHx9ei3psGOpaS4qO3a9YqTes2ioImGo7HOdbvNi+Ipz
xncaDCUMrvwmKJxuoQJBAPbwLjmaC/GpXINkVYtBEKINGZu42IfkXrqOUV7C0iaU
5pBpPqehMMLwl9WRmvp3xzFwoY8CEQuzmm5nMX4DOCsCQQDFWv2GuRGkhKBPt53Z
UbKEltpkCNX33dMDdUAGEHnkPkCRNCRcpxAw921P+NuPFsafw41k+3Qi2oVGBb9D
halHAkEAw8reK+fbjooFg1x7g0VcpdCTPGhMrzrAbVTIacU5EURAp8H63risy/Qt
vzWK1ws/khDG2HgAAfIvAViq4ko1LwJBAIOG8aIA4zYuwZx/Ne7omL3uv5udm+Q2
bPRIByRDhMjNiEB9bKJnIM5RiAOdSc5iEnvVWv1q6+pykhGpsN9yS+8CQEgqigV+
sKG2kaDztx7kOPV94O2IvlceY0llkGyjT55z78Bnu4sTe6EuviDoOww07NbvDZhv
jiqWngR+SlSRhak=
-----END PRIVATE KEY-----""";

Future<void> main() async{
  // await register(pub,encryptStr);
  // var response = await getWebSiteList();
  // print(response[0].toMap());
  // globalParams.publicKeyStr = pub;
  // globalParams.privateKeyStr = pri;
  // await globalParams.loadRsaClient();
  // Map<String, dynamic> testData={
  //   "bili":"突发灾难重构了地球板块，末日之战即将打响：科幻小说《末日独白》"
  // };
  // await pushDataToServer(testData.toString(),"password");

  var webRsa = RSAUtils.initRsa(webPubKey,webPriKey);
  var xx = webRsa.encryptRsa('''{
    "UserId":12,
    "EncryptStr":"$encryptStr",
    "Timestamp":${DateTime.now().millisecondsSinceEpoch}
  }''');
  print("密文: $xx");
  var yy = webRsa.decryptRsa(xx);
  print("明文: $yy");

}