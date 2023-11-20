import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_and_register_api/res/components/round_button.dart';
import 'package:login_and_register_api/utils/routes/routes_name.dart';
import 'package:login_and_register_api/utils/utils.dart';
import 'package:login_and_register_api/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';


class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {


  final ImagePicker _imagePicker = ImagePicker();
  Uint8List? _selectedImage;


  // Future<String> _uploadProfileImageToStorage(Uint8List image) async {
  //   Reference ref = FirebaseStorage.instance.ref().child('profilePics/${_auth.currentUser!.uid}');
  //   UploadTask uploadTask = ref.putData(image);
  //
  //   TaskSnapshot snapshot = await uploadTask;
  //   String downloadUrl = await snapshot.ref.getDownloadURL();
  //   return downloadUrl;
  // }

  Future<void> _pickImage(ImageSource source) async {
    XFile? pickedImage = await _imagePicker.pickImage(source: source);

    if (pickedImage != null) {
      Uint8List imageData = await pickedImage.readAsBytes();
      setState(() {
        _selectedImage = imageData;
      });
    } else {
      print('No image selected');
    }
  }



  ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _companyNameController = TextEditingController();
  TextEditingController _regnumberController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _fundController = TextEditingController();
  TextEditingController _breaktimeController = TextEditingController();


  FocusNode nameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode companyNameFocusNode  = FocusNode();
  FocusNode  regnumberFocusNode= FocusNode();
  FocusNode  addressFocusNode= FocusNode();
  FocusNode  phoneFocusNode= FocusNode();
  FocusNode  descriptionFocusNode= FocusNode();
  FocusNode  fundFocusNode= FocusNode();
  FocusNode  breaktimeFocusNode= FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _companyNameController.dispose();
    _regnumberController.dispose();
    _addressController.dispose();
    _phoneNumberController.dispose();
    _descriptionController.dispose();
    _fundController.dispose();
    _breaktimeController.dispose();

    nameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    companyNameFocusNode.dispose();
    regnumberFocusNode.dispose();
    addressFocusNode.dispose();
    phoneFocusNode.dispose();
    descriptionFocusNode.dispose();
    fundFocusNode.dispose();
    breaktimeFocusNode.dispose();

    _obsecurePassword.dispose();

  }

  @override
  Widget build(BuildContext context) {
    final authViewMode = Provider.of<AuthViewModel>(context);

    final height  = MediaQuery.of(context).size.height * 1 ;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('SingUp'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
      
      
              Stack(
                children: [
                  _selectedImage != null
                      ? CircleAvatar(
                    radius: 50,
                    backgroundColor: Color.fromRGBO(143, 148, 251, 1),
                    backgroundImage: MemoryImage(_selectedImage!),
      
                  )
                      : CircleAvatar(
                    radius: 50,
                    backgroundColor: Color.fromRGBO(143, 148, 251, .6),
                    // backgroundImage: NetworkImage('https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.personality-insights.com%2Fdefault-profile-pic%2F&psig=AOvVaw3iC9pqa2IwaAi59YFoiWq_&ust=1685530640374000&source=images&cd=vfe&ved=0CBMQjhxqFwoTCMCJlovxnP8CFQAAAAAdAAAAABAE'),
                  ),
                  Positioned(
                    right: 0,
                    top: 1,
                    child: IconButton(
                      onPressed: (){
                        _pickImage(ImageSource.gallery);
                      },
                      icon: Icon(Icons.photo,color: Colors.white,),
                    ),
                  ),
                ],
              ),
              Text("Upload Image"),
      
      
            //For Name
              TextFormField(
                controller: _nameController,
                keyboardType: TextInputType.name,
                focusNode: nameFocusNode,
                decoration: const InputDecoration(
                    hintText: 'Full Name',
                    labelText: 'Full Name',
                    prefixIcon: Icon(Icons.account_box)
                ),
                onFieldSubmitted: (valu){
                  Utils.fieldFocusChange(context, nameFocusNode, emailFocusNode,);
                },
              ),
      
              //For Email
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                focusNode: emailFocusNode,
                decoration: const InputDecoration(
                    hintText: 'Email',
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.alternate_email)
                ),
                onFieldSubmitted: (valu){
                  Utils.fieldFocusChange(context, emailFocusNode, passwordFocusNode);
                },
              ),
              SizedBox(height: height * .02,),
              //For Password
              ValueListenableBuilder(
                  valueListenable: _obsecurePassword,
                  builder: (context , value, child){
                    return TextFormField(
                      controller: _passwordController,
                      obscureText: _obsecurePassword.value,
                      focusNode: passwordFocusNode,
      
                      obscuringCharacter: "*",
                      decoration: InputDecoration(
                        hintText: 'Password',
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock_open_rounded),
                        suffixIcon: InkWell(
                            onTap: (){
                              _obsecurePassword.value = !_obsecurePassword.value ;
                            },
                            child: Icon(
                                _obsecurePassword.value ?  Icons.visibility_off_outlined :
                                Icons.visibility
                            )),
      
                      ),
                      onFieldSubmitted: (valu){
                        Utils.fieldFocusChange(context, passwordFocusNode, companyNameFocusNode);
                      },
                    );
      
                  }
              ),
              SizedBox(height: height * .02,),
      
              //For companyNameFocusNode
              TextFormField(
                controller: _companyNameController,
                keyboardType: TextInputType.name,
                focusNode: companyNameFocusNode,
                decoration: const InputDecoration(
                    hintText: 'companyName',
                    labelText: 'companyName',
                    prefixIcon: Icon(Icons.cabin_outlined)
                ),
                onFieldSubmitted: (valu){
                  Utils.fieldFocusChange(context, companyNameFocusNode, regnumberFocusNode,);
                },
              ),
              SizedBox(height: height * .02,),
      
              //For regnumberFocusNode
              TextFormField(
                controller: _regnumberController,
                keyboardType: TextInputType.number,
                focusNode: regnumberFocusNode,
                decoration: const InputDecoration(
                    hintText: 'Registration Number',
                    labelText: 'Registration Number',
                    prefixIcon: Icon(Icons.app_registration)
                ),
                onFieldSubmitted: (valu){
                  Utils.fieldFocusChange(context, regnumberFocusNode, addressFocusNode);
                },
              ),
              SizedBox(height: height * .02,),
      
              //For addressFocusNode
              TextFormField(
                controller: _addressController,
                keyboardType: TextInputType.emailAddress,
                focusNode: addressFocusNode,
                decoration: const InputDecoration(
                    hintText: 'address',
                    labelText: 'address',
                    prefixIcon: Icon(Icons.location_on)
                ),
                onFieldSubmitted: (valu){
                  Utils.fieldFocusChange(context, addressFocusNode, phoneFocusNode);
                },
              ),
              SizedBox(height: height * .02,),
      
              //For phoneFocusNode
              TextFormField(
                controller: _phoneNumberController,
                keyboardType: TextInputType.number,
                focusNode: phoneFocusNode,
                decoration: const InputDecoration(
                    hintText: 'Phone Number',
                    labelText: 'Phone Number',
                    prefixIcon: Icon(Icons.phone)
                ),
                onFieldSubmitted: (valu){
                  Utils.fieldFocusChange(context, phoneFocusNode, descriptionFocusNode);
                },
              ),
              SizedBox(height: height * .02,),
      
      
              //For descriptionFocusNode
              TextFormField(
                controller: _descriptionController,
                keyboardType: TextInputType.text,
                focusNode: descriptionFocusNode,
                decoration: const InputDecoration(
                    hintText: 'description',
                    labelText: 'description',
                    prefixIcon: Icon(Icons.details)
                ),
                onFieldSubmitted: (valu){
                  Utils.fieldFocusChange(context, descriptionFocusNode, fundFocusNode);
                },
              ),
              SizedBox(height: height * .02,),
      
              //For fundFocusNode
              TextFormField(
                controller: _fundController,
                keyboardType: TextInputType.number,
                focusNode: fundFocusNode,
                decoration: const InputDecoration(
                    hintText: 'funding Limit',
                    labelText: 'funding Limit',
                    prefixIcon: Icon(Icons.comment_bank_outlined)
                ),
                onFieldSubmitted: (valu){
                  Utils.fieldFocusChange(context, fundFocusNode, breaktimeFocusNode);
                },
              ),
              SizedBox(height: height * .02,),
      
              //For breaktimeFocusNode
              TextFormField(
                controller: _breaktimeController,
                keyboardType: TextInputType.number,
                focusNode: breaktimeFocusNode,
                decoration: const InputDecoration(
                    hintText: 'Break time',
                    labelText: 'Break time',
                    prefixIcon: Icon(Icons.insert_page_break_outlined)
                ),
              ),
              SizedBox(height: height * .02,),
      
      
              RoundButton(
                title: 'Sign Up',
                loading: authViewMode.signUpLoading,
                onPress: (){
                  if(_nameController.text.isEmpty){
                    Utils.flushBarErrorMessage('Please enter Full Name', context);
                  }
                  else if(_emailController.text.isEmpty){
                    Utils.flushBarErrorMessage('Please enter email', context);
                  }
                  else if(_passwordController.text.length < 6){
                    Utils.flushBarErrorMessage('Please enter 6 digit password', context);
                  }
                  else if(_companyNameController.text.isEmpty){
                    Utils.flushBarErrorMessage('Please enter your company name', context);
                  }
                  else if(_regnumberController.text.isEmpty){
                    Utils.flushBarErrorMessage('Please enter registration number', context);
                  }
                  else if(_addressController.text.isEmpty){
                    Utils.flushBarErrorMessage('Please enter your full address', context);
                  }else if(_phoneNumberController.text.isEmpty){
                    Utils.flushBarErrorMessage('Please enter phone number', context);
                  }
      
                  else if(_descriptionController.text.isEmpty){
                    Utils.flushBarErrorMessage('Please enter description', context);
      
                  }
                  else if(_fundController.text.isEmpty){
                    Utils.flushBarErrorMessage('Please enter Funding Limit', context);
      
                  }else if(_selectedImage!.isEmpty){
                    Utils.flushBarErrorMessage('Please enter Image', context);
      
                  }else if(_breaktimeController.text.isEmpty){
                    Utils.flushBarErrorMessage('Please enter break time', context);
      
                  }else {
                    Map data = {
                      'name':_nameController.text.toString(),
                      'email' : _emailController.text.toString(),
                      'password' : _passwordController.text.toString(),
                      'company_name': _companyNameController.text.toString(),
                      'reg_number': _regnumberController.text.toString(),
                      'address': _addressController.text.toString(),
                      'phone': _phoneNumberController.text.toString(),
                      'description': _descriptionController.text.toString(),
                      'funding_limit': _fundController.text.toString(),
                      'image':null,
                      'break_time': 0.0
      
                    };
      
                    authViewMode.signUpApi(data , context);
                    print('api hit');
                    _emailController.clear();
                    _passwordController.clear();
                    _nameController.clear();
                    _companyNameController.clear();
                    _regnumberController.clear();
                    _addressController.clear();
                    _phoneNumberController.clear();
                    _descriptionController.clear();
                    _fundController.clear();
                    _breaktimeController.clear();
                  }
                },
              ),
              SizedBox(height: height * .02,),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, RoutesName.login);
                },
                  child: Text("Already  hace an accont? Login"))
      
            ],
          ),
        ),
      ),
    );
  }
}
