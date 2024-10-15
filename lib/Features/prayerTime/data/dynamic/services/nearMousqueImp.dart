
import 'package:dartz/dartz.dart';
import 'package:faridaty/Core/constant/links.dart';
import 'package:faridaty/Core/shared/enResponse.dart';
import 'package:faridaty/Core/shared/handleData.dart';
import 'package:faridaty/Features/prayerTime/data/dynamic/models/nearMousque.dart';
import 'package:faridaty/Features/prayerTime/data/dynamic/services/nearMousque.dart';

import '../../../../../Core/shared/apiServices.dart';

class NearMousqueServicesImp extends NearMousqueServices {
  @override
  Future<Either<EnResponse, NearMousqueModel>> getNearMousque(double lat, double long) async {
    ApiServices apiServices = ApiServices();
    var response = await apiServices.getRequest("${AppLinks.locationBase}$lat,$long${AppLinks.nearMousque}${AppLinks.locationToken}" );
    EnResponse status = handleData(response);
    if (status == EnResponse.Sucsses){
      
    
  print("=======================================");
  print(response);
  print("=======================================");
      NearMousqueModel nearMousqueModel = NearMousqueModel.fromJson(response);
      
    
    
    
      return Right(nearMousqueModel);
    }else{
      
    
    
      return Left(status);
    }
  }

  
} 