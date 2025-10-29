import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'homescreen.dart'; // Signup ke baad home pe redirect
import 'show_snackbar.dart'; // Helper file for messages

class SignupScreen extends StatefulWidget {
  final String userType;

  const SignupScreen({super.key, required this.userType});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  bool agreeToTerms = false;
  bool _obscurePassword = true;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController cnicController = TextEditingController();

  Future<void> _register() async {
    if (!agreeToTerms) {
      showSnackBar(context, "Please agree to the terms before registering.",
          Colors.redAccent);
      return;
    }

    if (!_formKey.currentState!.validate()) return;

    try {
      // 🔹 Create user in Firebase Auth
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // 🔹 Save extra data in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'firstName': firstNameController.text.trim(),
        'lastName': lastNameController.text.trim(),
        'email': emailController.text.trim(),
        'userType': widget.userType,
        'phone': phoneController.text.trim(),
        'address': addressController.text.trim(),
        'experience': experienceController.text.trim(),
        'cnic': cnicController.text.trim(),
        'createdAt': DateTime.now(),
      });

      showSnackBar(
          context,
          "Signup successful as ${widget.userType.toUpperCase()}!",
          Colors.green);

      // 🔹 Navigate to HomePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message ?? "Signup failed!", Colors.redAccent);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLawyer = widget.userType.toLowerCase() == 'lawyer';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset('assets/intro4.png', height: 200),
                const SizedBox(height: 10),

                Text(
                  "Sign up as ${widget.userType.toUpperCase()}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Create your account",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF600000),
                  ),
                ),
                const SizedBox(height: 25),

                // 🧠 First/Last Name
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: firstNameController,
                        decoration: const InputDecoration(
                          labelText: "First Name",
                          border: OutlineInputBorder(),
                        ),
                        validator: (v) =>
                            v!.isEmpty ? "Enter first name" : null,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: lastNameController,
                        decoration: const InputDecoration(
                          labelText: "Last Name",
                          border: OutlineInputBorder(),
                        ),
                        validator: (v) => v!.isEmpty ? "Enter last name" : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) => v!.isEmpty ? "Enter email" : null,
                ),
                const SizedBox(height: 10),

                TextFormField(
                  controller: passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                  validator: (v) =>
                      v!.length < 6 ? "At least 6 characters" : null,
                ),
                const SizedBox(height: 10),

                if (isLawyer) ...[
                  TextFormField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                      labelText: "Phone Number",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: addressController,
                    decoration: const InputDecoration(
                      labelText: "Address",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: experienceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Years of Experience",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: cnicController,
                    decoration: const InputDecoration(
                      labelText: "CNIC",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],

                Row(
                  children: [
                    Checkbox(
                      value: agreeToTerms,
                      onChanged: (val) => setState(() => agreeToTerms = val!),
                    ),
                    const Expanded(
                      child: Text(
                        "I agree to the ZAKOOTA User Agreement and Privacy Policy.",
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                ElevatedButton(
                  onPressed: _register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF600000),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: Text(
                    "Join as ${widget.userType.toUpperCase()}",
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
