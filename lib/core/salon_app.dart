import 'dart:ui' as ui; // Add this import for TextDirection

import 'package:e_commerece_app/core/common/app%20manager/app_manager_cubit.dart';
import 'package:e_commerece_app/core/common/app%20manager/app_manager_state.dart';
import 'package:e_commerece_app/core/routes/routes_paths.dart';
import 'package:e_commerece_app/features/home/presentation/pages/loginpage.dart';
import 'package:e_commerece_app/features/home/presentation/pages/main_page.dart';
import 'package:e_commerece_app/features/home/presentation/pages/sign_up_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SalonApp extends StatefulWidget {
  final String? initialToken;

  const SalonApp({super.key, this.initialToken});

  @override
  State<SalonApp> createState() => _SalonAppState();
}

class _SalonAppState extends State<SalonApp> {
  late final ValueNotifier<String?> _tokenNotifier;
  ui.TextDirection _textDirection = ui.TextDirection.ltr;

  @override
  void initState() {
    super.initState();
    _tokenNotifier = ValueNotifier(widget.initialToken);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateTextDirection();
  }

  void _updateTextDirection() {
    final locale = context.locale;
    setState(() {
      _textDirection = locale.languageCode == 'ar'
          ? ui.TextDirection.rtl
          : ui.TextDirection.ltr;
    });
  }

  @override
  void dispose() {
    _tokenNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String?>(
      valueListenable: _tokenNotifier,
      builder: (context, token, _) {
        final router = GoRouter(
          initialLocation: token != null ? RoutesPaths.home : RoutesPaths.login,
          routes: [
            GoRoute(
              path: RoutesPaths.home,
              pageBuilder: (context, state) => MaterialPage(
                key: state.pageKey,
                child: Directionality(
                  textDirection: _textDirection,
                  child: const MainHomePage(),
                ),
              ),
            ),
            GoRoute(
              path: RoutesPaths.signUp,
              pageBuilder: (context, state) => MaterialPage(
                key: state.pageKey,
                child: Directionality(
                  textDirection: _textDirection,
                  child: const SignUpPage(),
                ),
              ),
            ),
            GoRoute(
              path: RoutesPaths.login,
              pageBuilder: (context, state) => MaterialPage(
                key: state.pageKey,
                child: Directionality(
                  textDirection: _textDirection,
                  child: const LoginPage(),
                ),
              ),
            ),
          ],
        );

        return BlocProvider(
          create: (context) => AppManagerCubit()..initApp(),
          child: Builder(
            builder: (context) {
              return BlocBuilder<AppManagerCubit, AppManagerState>(
                builder: (context, state) {
                  return Directionality(
                    textDirection: _textDirection,
                    child: MaterialApp.router(
                      debugShowCheckedModeBanner: false,
                      localizationsDelegates: context.localizationDelegates,
                      supportedLocales: context.supportedLocales,
                      locale: context.locale,
                      title: 'Flutter Demo',
                      theme: ThemeData(
                        colorScheme:
                            ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                        useMaterial3: true,
                      ),
                      routerConfig: router,
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
