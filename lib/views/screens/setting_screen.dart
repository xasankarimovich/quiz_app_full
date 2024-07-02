import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz_app/services/firebase_auth_services.dart';
import 'package:quiz_app/views/screens/login_screen.dart';

import '../widgets/show_dialog_error.dart'; // Assuming you have this screen

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final emailController = TextEditingController();
  final firebaseAuthServices = FirebaseAuthServices();
  bool isLoading = false;

  Future<void> resetPassword() async {
    if (emailController.text.isNotEmpty) {
      try {
        setState(() {
          isLoading = true;
        });

        await firebaseAuthServices.resetPassword(emailController.text);

        showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text('Password Reset'),
              content: Text('Password reset email sent.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } on FirebaseException catch (error) {
        Helpers.showErrorDialog(context, error.message ?? "Error");
      } catch (e) {
        Helpers.showErrorDialog(context, "System error");
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      Helpers.showErrorDialog(context, "Please enter your email.");
    }
  }

  Future<void> logout() async {
    await firebaseAuthServices.logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
              onPressed: resetPassword,
              child: Text('Reset Password'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: logout,
              child: Text('Logout'),
            ),

          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
