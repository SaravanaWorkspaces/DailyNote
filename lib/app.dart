import 'package:daily_note/locator.dart';
import 'package:daily_note/presentation/home-screen.dart';
import 'package:daily_note/service/speech-service.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(fontFamily: 'Raleway'),
        title: "Daily Notes",
        home: const SplashScreen());
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _launchScreen();
  }

  @override
  Widget build(BuildContext context) {
    getItInstance<SpeechService>();
    return Container(
      color: const Color(0xFF1976D2),
      child: const Center(
        child: Text("Note Daily",
            style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 48,
                color: Colors.white)),
      ),
    );
  }

  _launchScreen() async {
    await Future.delayed(const Duration(milliseconds: 2500), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomeScreen()));
  }
}
