import 'package:appwrite_auth_kit/appwrite_auth_kit.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviematch/appwrite_client.dart';
import 'package:moviematch/authentication/presentation/pages/login_page.dart';
import 'package:moviematch/home/presentation/pages/home_page.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppwriteAuthKit(
      client: ref.watch(appwriteClientProvider),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: FlexThemeData.light(
          scheme: FlexScheme.amber,
          useMaterial3: true,
        ),
        darkTheme: FlexThemeData.dark(
          scheme: FlexScheme.amber,
          useMaterial3: true,
        ),
        home: const AppScreen(),
      ),
    );
  }
}

class AppScreen extends StatelessWidget {
  const AppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authNotifier = context.authNotifier;

    Widget widget;
    switch (authNotifier.status) {
      case AuthStatus.authenticated:
        widget = const HomePage();
        break;
      case AuthStatus.unauthenticated:
      case AuthStatus.authenticating:
        widget = const LoginPage();
        break;
      case AuthStatus.uninitialized:
      default:
        widget = const Scaffold(
          body: Center(
            child: CupertinoActivityIndicator(),
          ),
        );
        break;
    }
    return widget;
  }
}
