import 'package:flutter/material.dart';

void showCustomSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message,textAlign: TextAlign.center,),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(top: 30.0, left: 10.0, right: 10.0,bottom: 20),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }