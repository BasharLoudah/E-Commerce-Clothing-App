import 'package:e_commerece_app/core/style/text/apptextstyle.dart';
import 'package:e_commerece_app/features/home/presentation/pages/Signinscreen.dart';
import 'package:e_commerece_app/features/home/presentation/pages/forgot_password.dart';
import 'package:e_commerece_app/features/home/presentation/widgets/build_back_button.dart';
import 'package:flutter/material.dart';

class CreateAccount extends StatelessWidget {
  const CreateAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(27.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BuildBackButton(context: context),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Text(
                  'Create Account',
                  style: AppTextStyles.black32Login,
                ),
              ),
              const SizedBox(height: 20),
              const CustomTextField(hintText: 'First Name'),
              const SizedBox(height: 16),
              const CustomTextField(hintText: 'Last Name'),
              const SizedBox(height: 16),
              const CustomTextField(hintText: 'Email Address'),
              const SizedBox(height: 16),
              const CustomTextField(hintText: 'Password'),
              const SizedBox(height: 16),
              Container(
                width: 344,
                height: 49,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 142, 108, 239),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignInScreen(),
                      ),
                    );
                  },
                  child: Text('Continue', style: AppTextStyles.white16),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    "Forgot Password ?",
                    style: AppTextStyles.black12w500,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPassword(),
                        ),
                      );
                    },
                    child: Text(
                      'Reset',
                      style: AppTextStyles.black12w700,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String hintText;
  const CustomTextField({super.key, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 324,
      height: 56,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 244, 244, 244),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: TextFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: AppTextStyles.black16w05,
          ),
        ),
      ),
    );
  }
}
