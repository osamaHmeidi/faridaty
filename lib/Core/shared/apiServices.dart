
import 'package:dio/dio.dart';
import 'package:faridaty/Core/shared/checkInternet.dart';
import 'package:faridaty/Core/shared/enResponse.dart';
class ApiServices {

  final dio = Dio();

  getRequest(String link, {String token = ""}) async {

    Map<String, dynamic> headers = {};
    if (token != ""){
      headers = {"x-rapidapi-key":token} ;
    }

    if (await checkInternet()){
      try{
        var response = await dio.get(link,options: Options(headers: headers));
        
      if (response.statusCode! >= 200 && response.statusCode! < 300){
        
        Map data = response.data;
        return data;
      }} catch (e){
        
        return EnResponse.ServerError;
      }
      
      
    }else{
      
      return EnResponse.ConnectionError;
    }
  }
}