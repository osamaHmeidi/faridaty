import 'package:faridaty/Core/shared/enResponse.dart';

EnResponse handleData(var response) {
if (response is EnResponse){
  return response;
}else{
  return EnResponse.Sucsses;
}
}