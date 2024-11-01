import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

String _basicAuth = 'Basic ${base64Encode(utf8.encode('mohamed:mohamed123'))}';

Map<String, String> myheaders = {'authorization': _basicAuth};

class CreateInsertUpdate {
  getRequest(String url) async {
    try {
      var response = await http.get(Uri.parse(url),headers: myheaders);
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        return responseBody;
      } else {
        print('Error ${response.statusCode}');
      }
    } catch (e) {
      print('eeeeeeeeeeeeeeeeeeeeeeee');
      print(e.toString());
      print('eeeeeeeeeeeeeeeeeeeeeeeee');
    }
  }

  postRequest(String url, Map body) async {
    try {
      // الاتربيوت الاول هو عباره عن الرابط الموجود به ملف الباك اند String url
      //  الاتربيوت الثانى يحمل الداتا اللى مطلوبه فى البوست Map body
      var response =
          await http.post(Uri.parse(url), body: body, headers: myheaders);
      //دى ميثود لارسال الريكوست http.post()
      // uriالاتربيوت الاول هو الرابط الموجود به ملف الباك اند ولاكن يجب تحزيله الى Uri.parse(url)
      // mapالاتربيوت الثانى هو الداتا التى يجب ان ترسل مع البوست و يجب ان تكون من نوع body: body

      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        return responseBody;
        // jsonDecodeاذا تم ارسال الريكوست بنجاح نقوم بعمل
        // ونقوم بارجاع الناتجrespnse لل
      } else {
        print('Error ${response.statusCode}');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  postRequestWithFile(String url, Map data, File file) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      var length = await file.length();
      var stream = http.ByteStream(file.openRead());
      var multiPartFile = http.MultipartFile('image', stream, length,
          filename: basename(file.path));
      request.headers.addAll(myheaders);
      request.files.add(multiPartFile);
      data.forEach((key, value) {
        request.fields[key] = value;
      });
      var myRequest = await request.send();

      var response = await http.Response.fromStream(myRequest);

      if (myRequest.statusCode == 200) {
        print('yes yes yes yes yes yes ');
        return jsonDecode(response.body);
      } else {
        print('error ${myRequest.statusCode}');
      }
    } catch (e) {
      print('*************************************');
      print(e.toString());
    }
  }
}
