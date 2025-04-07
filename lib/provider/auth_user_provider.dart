import 'package:flutter/material.dart';
import 'package:todo/model/my_user.dart';

class AuthUserProvider extends ChangeNotifier{
  /// data

  MyUser? currentUser;

  /// function

   void updateUser(MyUser newUser){
    currentUser = newUser;
    notifyListeners();
  }
}