import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seatrack_ui/src/core/controllers/auth_controller.dart';
import 'package:seatrack_ui/src/views/constansts/constanst.dart';

import 'forgot_password_page.dart';
import 'registration_page.dart';
import 'widgets/header_auth.dart';

class LoginPage extends GetView<AuthController> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: GetBuilder<AuthController>(
            init: Get.find<AuthController>(),
            builder: (controller) => SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: ValidatorApp.fheaderHeight,
                    child: HeaderAuth(
                        ValidatorApp.fheaderHeight,
                        true,
                        Icons
                            .login_rounded), //let's create a common header widget
                  ),
                  SafeArea(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Column(
                        children: [
                          Image.asset('assets/images/logo_home.png'),
                          const SizedBox(height: 30.0),
                          Form(
                            key: _formKey,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            child: Column(
                              children: [
                                Container(
                                  child: TextFormField(
                                    initialValue: 'ctynewpost',
                                    decoration:
                                        ThemeHelper().textInputDecoration(
                                      'User Name',
                                      'Enter your user name',
                                    ),
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value!.isEmpty)
                                        return 'user invalid or not found';
                                    },
                                    onSaved: (value) {
                                      controller.username = value!;
                                    },
                                  ),
                                  decoration:
                                      ThemeHelper().inputBoxDecorationShaddow(),
                                ),
                                SizedBox(height: 30.0),
                                Container(
                                  child: TextFormField(
                                    initialValue: '123456',
                                    obscureText: controller.passwordVisible!,
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                      hintText: 'Enter your password',
                                      fillColor: Colors.white,
                                      filled: true,
                                      suffix: InkWell(
                                        onTap: controller.togglePasswordVisible,
                                        child: Icon(
                                          controller.passwordVisible!
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                        ),
                                      ),
                                      contentPadding:
                                          EdgeInsets.fromLTRB(20, 10, 20, 10),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(100.0),
                                          borderSide:
                                              BorderSide(color: Colors.grey)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(100.0),
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade400)),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(100.0),
                                          borderSide: BorderSide(
                                              color: Colors.red, width: 2.0)),
                                      focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(100.0),
                                          borderSide: BorderSide(
                                              color: Colors.red, width: 2.0)),
                                    ),
                                    keyboardType: TextInputType.visiblePassword,
                                    validator: (value) {
                                      if (value!.isEmpty)
                                        return 'Password is incorrect';
                                    },
                                    onSaved: (value) {
                                      controller.password = value!;
                                    },
                                  ),
                                  decoration:
                                      ThemeHelper().inputBoxDecorationShaddow(),
                                ),
                                SizedBox(height: 15.0),
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                                  alignment: Alignment.topRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ForgotPasswordPage()),
                                      );
                                    },
                                    child: Text(
                                      "Forgot your password?",
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: ThemeHelper()
                                      .buttonBoxDecoration(context),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                      ),
                                      minimumSize: MaterialStateProperty.all(
                                          Size(170, 50)),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.transparent),
                                      shadowColor: MaterialStateProperty.all(
                                          Colors.transparent),
                                    ),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(40, 10, 40, 10),
                                      child: controller.loading
                                          ? SizedBox(
                                              child: CircularProgressIndicator(
                                                  color: Colors.white),
                                              height: 20.0,
                                              width: 20.0,
                                            )
                                          : Text(
                                              'login'.toUpperCase(),
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                    ),
                                    onPressed: controller.loading
                                        ? null
                                        : () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              _formKey.currentState!.save();
                                              controller
                                                  .signInWithUserAndPassword();
                                            }
                                          },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                                  //child: Text('Don\'t have an account? Create'),
                                  child: Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                            text: "Don\'t have an account? "),
                                        TextSpan(
                                          text: 'Create',
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          RegistrationPage()));
                                            },
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .accentColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
