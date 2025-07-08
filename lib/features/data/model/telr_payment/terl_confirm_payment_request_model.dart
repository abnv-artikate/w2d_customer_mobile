import 'package:xml/xml.dart' as xml;

class TelrConfirmPaymentRequestModel {
  static String toXml(String transCode) {
    final builder = xml.XmlBuilder();
    builder.processing('xml', 'version="1.0" encoding="UTF-8"');
    builder.element(
      'mobile',
      nest: () {
        builder.element('store', nest: '32266');
        builder.element('key', nest: '6xJfn#6r7N-xmNfL');

        builder.element('complete', nest: transCode);
      },
    );

    return builder.buildDocument().toXmlString(pretty: true);
  }
}

// <?xml version="1.0" encoding="UTF-8"?>
// <mobile>
//   <store>Store ID</store>
//   <key>Authentication Key</key>
//   <complete>Transaction code obtained in the WebView response</complete>
// </mobile>
