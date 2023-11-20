import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_and_register_api/utils/routes/routes.dart';
import 'package:login_and_register_api/utils/routes/routes_name.dart';
import 'package:login_and_register_api/view_model/auth_view_model.dart';
import 'package:login_and_register_api/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor:  Color.fromRGBO(143, 148, 251, 45),
      statusBarColor: Color.fromRGBO(143, 148, 251, 45)
  ));
  SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
      const MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthViewModel()),
          ChangeNotifierProvider(create: (_) => UserViewModel())
        ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
               theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: RoutesName.splash,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}

