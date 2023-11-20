import 'package:flutter/material.dart';
import 'package:login_and_register_api/view_model/services/splash_services.dart';


class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  SplashServices splashServices = SplashServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    splashServices.checkAuthentication(context);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Color.fromRGBO(143, 148, 251, 1),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
      
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 15,),
              Center(
                child: SizedBox(
                  height: 300,
                  width: 300,
                  child: Image.asset('images/transfer.png'),
                ),
              ),
              const SizedBox(height: 70,),
              const Center(
                child: Text('The Best App',
                  style: TextStyle(
                      color: Color(0xFFffffff),
                      fontSize: 24,fontWeight: FontWeight.bold,
                      letterSpacing: 4
                  ),
                ),
              ),
              Center(
                child: Text('For You',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 22,fontWeight: FontWeight.w500,
                      letterSpacing: 4
                  ),
                ),
              ),
              const SizedBox(height: 25,),
              const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 5,
                backgroundColor: Colors.black54,
              )
            ],
          ),
        ),
      
      ),
    );
  }
}
