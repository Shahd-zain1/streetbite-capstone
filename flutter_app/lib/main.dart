import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:streetbite/app.dart';
import 'package:streetbite/firebase_options.dart';
import 'package:streetbite/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await configureDependencies();
  runApp(const StreetBiteApp());
}
