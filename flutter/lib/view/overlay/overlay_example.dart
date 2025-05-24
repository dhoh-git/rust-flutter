import 'package:flutter/cupertino.dart';
import 'toast.dart';
import 'alert.dart';

class OverlayExample {
  late BuildContext context;

  void showAlert() async {
    OverlayEntry overlay = OverlayEntry(builder: (_) => const Alert());
    Navigator.of(context).overlay!.insert(overlay);
    await Future.delayed(const Duration(seconds: 1));
    overlay.remove();
  }

  void toast() async {
    OverlayEntry overlay = OverlayEntry(builder: (_) => const Toast());
    Navigator.of(context).overlay!.insert(overlay);
    await Future.delayed(const Duration(seconds: 5));
    overlay.remove();
  }
}