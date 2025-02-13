import 'dart:convert';

import 'package:http/http.dart' as http;

class IpData {
  static Future<String> getMyIpAdress() async {
    http.Response res =
        await http.get(Uri.parse("https://api.ipify.org/?format=json"));
    if (res.statusCode == 200) {
      return jsonDecode(res.body)["ip"];
    }
    return "No Adress Found";
  }

  static Future<Map> getIpInformation(String ipAddress) async {
    http.Response res =
        await http.get(Uri.parse("https://ipinfo.io/$ipAddress/geo"));
    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    }
    return {
      "ip": "faild",
      "city": "faild",
      "region": "faild",
      "country": "faild",
      "loc": "faild",
      "org": "faild",
      "postal": "faild",
      "timezone": "faild",
    };
  }
}
