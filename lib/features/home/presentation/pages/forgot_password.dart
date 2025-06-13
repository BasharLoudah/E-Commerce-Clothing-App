import 'package:e_commerece_app/core/style/text/apptextstyle.dart';
import 'package:e_commerece_app/features/home/presentation/pages/create_account.dart';
import 'package:e_commerece_app/features/home/presentation/widgets/build_back_button.dart';
import 'package:e_commerece_app/features/home/presentation/widgets/sent_email_to_reset_password.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

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
                          ' Forgot Password',
                          style: AppTextStyles.black32Login,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const CustomTextField(hintText: 'Enter Email address'),
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
                                builder: (context) => const SentEmailPassword(),
                              ),
                            );
                          },
                          child: Text('Continue', style: AppTextStyles.white16),
                        ),
                      ),
                    ]))));
  }
}
