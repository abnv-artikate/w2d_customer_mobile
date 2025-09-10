import 'package:w2d_customer_mobile/features/domain/entities/telr_payment/payment_request_entity.dart';
import 'package:xml/xml.dart' as xml;

class TelrPaymentRequestModel {
  static String toXml(PaymentRequestEntity req) {
    final builder = xml.XmlBuilder();
    builder.processing('xml', 'version="1.0" encoding="UTF-8"');
    builder.element(
      'mobile',
      nest: () {
        builder.element(
          'store',
          nest: () {
            builder.text(req.storeId);
          },
        );
        builder.element(
          'key',
          nest: () {
            builder.text(req.authKey);
          },
        );

        builder.element(
          'device',
          nest: () {
            builder.element(
              'type',
              nest: () {
                builder.text('iAndroid');
              },
            );
            builder.element(
              'id',
              nest: () {
                builder.text('36C0EC49-AA2F-47DC-A4D7-D9927A739F5F');
              },
            );
          },
        );

        // app
        builder.element(
          'app',
          nest: () {
            builder.element(
              'name',
              nest: () {
                builder.text('Telr');
              },
            );
            builder.element(
              'version',
              nest: () {
                builder.text('1.1.6');
              },
            );
            builder.element(
              'user',
              nest: () {
                builder.text('2');
              },
            );
            builder.element(
              'id',
              nest: () {
                builder.text('1237546345');
              },
            );
          },
        );

        //tran
        builder.element(
          'tran',
          nest: () {
            builder.element(
              'test',
              nest: () {
                builder.text('0');
              },
            );
            builder.element(
              'type',
              nest: () {
                builder.text('auth');
              },
            );
            builder.element(
              'class',
              nest: () {
                builder.text('paypage');
              },
            );
            builder.element('cartid', nest: req.cartId);
            builder.element(
              'description',
              nest: () {
                builder.text('Test for Mobile API order');
              },
            );
            builder.element('currency', nest: req.currency);
            builder.element('amount', nest: req.amount);
            builder.element(
              'language',
              nest: () {
                builder.text('en');
              },
            );
            builder.element(
              'firstref',
              nest: () {
                builder.text('first');
              },
            );
            builder.element(
              'ref',
              nest: () {
                builder.text('null');
              },
            );
          },
        );

        //billing
        builder.element(
          'billing',
          nest: () {
            // name
            builder.element(
              'name',
              nest: () {
                builder.element(
                  'title',
                  nest: () {
                    builder.text('');
                  },
                );
                builder.element('first', nest: req.firstName);
                builder.element('last', nest: req.lastName);
              },
            );
            // address
            builder.element(
              'address',
              nest: () {
                builder.element('line1', nest: req.street);
                builder.element('city', nest: req.city);
                builder.element(
                  'region',
                  nest: () {
                    builder.text('');
                  },
                );
                builder.element('country', nest: req.country);
              },
            );

            builder.element('phone', nest: req.phone);
            builder.element('email', nest: req.email);
          },
        );
      },
    );

    return builder.buildDocument().toXmlString(pretty: true);
  }
}
