import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quiz_app/services/firebase_auth_services.dart';
import 'package:quiz_app/utils/extension/extension.dart';
import 'package:quiz_app/views/screens/home_screen.dart';
import '../../../utils/color/app_color.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/image_path/images_path.dart';
import '../../../utils/style/app_text_style.dart';
import '../widgets/show_dialog_error.dart';
import '../widgets/text_field.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firebaseAuthServices = FirebaseAuthServices();

  bool isLoading = false;

  Future<void> submit() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      try {
        setState(() {
          isLoading = true;
        });

        await firebaseAuthServices.login(
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
              const Text(
                "Hello Again!",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              10.boxH(),
              const Text("Welcome Back You've been missed"),
              20.boxH(),
              InputText(
                controller: emailController,
                title: "Email",
                regExp: AppConstants.emailRegExp,
              ),
              10.boxH(),
              InputText(
                controller: passwordController,
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
                  child: const Text("Login"),
                ),
              ),
              20.boxH(),
              SizedBox(
                width: 325,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) {
                          return HomeScreen();
                        },
                      ),
                    );
                  },
                  icon: SvgPicture.asset(AppIconsSvg.googleIcon),
                  label: Text(
                    'Sign With Google',
                    style: AppTextStyle.thin
                        .copyWith(color: AppColors.c0A0D14, fontSize: 12),
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              10.boxH(),
              SizedBox(
                width: 325,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) {
                          return HomeScreen();
                        },
                      ),
                    );
                  },
                  icon: SvgPicture.asset(AppIconsSvg.appleIcon, height: 24),
                  label: Text(
                    'Sign With Apple',
                    style: AppTextStyle.medium
                        .copyWith(color: AppColors.c0A0D14, fontSize: 12),
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Hisobingiz yo'qmi?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (ctx) => RegisterScreen()),
                      );
                    },
                    child: Text("Ro'yxatdan o'tish"),
                  ),
                ],
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
    super.dispose();
  }
}
