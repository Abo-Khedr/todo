import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_colors.dart';
import 'package:todo/auth/custom_text_form_field.dart';
import 'package:todo/dialog_utils.dart';
import 'package:todo/firebase_functions.dart';
import 'package:todo/home/home_screen.dart';
import 'package:todo/model/my_user.dart';
import 'package:todo/provider/auth_user_provider.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'Register Screen';

  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController userNameController =
      TextEditingController(text: 'ahmed');

  TextEditingController emailController =
      TextEditingController(text: 'ahmed@gmail.com');

  TextEditingController passwordController =
      TextEditingController(text: '123456');

  TextEditingController confirmPasswordController =
      TextEditingController(text: '123456');

  var formKey = GlobalKey<FormState>();

  //late var authProvider ;

  @override
  Widget build(BuildContext context) {
    //authProvider = Provider.of<AuthUserProvider>(context);
    return Stack(
      children: [
        Container(
          color: AppColors.whiteColor,
          child: Image.asset(
            'assets/images/background.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: AppColors.whiteColor,
            ),
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: Text(
              "Create Account",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          body: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.25,
                  ),
                  CustomTextFormField(
                    lable: 'User Name',
                    controller: userNameController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please enter user name.';
                      }
                      return null;
                    },
                  ),
                  CustomTextFormField(
                    lable: 'Email',
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please enter email.';
                      }
                      final bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(text);
                      if (!emailValid) {
                        return 'Please enter valid email.';
                      }
                      return null;
                    },
                  ),
                  CustomTextFormField(
                    lable: 'Password',
                    controller: passwordController,
                    obscureText: true,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please enter password.';
                      }
                      if (text.length < 6) {
                        return 'Password should be at least 6 chars.';
                      }
                      return null;
                    },
                  ),
                  CustomTextFormField(
                    lable: 'Confirm Password',
                    controller: confirmPasswordController,
                    obscureText: true,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please enter confirm password.';
                      }
                      if (text != passwordController.text) {
                        return 'Confirm password not match password.';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: ElevatedButton(
                      onPressed: () {
                        register();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        elevation: 0,
                      ),
                      child: Text(
                        'Create Account',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                color: AppColors.whiteColor, fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void register() async {
    if (formKey.currentState?.validate() == true) {
      /// register
      /// todo : show loading
      DialogUtils.showLoading(context: context, message: 'Loading...');
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        MyUser user = MyUser(
          id: credential.user?.uid ?? '',
          name: userNameController.text,
          email: emailController.text,
        );
        var authProvider =
            Provider.of<AuthUserProvider>(context, listen: false);
        authProvider.updateUser(user);
        FirebaseFunctions.addUser(user);

        /// todo : hide loading
        DialogUtils.hideLoading(context: context);

        /// todo : show message
        DialogUtils.showMessage(
            context: context,
            message: 'Register Successfully',
            title: 'Success',
            posActionName: 'ok',
            posAction: () {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            });
        print(credential.user?.uid);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          /// todo : hide loading
          DialogUtils.hideLoading(context: context);

          /// todo : show message
          DialogUtils.showMessage(
            context: context,
            posActionName: 'ok',
            message: 'The password provided is too weak.',
            title: 'Error',
          );
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          /// todo : hide loading
          DialogUtils.hideLoading(context: context);

          /// todo : show message
          DialogUtils.showMessage(
            context: context,
            message: 'The account already exists for that email.',
            title: 'Error',
            posActionName: 'ok',
          );
          print('The account already exists for that email.');
        } else if (e.code == 'network-request-failed') {
          /// todo : hide loading
          DialogUtils.hideLoading(context: context);

          /// todo : show message
          DialogUtils.showMessage(
            context: context,
            message:
                ' A network error (such as timeout, interrupted connection or unreachable host) has occurred.',
            title: 'Error',
            posActionName: 'ok',
          );
          print(
              ' A network error (such as timeout, interrupted connection or unreachable host) has occurred.');
        }
      } catch (e) {
        /// todo : hide loading
        DialogUtils.hideLoading(context: context);

        /// todo : show message
        DialogUtils.showMessage(
          context: context,
          message: e.toString(),
          title: 'Error',
          posActionName: 'ok',
        );
        print(e);
      }
    }
  }
}
