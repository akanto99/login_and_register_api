
import 'package:login_and_register_api/data/network/BaseApiServices.dart';
import 'package:login_and_register_api/data/network/NetworkApiService.dart';
import 'package:login_and_register_api/res/app_url.dart';


class AuthRepository  {

  BaseApiServices _apiServices = NetworkApiService() ;


  Future<dynamic> loginApi(dynamic data )async{

    try{

      dynamic response = await _apiServices.getPostApiResponse(AppUrl.loginEndPint, data);
      return response ;

    }catch(e){
      throw e ;
    }
  }

  Future<dynamic> signUpApi(dynamic data )async{

    try{

      dynamic response = await _apiServices.getPostApiResponse(AppUrl.registerApiEndPoint, data);
      return response ;


    }catch(e){
      throw e ;
    }
  }

}