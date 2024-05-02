
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:hadayek_hof/Shared/network/local/cache_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:hexcolor/hexcolor.dart';

import 'Cubit/cubit.dart';
import 'Modules/AllZones/zones_screen.dart';
import 'Modules/Opening/offline_widget.dart';

Future<UserCredential> signInAnonymously() async {
  return await FirebaseAuth.instance.signInAnonymously();
}

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  CacheHelper.init();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
await FirebaseAppCheck.instance.activate(
  androidProvider: AndroidProvider.safetyNet,
);
// await signInAnonymously();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => HomeCubit()..createFireStore()..fetchAllZones()..createNewsCollection()..fetchNewsItems()..fetchOfferItems(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'عايز إيه؟',
        theme: ThemeData(
          fontFamily: 'MYRIADPRO',
          textTheme: TextTheme(
            bodyLarge: TextStyle(color: HexColor('#ECB365')),
            bodyMedium: TextStyle(color: HexColor('#ECB365')),
          ),
          primaryColor: HexColor('#074763'),
        ),

        home: OfflineBuilder(connectivityBuilder: (
            BuildContext context,
            ConnectivityResult connectivity,
            Widget child,
            ) {
          final bool connected = connectivity != ConnectivityResult.none;
          if (connected) {
            return const ZonesScreen(); //SplashScreen();
          } else {
            return const OfflineWidget();
          }
        },
          child: Center(child: CircularProgressIndicator(color: HexColor('#ECB365'))),
        ),
      ),
    );
  }
}