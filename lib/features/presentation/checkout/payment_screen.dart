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
      appBar: AppBar(title: Text('Payment Screen')),
      body: WebViewWidget(
        controller:
            _controller
              ..loadRequest(Uri.parse(url), method: LoadRequestMethod.post)
              ..setNavigationDelegate(
                NavigationDelegate(
                  onPageStarted: (String url) {
                    debugPrint('Started loading: $url');
                  },
                  onPageFinished: (String url) {
                    debugPrint('Finished loading: $url');
                    if (url.contains('https://secure.telr.com/gateway/webview_close.html')) {
                      Navigator.of(context).pop();
                    }
                  },

                  // onNavigationRequest: (NavigationRequest request) {
                  //   // optional: intercept navigation before loading
                  //   if (request.url.contains('YOUR_TARGET_URL')) {
                  //     Navigator.of(context).pop();
                  //     return NavigationDecision.prevent;
                  //   }
                  //   return NavigationDecision.navigate;
                  // },
                  onWebResourceError: (WebResourceError error) {
                    debugPrint('WebView error: ${error.description}');
                  },
                ),
              ),
      ),
    );
  }
}
