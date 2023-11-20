import 'package:flutter/material.dart';
import 'package:login_and_register_api/utils/routes/routes_name.dart';
// import 'package:login_and_register_api/view_model/home_view_model.dart';
import 'package:login_and_register_api/view_model/user_view_model.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // HomeViewViewModel  homeViewViewModel = HomeViewViewModel();
  
  @override
  void initState() {
    // TODO: implement initState
    // homeViewViewModel.fetchMoviesListApi();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    final userPrefernece = Provider.of<UserViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          InkWell(
              onTap: (){
                userPrefernece.remove().then((value){
                  Navigator.pushNamed(context, RoutesName.login);
                });
              },
              child: Center(child: Text('Logout'))),
          SizedBox(width: 20,)
        ],
      ),
      body: Center(
        child: Text("Home Page reched Successfully"),
      ),
    );
  }
}
