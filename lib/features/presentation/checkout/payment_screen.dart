import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentScreen extends StatelessWidget {
  final String url;

  PaymentScreen({super.key, required this.url});

  final WebViewController _controller =
      WebViewController()..setJavaScriptMode(JavaScriptMode.unrestricted);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebViewWidget(
          controller:
              _controller
                ..loadRequest(
                  Uri.parse(url),
                  method: LoadRequestMethod.post,
                ),
        ),
      ),
    );
  }
}
