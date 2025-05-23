import 'package:flutter/cupertino.dart';
import 'package:score/view/overlay/toast.dart';

import 'alert.dart';

class OverlayExample {
  late BuildContext context;

  void showAlert() async {
    OverlayEntry _overlay = OverlayEntry(builder: (_) => const Alert());

    Navigator.of(context).overlay!.insert(_overlay);

    await Future.delayed(const Duration(seconds: 1));
    _overlay.remove();
  }

  void toast() async {
    OverlayEntry _overlay = OverlayEntry(builder: (_) => const Toast());

    Navigator.of(context).overlay!.insert(_overlay);

    await Future.delayed(const Duration(seconds: 2));
    _overlay.remove();
  }
}