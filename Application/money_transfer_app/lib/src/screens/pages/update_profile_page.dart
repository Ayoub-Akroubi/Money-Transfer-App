// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:money_transfer_app/src/providers/userProvider.dart';
import 'package:money_transfer_app/src/services/user_service.dart';
import 'package:money_transfer_app/src/widgets/input_field.dart';
import 'package:provider/provider.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final addressController = TextEditingController();
  UserService userService = UserService();


  @override
  void dispose() {
    nameController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 80),
                const Text(
                  'Update your profile',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 50),
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
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              final name = nameController.text;
                              final phoneNumber = phoneNumberController.text;
                              final address = addressController.text;
                              final result = await userService.updateProfile(
                                  name: name,
                                  phoneNumber: phoneNumber,
                                  address: address,
                                  token: user!.token,
                                );
                                if (result['success']) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(result['message'])),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(result['message'])),
                                  );
                                }
                              
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(15),
                            backgroundColor: Colors.blueAccent,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text(
                            'Update profile',
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                      ),
                    ],
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