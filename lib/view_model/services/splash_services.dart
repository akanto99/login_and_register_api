
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:login_and_register_api/model/user_model.dart';
import 'package:login_and_register_api/utils/routes/routes_name.dart';
import 'package:login_and_register_api/view_model/user_view_model.dart';


class SplashServices {


  Future<UserModel> getUserDate() => UserViewModel().getUser();


  void checkAuthentication(BuildContext context)async{

    getUserDate().then((value)async{

      print(value.token.toString());

      if(value.token.toString() == 'null' || value.token.toString() == ''){
        await Future.delayed(Duration(seconds: 3));
        Navigator.pushNamed(context, RoutesName.login);
      }else {
        await  Future.delayed(Duration(seconds: 3));
        Navigator.pushNamed(context, RoutesName.home);
      }

    }).onError((error, stackTrace){
      if(kDebugMode){
        print(error.toString());
      }
    });

  }



}