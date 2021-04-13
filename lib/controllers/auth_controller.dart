import 'package:barberbla/controllers/user_controller.dart';
import 'package:barberbla/models/user_model.dart';
import 'package:barberbla/utils/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<User> _firebaseUser = Rx<User>(null);
  UserController _userController = Get.put(UserController());

  String get user => _firebaseUser.value?.uid;

  @override
  void onInit() {
    _firebaseUser.bindStream(_auth.authStateChanges());
    super.onInit();
  }

  void signUp(String name, String email, String password) async {
    EasyLoading.show(status: 'Loading...');
    try {
      UserCredential _userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      UserModel _user = UserModel(
        id: _userCredential.user.uid,
        name: name,
        email: _userCredential.user.email,
        privilege: 'customer',
      );
      if (await Database().createNewUser(_user)) {
        _userController.user = _user;
        Get.offAndToNamed('/');
      }
    } catch (e) {
      Get.snackbar("Error creating account ", e.message);
    }
    EasyLoading.dismiss();
  }

  void login(String email, String password) async {
    EasyLoading.show(status: 'Loading...');
    try {
      UserCredential _userCredential = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
      _userController.user = await Database().getUser(_userCredential.user.uid);
      Get.offAndToNamed('/');
    } catch (e) {
      Get.snackbar("Error sign in ", e.message);
    }
    EasyLoading.dismiss();
  }

  void forgotPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Get.snackbar('Password Reset',
          'An Email has been sent to your email for password reset');
    } catch (e) {
      Get.snackbar('Error for forgot password', e.message);
    }
  }

  void signout() async {
    try {
      await _auth.signOut();
      _userController.clear();
      Get.offAndToNamed('/');
    } catch (e) {
      Get.snackbar("Something went wrong..", e.message);
    }
  }
}
