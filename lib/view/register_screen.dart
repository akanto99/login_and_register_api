import 'dart:typed_data';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'auth_controller.dart';

class BuyerRegisterScreen extends StatefulWidget {
  const BuyerRegisterScreen({Key? key}) : super(key: key);

  @override
  State<BuyerRegisterScreen> createState() => _BuyerRegisterScreenState();
}

class _BuyerRegisterScreenState extends State<BuyerRegisterScreen> {
  final AuthController _authController = AuthController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String email;
  late String fullName;
  late String phoneNumber;
  late String password;

  bool _isLoading = false;

  Uint8List? _image;

  selectGalleryImage() async{
    Uint8List im = await _authController.pickProfileImage(ImageSource.gallery);

    setState(() {
      _image = im;
    });
  }

  selectCameraImage() async{
    Uint8List im = await _authController.pickProfileImage(ImageSource.camera);

    setState(() {
      _image = im;
    });
  }

  _signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      await _authController.signUpUser(
        email,
        fullName,
        phoneNumber,
        password,
        _image,
      ).then((res) {
        setState(() {
          _isLoading = false;
        });
        if (res == 'success') {
          _formKey.currentState!.reset();
          setState(() {
            _image = null;
          });
          showSnack(context, 'Congratulations! Your Account has been Created');
        } else {
          showSnack(context, res);
        }
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      showSnack(context, 'Please fill out all required fields');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('CREATE USERS ACCOUNT',
                  style: GoogleFonts.bebasNeue(
                      textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                        letterSpacing: 2,
                      )
                  ),
                ),
                SizedBox(height: 10,),
                Stack(
                  children: [
                    _image != null
                        ? CircleAvatar(
                      radius: 64,
                      backgroundColor: Color.fromRGBO(143, 148, 251, 1),
                      backgroundImage: MemoryImage(_image!),
                    )
                        : CircleAvatar(
                      radius: 64,
                      backgroundColor: Color.fromRGBO(143, 148, 251, .6),
                      backgroundImage: NetworkImage('https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.personality-insights.com%2Fdefault-profile-pic%2F&psig=AOvVaw3iC9pqa2IwaAi59YFoiWq_&ust=1685530640374000&source=images&cd=vfe&ved=0CBMQjhxqFwoTCMCJlovxnP8CFQAAAAAdAAAAABAE'),
                    ),
                    Positioned(
                      right: 0,
                      top: 5,
                      child: IconButton(
                        onPressed: (){
                          selectGalleryImage();
                        },
                        icon: Icon(CupertinoIcons.photo,color: Colors.white,),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30,),
                Padding(
                  padding: EdgeInsets.all(13.0),
                  child: TextFormField(
                    validator: (value){
                      if (value!.isEmpty){
                        return 'Please Email must not be empty';
                      }else {
                        return null;
                      }
                    },
                    onChanged: (value){
                      email = value;
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      labelText: 'Enter Email',
                      //hintText: 'Enter Category Name',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(13.0),
                  child: TextFormField(
                    validator: (value){
                      if (value!.isEmpty){
                        return 'Please Full Name must not be empty';
                      }else {
                        return null;
                      }
                    },
                    onChanged: (value){
                      fullName = value;
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      labelText: 'Enter Full Name',
                      //hintText: 'Enter Category Name',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(13.0),
                  child: TextFormField(
                    validator: (value){
                      if (value!.isEmpty){
                        return 'Please Phone Number must not be empty';
                      }else {
                        return null;
                      }
                    },
                    onChanged: (value){
                      phoneNumber = value;
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      labelText: 'Enter Phone Number',
                      //hintText: 'Enter Category Name',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(13.0),
                  child: TextFormField(
                    obscureText: true,
                    validator: (value){
                      if (value!.isEmpty){
                        return 'Please password must not be empty';
                      }else {
                        return null;
                      }
                    },
                    onChanged: (value){
                      password = value;
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      labelText: 'Password',
                      //hintText: 'Enter Category Name',
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                GestureDetector(
                  onTap: (){
                    _signUpUser();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width - 40,
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        // Colors.cyanAccent,
                        // Colors.cyan,
                        Color.fromRGBO(143, 148, 251, 1),
                        Color.fromRGBO(143, 148, 251, .6),
                      ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: _isLoading ? CircularProgressIndicator(
                        color: Colors.white,
                      ) :
                      Text('Register',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 4,
                        ),
                      ),
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?'),
                    TextButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return LoginScreen();
                        }));
                      },
                      child: Text('Login'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}