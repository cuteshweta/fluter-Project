import 'package:flutter/material.dart';

class CommonSnackBar {
  final String? msg;
  final BuildContext context;

  CommonSnackBar({required this.msg, required this.context});

  void call() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(msg ?? "")));
  }
}
