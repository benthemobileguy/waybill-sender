import 'package:mdi/mdi.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:waybill_sender/bloc/index.dart';
import 'package:waybill_sender/modules/auth/forgot_password_screen.dart';
import 'package:waybill_sender/modules/auth/register-screen.dart';
import 'package:waybill_sender/services/network-service.dart';
import 'package:waybill_sender/theme/app-theme.dart';
import 'package:waybill_sender/widgets/base.dart';
import 'package:waybill_sender/widgets/custom-button.dart';
import 'package:waybill_sender/widgets/default-text-form-field.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  NetworkService authenticationService;
  bool isLoading = false;
  bool _showPassword = false;

  MainBloc mainBloc;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authenticationService = new NetworkService(context: context);
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    mainBloc = Provider.of<MainBloc>(context, listen:false);
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.only(right: 15,
                left: 15),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Text("Sign In",
                        style: TextStyle(
                          fontSize: 26,
                          height: 1.6,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'DMSans',
                          color: AppColors.customDark,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: DefaultTextFormField(
                        fillColorCode: "#ffffff",
                        controller: _emailController,
                        borderColor: AppColors.dropDownCard,
                        validator: (value) {
                          if (!EmailValidator.validate(
                              value.trim())) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                        hintText: "Email",
                        prefixIcon: Icon(Icons.person_outline),
                        textColor: HexColor("#6B6A6A"),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    DefaultTextFormField(
                      prefixIcon: Icon(Icons.lock_outline_rounded),
                      suffixIcon: InkWell(
                        child: _showPassword
                            ? IconButton(
                            icon:Icon(Mdi.eye)
                        ) : IconButton(
                            icon:Icon(Mdi.eyeOff)
                        ),
                        onTap: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                      ),
                      obscureText: !_showPassword,
                      fillColorCode: "#ffffff",
                      controller: _passwordController,
                      borderColor: AppColors.dropDownCard,
                      validator: (value) {
                        if (value.isEmpty ||
                            value.length < 5) {
                          return 'Password must be at least 5 characters';
                        }
                        return null;
                      },
                      hintText: "Password",
                      textColor: HexColor("#6B6A6A"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: FlatButton(
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                                ForgotPasswordPage()),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Text("Forgot Password",
                            style: TextStyle(
                              color: HexColor("#6B6A6A"),
                              fontSize:12,
                              fontFamily: 'DMSans',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    !isLoading?Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      height: 55,
                      width: double.infinity,
                      child: CustomButton(
                        borderColor: AppColors.darkBlue,
                        color: AppColors.darkBlue,
                        textColor: Colors.white,
                        onPressed: () {
                        signIn();
                        },
                        text: 'Sign In',
                      ),
                    ):CircularProgressIndicator(
                      color: AppColors.darkBlue,
                      strokeWidth: 2,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("I do not have an account.",
                          style: TextStyle(
                            color: HexColor("#060C38"),
                            fontSize:12,
                            fontFamily: 'DMSans',
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  RegisterScreen()),
                            );
                          },
                          child: Text("Create Account",
                            style: TextStyle(
                              color: AppColors.customDark,
                              fontSize:12,
                              fontFamily: 'DMSans',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  signIn() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        Map<String, dynamic> _res = await
        authenticationService.login(
            _emailController.text,
            _passwordController.text);
        setState(() {
          isLoading = false;
        });
        if(_res['data'] != null){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Base()),
          );

        }

      } catch (e) {
        print(e.toString());
        setState(() {
          isLoading = false;
        });
      }
    }
  }



  Future<bool> _onWillPop() {
    return SystemNavigator.pop();
  }
}
