import 'package:barberbla/models/user_model.dart';
import 'package:barberbla/utils/database.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  Rx<UserModel> _userModel = UserModel().obs;

  UserModel get user => _userModel.value;

  set user(UserModel value) => this._userModel.value = value;

  void clear() {
    _userModel.value = UserModel();
  }

  void syncFirebase(String uid) async {
    try {
      _userModel.value = await Database().getUser(uid);
    } catch (e) {
      rethrow;
    }
  }
}
