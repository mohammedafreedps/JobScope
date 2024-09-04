import 'package:flutter/material.dart';

class SnackbarHelper {
  final BuildContext context;

  SnackbarHelper({required this.context});

  void showSnackbar({required String message, Duration duration = const Duration(seconds: 3)}) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: duration,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
