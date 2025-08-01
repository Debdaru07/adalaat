import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'constants/services/app_route.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(AdalatAI());
}

class AdalatAI extends StatelessWidget {
  const AdalatAI({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Adalat AI',
      theme: ThemeData(primarySwatch: Colors.blue),
      routerConfig: AppRouter.routing,
    );
  }
}
