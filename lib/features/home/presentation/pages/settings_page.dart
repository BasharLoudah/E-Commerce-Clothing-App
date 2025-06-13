import 'package:e_commerece_app/features/home/presentation/pages/UpdateProductPage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerece_app/features/home/presentation/managers/Auth/auth_cubit.dart';
import 'package:e_commerece_app/features/home/presentation/managers/Auth/auth_state.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'.tr()),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              ListTile(
                leading: const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(
                      'assets/images/hoodies.png'), // Replace with your asset
                ),
                title: Text('User Name'.tr()),
                subtitle: Text('+971 123 456 7890'.tr()),
              ),
              const SizedBox(height: 16),
              Text('Account'.tr(),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              ListTile(
                title: Text('Edit Profile'.tr()),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigate to Edit Profile
                },
              ),
              ListTile(
                title: Text('Billing & Payments'.tr()),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigate to Billing & Payments
                },
              ),
              ListTile(
                title: Text('Failed Page'.tr()),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const UpdateProductPage(productId: '25'),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              Text('Settings'.tr(),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              SwitchListTile(
                title: Text('App Notifications'.tr()),
                value: true,
                onChanged: (bool value) {
                  // Handle notification toggle
                },
              ),
              // REMOVED THE BLOCK BELOW AND REPLACED WITH FIXED VERSION
              // BlocProvider(
              //   create: (context) => AuthCubit(remote: AuthRemoteDataSource()),
              //   child:
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) async {
                  if (state.isLoading) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) =>
                          const Center(child: CircularProgressIndicator()),
                    );
                  } else {
                    // Close loading dialog if it's open
                    if (Navigator.of(context, rootNavigator: true).canPop()) {
                      Navigator.of(context, rootNavigator: true).pop();
                    }
                  }

                  if (state.error != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error!)),
                    );
                  }

                  if (state.authData == null) {
                    const storage = FlutterSecureStorage();
                    await storage.delete(key: 'token'); // Clear token
                    context.go('/login'); // Navigate to login page
                  }
                },
                builder: (context, state) {
                  return Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          context.read<AuthCubit>().logout();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: Text('Log Out'.tr()),
                      ),
                      TextButton(
                        onPressed: () {
                          // Add Delete Account logic
                        },
                        child: Text(
                          'Delete My Account'.tr(),
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  );
                },
              ),
              // REMOVED THE CLOSING PARENTHESIS FOR BLOCKPROVIDER
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
