import 'package:dio/dio.dart';
// method url :'v2/top-headlines?'
class DioHelper{

  static late Dio dio;
  static init(){
    dio= Dio(
      BaseOptions(
        baseUrl:'http://api.mediastack.com/v1/news',
        receiveDataWhenStatusError: true,
      )
    );
  }

  static Future<Response> getDate({
    required String url,
    required Map<String,dynamic> query,
})async
  {
      return await dio.get(url , queryParameters: query);
  }
}