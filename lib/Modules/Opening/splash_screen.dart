
import 'package:flutter/material.dart';

// import 'package:splash_screen_view/SplashScreenView.dart';




class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return const FlutterLogo();
    // SplashScreenView(
    //   navigateRoute: const ZonesScreen(),
    //   speed: 120,
    //   duration: 5300,
    //   imageSize: 130,
    //   imageSrc: 'assets/logo/png-morb3.png',
    //   text: "جميع خدمات المنطقة بين يديك",
    //   textType: TextType.TyperAnimatedText,
    //   textStyle: const TextStyle(fontSize: 30.0,fontFamily: 'HSNIbtisam',height: 1),
    //   backgroundColor: HexColor('#081C31'),
    // );
  }
}
