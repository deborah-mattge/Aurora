import 'package:flutter/material.dart';

void showConfirmationSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 5), 
      backgroundColor: const Color.fromRGBO(81, 185, 214, 1), 
      behavior: SnackBarBehavior.floating, 
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24), 
    ),
  );
}

void showErrorSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 5), 
      backgroundColor: Colors.pink, 
      behavior: SnackBarBehavior.floating, 
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24), 
    ),
  );
}