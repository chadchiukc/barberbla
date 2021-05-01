import 'package:barberbla/controllers/auth_controller.dart';
import 'package:barberbla/widgets/background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Signup extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final AuthController _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: background,
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
                  padding: EdgeInsets.symmetric(
                      horizontal: getValueForScreenType(
                          context: context,
                          mobile: 30,
                          tablet: Get.width * 0.2,
                          desktop: Get.width * 0.3)),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "Sign Up",
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
                                    hintText: 'Name',
                                    prefixIcon: Icon(
                                      Icons.person,
                                    )),
                                controller: _name,
                              ),
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
                              SizedBox(
                                height: 50,
                              ),
                              SizedBox(
                                height: 50,
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    primary: Color.fromARGB(255, 77, 208, 225),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      _authController.signUp(
                                          _name.text, _email.text, _pass.text);
                                    }
                                  },
                                  child: Text(
                                    'Sign Up',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Or do you have an account?     ',
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text(
                                      'Log in',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2
                                          .copyWith(
                                              decoration:
                                                  TextDecoration.underline),
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
