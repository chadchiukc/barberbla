import 'package:barberbla/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _forgot = TextEditingController();
  final AuthController _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.3),
              BlendMode.dstATop,
            ),
            image: AssetImage('assets/images/login_background.jpeg'),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Stack(
            fit: StackFit.expand,
            children: [
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "Sign in",
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ),
                        Image(
                          image: AssetImage('assets/images/barberbla.png'),
                          height: 350,
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                decoration: InputDecoration(
                                    hintText: 'Email',
                                    prefixIcon: Icon(
                                      Icons.email_rounded,
                                    )),
                                controller: _email,
                                validator: (value) {
                                  if (!GetUtils.isEmail(value)) {
                                    return 'Please enter a valid email address';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    hintText: 'Password',
                                    prefixIcon:
                                        Icon(Icons.fingerprint_rounded)),
                                controller: _pass,
                                obscureText: true,
                                validator: (value) {
                                  if (value.length < 8) {
                                    return 'Please enter a password with at least 8 digits';
                                  }
                                  return null;
                                },
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                    onPressed: () {
                                      Get.defaultDialog(
                                        title:
                                            '      Please enter your email        ',
                                        titleStyle: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                        content: TextField(
                                          decoration: InputDecoration(
                                              prefixIcon: Icon(Icons.email),
                                              hintText: 'Your Email'),
                                          controller: _forgot,
                                        ),
                                        confirm: TextButton(
                                          onPressed: () {
                                            _authController
                                                .forgotPassword(_forgot.text);
                                            Get.back();
                                          },
                                          child: Text('Confirm'),
                                        ),
                                        cancel: TextButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: Text('Cancel'),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Forgot Password?',
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
                                    )),
                              ),
                              SizedBox(
                                height: 50,
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      _authController.login(
                                          _email.text, _pass.text);
                                    }
                                  },
                                  child: Text(
                                    'Sign In',
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Don\'t have an account?     ',
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Get.toNamed('/signup');
                                    },
                                    child: Text(
                                      'Sign Up',
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}