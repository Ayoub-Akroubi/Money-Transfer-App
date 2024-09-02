import 'package:flutter/material.dart';
import 'package:money_transfer_app/src/providers/userProvider.dart';
import 'package:money_transfer_app/src/routes/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
        routes: AppRoutes.routes,
    );
  }
}

