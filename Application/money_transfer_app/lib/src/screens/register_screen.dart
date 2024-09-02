// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:money_transfer_app/src/models/user_registration_model.dart';
import 'package:money_transfer_app/src/services/auth_service.dart';
import 'package:money_transfer_app/src/widgets/input_field.dart';
import 'package:money_transfer_app/src/widgets/header.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isHide = true;

  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final addressController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthService authService = AuthService();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Header(
            title: 'Money Transfer',
            subtitle: 'Register your information to connect',
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
              ),
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        InputField(
                          controller: nameController,
                          hintText: 'Name',
                          validator: (value) =>
                              value == null || value.isEmpty
                                  ? 'Please enter your name'
                                  : null,
                        ),
                        const SizedBox(height: 20),
                        InputField(
                          controller: emailController,
                          hintText: 'Email',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                .hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        InputField(
                          controller: phoneNumberController,
                          hintText: 'Phone Number',
                          validator: (value) =>
                              value == null || value.isEmpty
                                  ? 'Please enter your phone Number'
                                  : null,
                        ),
                        const SizedBox(height: 20),
                        InputField(
                          controller: addressController,
                          hintText: 'Address',
                          validator: (value) =>
                              value == null || value.isEmpty
                                  ? 'Please enter your address'
                                  : null,
                        ),
                        const SizedBox(height: 20),
                        InputField(
                          controller: passwordController,
                          hintText: 'Password',
                          obscureText: isHide,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                isHide = !isHide;
                              });
                            },
                            child: Icon(
                              isHide
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            } else if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        final user = UserRegistrationModel(
                          name: nameController.text,
                          email: emailController.text,
                          phoneNumber: phoneNumberController.text,
                          address: addressController.text,
                          password: passwordController.text,
                        );

                        await authService.registerUser(user);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Register successful')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(15),
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text(
                      'Sign up',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already Have an account? "),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/login'),
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.indigo,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
