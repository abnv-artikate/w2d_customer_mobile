import 'package:xml/xml.dart' as xml;

class TelrPaymentResponseModel {
  final String startUrl;
  final String closeUrl;
  final String abortUrl;
  final String code;

  TelrPaymentResponseModel({
    required this.startUrl,
    required this.closeUrl,
    required this.abortUrl,
    required this.code,
  });

  factory TelrPaymentResponseModel.fromXml(String xmlString) {
    final document = xml.XmlDocument.parse(xmlString);
    final webview = document.findAllElements('webview').first;

    return TelrPaymentResponseModel(
      startUrl: webview.findElements('start').first.innerText,
      closeUrl: webview.findElements('close').first.innerText,
      abortUrl: webview.findElements('abort').first.innerText,
      code: webview.findElements('code').first.innerText,
    );
  }
}
