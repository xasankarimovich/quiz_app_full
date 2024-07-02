import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/services/firebase_auth_services.dart';
import 'package:quiz_app/utils/extension/extension.dart';
import 'package:quiz_app/views/screens/home_screen.dart';
import '../../../utils/constants/app_constants.dart';
import '../../utils/color/app_color.dart';
import '../../utils/style/app_text_style.dart';
import '../widgets/show_dialog_error.dart';
import '../widgets/text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  bool isLoading = false;

  final firebaseAuthServices = FirebaseAuthServices();

  Future<void> submit() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      try {
        setState(() {
          isLoading = true;
        });

        await firebaseAuthServices.register(
          emailController.text,
          passwordController.text,
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (ctx) {
              return HomeScreen();
            },
          ),
        );
      } on FirebaseException catch (error) {
        Helpers.showErrorDialog(context, error.message ?? "xatolik");
      } catch (e) {
        Helpers.showErrorDialog(context, "Tizimda xatolik");
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Create an account",
                style: AppTextStyle.semiBold
                    .copyWith(color: AppColors.c0A0D14, fontSize: 25),
              ),
              20.boxH(),
              InputText(
                controller: emailController,
                title: "Email",
                regExp: AppConstants.emailRegExp,
              ),
              10.boxH(),
              InputText(
                controller: passwordController,
                title: "password",
                regExp: AppConstants.passwordRegExp,
                isPassword: true,
              ),
              10.boxH(),
              InputText(
                controller: passwordConfirmController,
                title: "Password",
                regExp: AppConstants.passwordRegExp,
                isPassword: true,
              ),
              20.boxH(),
              isLoading
                  ? const CircularProgressIndicator()
                  : SizedBox(
                width: double.infinity,
                height: 55,
                child: FilledButton(
                  onPressed: submit,
                  child: const Text("Ro'yxatdan o'tish"),
                ),
              ),
              10.boxH(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Kirish"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    super.dispose();
  }
}
