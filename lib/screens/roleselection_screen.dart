import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../widgets/custombuttons.dart';
import 'signup_screen.dart';
import 'login_screen.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 🔝 Logo aligned to top like LoginScreen
              Image.asset(
                'assets/intro4.png',
                height: 220,
                width: 220,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error, size: 140, color: Colors.white),
              ),
              const SizedBox(height: 20),

              const Text(
                "Select Your Role",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF600000),
                ),
              ),
              const SizedBox(height: 50),

              // 🔹 Client Button
              CustomButton(
                text: "Continue as Client",
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SignupScreen(userType: "Client"),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),

              // 🔹 Lawyer Button
              CustomButton(
                text: "Continue as Lawyer",
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SignupScreen(userType: "Lawyer"),
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),

              // 🔹 Already have an account?
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
