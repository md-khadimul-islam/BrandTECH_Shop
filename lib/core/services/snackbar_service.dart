import 'package:flutter/material.dart';

class SnackbarService {
  SnackbarService._();

  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static void show(
    String message, {
    Duration duration = const Duration(seconds: 2),
  }) {
    final messenger = messengerKey.currentState;
    if (messenger == null) return;

    messenger.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
