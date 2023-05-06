import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:sync_webdav/Net/myServer.dart';
import 'package:sync_webdav/common/Global.dart';
import 'package:sync_webdav/utils/rsaUtils.dart';

const pub = """-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAwT60yyb/K6fPaACa1YRF
T8MmkpWenfIVcKwZqZ0+on4X9B2RPgKh4OltDWRcDzF5AOfPFvM0M1IHtFDc8jmb
wjN6d6UVieSh6+3jkWyfbhCWW51SEMAoAzOZUH+fF3TU1fNNInR5iVOIXsb5Gh3C
7movLj5cpLCWiKxjvwrlML+5S2FJaLowCLvjJHc2XQHLcTOvh8OFiBfj4POw/tmL
ehohZKwFeyRx+HixVfhyJjhRvdJKQ0elKB+x1Dq7JweL2uouS1flHPz/Q+LeVTAO
LATKMSBZA3cCrjNN+bzbKBASpD0n6dScExQIrxqcO4FbKqckXQH9Tbylf7onwI9i
0wIDAQAB
-----END PUBLIC KEY-----
""";
const pri = """-----BEGIN PRIVATE KEY-----
MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDBPrTLJv8rp89o
AJrVhEVPwyaSlZ6d8hVwrBmpnT6ifhf0HZE+AqHg6W0NZFwPMXkA588W8zQzUge0
UNzyOZvCM3p3pRWJ5KHr7eORbJ9uEJZbnVIQwCgDM5lQf58XdNTV800idHmJU4he
xvkaHcLuai8uPlyksJaIrGO/CuUwv7lLYUloujAIu+MkdzZdActxM6+Hw4WIF+Pg
87D+2Yt6GiFkrAV7JHH4eLFV+HImOFG90kpDR6UoH7HUOrsnB4va6i5LV+Uc/P9D
4t5VMA4sBMoxIFkDdwKuM035vNsoEBKkPSfp1JwTFAivGpw7gVsqpyRdAf1NvKV/
uifAj2LTAgMBAAECggEBAJwc3FGCH4JU/uk2E9+KC7R0IyUoWgufFlL/tXug3IjI
9PDxMfS2i6/243J+MSDVBrwEiPgxYWpUSoURDm1gvMQWcklVxCCx412FwOIqrmFs
ZQt9/F4r3ic3+BNgBlYcvBRbiWTcU5LtOK3YcET45hFVFuh02MLzJakkGzCqzJyj
25Zp/K8cr37vaUxN1Njrn8lzQc3NDWjX62zl4peLFFvB3jUGic2TalbzizJIpUx1
/M4w+YTpTuTPImHBY7qL8CqC/rJeMoEmWJHY8AZSlvobdbIbX8kJFZoVyqtjKYn/
D67X5qsWeqisnboCpWf1q0RD5AhtqGGtro4dYCMugAECgYEA/pWiTGz8AcDVhGuI
8xrRlPe3QwvDqHau/8h56VrcynmaX+S9tctP/0SqqNKWpsvmMlTINeceKJdduarC
bHHmHsB+3W8YoVeKxcRSQROFKGpiWgcNFpM9HH2ri4W2gsjEtDfMIwhXVfoYu6/l
4siM8U45T64W5Tf+xQGDe8ZcftMCgYEAwlHDiap27z/vxMmHmBhU60BgSTNv1WFh
DnfcMLbgJhWquPTOXYPmb47B4Gj7Z3NBSiw9zJ1KHbmxdLcHe60WFEHcJYKYrMIn
cXiEdX6eTNJ8/prKX23I9AXFFjvKhLdLPqMGOqKHOeDHlxSOjDd8LE7bB5tqC7Wz
5U9ZpiwbDAECgYAQwBeln6YVF3L0+35PQHx5qLLOHoAJHYX2HmKnD+tnBwk5Nful
cnMZAJOZ+AEhiFjlBt8FbOd3FD5+cNXJ/NR/QXsXZq/gLbpbuMcQsRAZ0KYX9k7O
JXHn5fzbeTjA8iS/Fsy/oVTdu07VSoV9nmRnnBX5QCMRgdWpcKgOBMchMQKBgCEh
m7tPKzQjrJfa3JmcHG537XLNqFWzYr76xLoxlAoqS495fe4H3TRMHNZMUAEVb55b
6LWIY+ipjo4d3tLBcjBGAmkK2UkrWVpJeBwoWIk0okcu0S5wI4EnsrDVxPPX5KZr
WVaJ+5BsuNsTkDJsC2nqkAG+B9izRFbmrpxcjMgBAoGAYt9uu8rSW7vvWyaRAmrX
X8VoetY/hny3sWgAdKQ+jHDod6kgFqkxlfArQ5x965mVdBAnC51JLWAY03EyIkhJ
donreC2B9HPJqW2G4EekiiKX02YirQdB4wSdZ1NZd8aWjhV/xc93PzK1eR1HS6ZG
E3Ehi8pJ8xyL1m9mDp3SkfA=
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
  print(await registerTest());
  print(await webListTest());
}

Future<Map<String, dynamic>> registerTest()async{
  print('http://123.207.213.25/api/register' == (webHost + webPathPrefix + '/register'));
  var response = await Dio().post<Map<String, dynamic>>(
      'http://123.207.213.25/api/register',
      data: {"UserPubKey": pub, "EncryptStr": encryptStr});
  return {
    "userId":response.data?['userId'],
    "encryptStr":response.data?['encryptStr']
  };
}

Future<Map<String, dynamic>> webListTest()async{
  // 'http://123.207.213.25/api/webList'
  print((webHost + webPathPrefix + '/webList') == 'http://123.207.213.25/api/webList');
  var response = await Dio()
      .get<Map<String, dynamic>>(webHost + webPathPrefix + '/webList');
  return response.data??{};
}