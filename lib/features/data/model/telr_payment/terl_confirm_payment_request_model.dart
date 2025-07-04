import 'package:xml/xml.dart' as xml;

class TelrConfirmPaymentRequestModel {
  static String toXml(String transCode) {
    final builder = xml.XmlBuilder();
    builder.processing('xml', 'version="1.0" encoding="UTF-8"');
    builder.element(
      'mobile',
      nest: () {
        builder.element('store', nest: '19793');
        builder.element('key', nest: 'zd46X-jKCwC@bTp3');

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
