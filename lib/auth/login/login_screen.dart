import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_colors.dart';
import 'package:todo/auth/custom_text_form_field.dart';
import 'package:todo/auth/register/register_screen.dart';
import 'package:todo/dialog_utils.dart';
import 'package:todo/firebase_functions.dart';
import 'package:todo/home/home_screen.dart';
import 'package:todo/provider/auth_user_provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'Login Screen';

  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController =
      TextEditingController(text: 'ahmed@gmail.com');

  TextEditingController passwordController =
      TextEditingController(text: '123456');

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: Text(
              "Login",
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Welcome Back!',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: AppColors.blackColor)),
                  ),
                  SizedBox(
                    height: 25,
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
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: ElevatedButton(
                      onPressed: () {
                        Login();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        elevation: 0,
                      ),
                      child: Text(
                        'Login',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                color: AppColors.whiteColor, fontSize: 20),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        RegisterScreen.routeName,
                      );
                    },
                    child: Text(
                      'OR Create Account',
                      style: Theme.of(context).textTheme.titleSmall,
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

  void Login() async {
    if (formKey.currentState?.validate() == true) {
      /// Login
      /// todo : show loading
      DialogUtils.showLoading(context: context, message: 'Loading...');

      try {
        final credential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        var user = await FirebaseFunctions.readUserFromFirestore(
            credential.user?.uid ?? '');
        if (user == null) {
          return;
        }
        var authProvider =
            Provider.of<AuthUserProvider>(context, listen: false);
        authProvider.updateUser(user);

        /// todo : hide loading
        DialogUtils.hideLoading(context: context);

        /// todo : show message
        DialogUtils.showMessage(
          posActionName: 'ok',
          context: context,
          posAction: () {
            Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
          },
          message: 'Login Successfully',
          title: 'Success',
        );
        print(credential.user?.uid);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          // todo : hide loading
          DialogUtils.hideLoading(context: context);

          /// todo : show message
          DialogUtils.showMessage(
            context: context,
            posActionName: 'ok',
            message:
                'The supplied auth credential is incorrect, malformed or has expired.',
            title: 'Failed',
          );
          print(
              'The supplied auth credential is incorrect, malformed or has expired.');
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
          posActionName: 'ok',
          context: context,
          message: e.toString(),
          title: 'Error',
        );
        print(e.toString());
      }
    }
  }
}
