import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haritashr/src/features/domain/entities/login/request/login_request.dart';

import '../logic/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController mobileController = TextEditingController();
  String? _selectedCompany;
  final List<String> _companyList = [
    "Select Company",
    "TechZone Pvt Ltd",
    "MindSoft Solutions",
    "FutureEdge Technologies",
    "BlueSky Innovations",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.loginResponse != null &&
              state.loginResponse?.success == "1") {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text("Login Successful")));
            Navigator.pushReplacementNamed(context, '/dashboard');
          } else if (state.error != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error!)));
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Icon(
                    Icons.lock_outline,
                    size: 80,
                    color: Colors.redAccent,
                  ),
                  const SizedBox(height: 30),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: DropdownButtonFormField<String>(
                      value: _selectedCompany,
                      isExpanded: true,
                      icon: const Icon(Icons.keyboard_arrow_down_rounded),
                      items: _companyList.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value == "Select Company" ? null : value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCompany = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) return "Please select company";
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: mobileController,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    decoration: _inputDecoration("Registered Mobile No."),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your mobile number";
                      } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                        return "Enter a valid 10-digit mobile number";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: state.isLoading
                          ? null
                          : () {
                              if (_formKey.currentState?.validate() ?? false) {
                                context.read<LoginBloc>().add(
                                  LoginRequested(
                                    loginRequest: LoginRequest(
                                      mobileNo: mobileController.text.trim(),
                                      msg: "beforeotp",
                                      imei: "1234567890",
                                      fcmToken: "xyz_token",
                                    ),
                                  ),
                                );
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: state.isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              "LOGIN",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) => InputDecoration(
    hintText: hint,
    counterText: "",
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.redAccent),
    ),
  );
}
