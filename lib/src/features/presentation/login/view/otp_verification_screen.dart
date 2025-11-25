import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haritashr/src/core/utils/shared_preference/app_shared_preference.dart';
import 'package:haritashr/src/core/utils/utils/coman_snack_bar.dart';
import 'package:haritashr/src/features/domain/entities/login/request/verify_otp_request.dart';
import 'package:haritashr/src/features/domain/entities/login/response/login_response.dart';
import 'package:haritashr/src/features/presentation/login/logic/verify_otp/verify_otp_bloc.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    for (var f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as LoginResponse;

    return BlocConsumer<VerifyOtpBloc, VerifyOtpState>(
      listener: (context, state) {
        if (state is ErrorVerifyOtp) {
          CommonSnackBar(msg: state.msg, context: context).call();
        } else if (state is VerifyOtpResponse) {
          CommonSnackBar(msg: "Login Success", context: context).call();
          AppSharedPreference.instance?.setIsUserLogin(true);
          AppSharedPreference.instance?.setAccessToken(
            state.user.authorizedkeys ?? "",
          );
          AppSharedPreference.instance?.setUserName(state.user.name ?? "");
          AppSharedPreference.instance?.setUserId(args.userId ?? "");
          Navigator.pushReplacementNamed(context, '/dashboard');
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.grey[50],
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Icon or illustration
                  Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.sms_outlined,
                      color: Colors.redAccent,
                      size: 45,
                    ),
                  ),

                  const SizedBox(height: 20),
                  const Text(
                    "OTP Verification",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Enter the 6-digit code sent to your phone",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 40),

                  // OTP input fields
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(6, (index) {
                      return SizedBox(
                        height: 45,
                        width: 40,
                        child: TextField(
                          controller: _controllers[index],
                          focusNode: _focusNodes[index],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          maxLength: 1,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: InputDecoration(
                            counterText: "",
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.redAccent,
                                width: 2,
                              ),
                            ),
                          ),
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty && index < 5) {
                              _focusNodes[index + 1].requestFocus();
                            }
                            if (value.isEmpty && index > 0) {
                              _focusNodes[index - 1].requestFocus();
                            }
                          },
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 40),

                  // Verify Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: state is VerifyOtpLoading
                          ? null
                          : () {
                              context.read<VerifyOtpBloc>().add(
                                VerifyOtpRequestEvent(
                                  otpRequest: VerifyOtpRequestModel(
                                    userId: args.userId ?? "",
                                    otp: _controllers.map((c) => c.text).join(),
                                    loginToken: args.authorizedkeys ?? "",
                                  ),
                                ),
                              );
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: state is VerifyOtpLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              "VERIFY OTP",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Resend option
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Didn't receive OTP? ",
                        style: TextStyle(color: Colors.black54),
                      ),
                      TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("OTP Resent")),
                          );
                        },
                        child: const Text(
                          "Resend",
                          style: TextStyle(
                            color: Colors.redAccent,
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
      },
    );
  }
}
