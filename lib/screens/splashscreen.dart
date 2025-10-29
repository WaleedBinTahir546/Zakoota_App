import 'package:flutter/material.dart';
import 'introscreen1.dart'; // 👈 Next screen

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // 🔹 Delay 3 seconds then move to IntroScreen1
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const IntroScreen1()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 114, 18, 18),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 🔹 App Logo (Add your image in assets folder)
            Image.asset(
              'assets/intro.png', // <-- Apni image ka path lagao
              width: size.width * 0.5, // Responsive size
            ),
            const SizedBox(height: 20),

            // 🔹 App Name
            const Text(
              'Zakoota Lawyer App',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 1, 1, 1),
              ),
            ),

            const SizedBox(height: 10),

            // 🔹 Tagline (optional)
            const Text(
              'Your Legal Partner Anytime',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 1, 1, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
