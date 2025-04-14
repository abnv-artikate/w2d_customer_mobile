import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

extension WidgetFunction on Widget {
  Future<void> showErrorToast({
    required final BuildContext context,
    required final String message,
  }) async {
    log(message, name: "testerrTe");
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      fontSize: 16.0,
    );
  }
}
