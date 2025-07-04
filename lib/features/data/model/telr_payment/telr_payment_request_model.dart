import 'package:w2d_customer_mobile/features/domain/entities/telr_payment/payment_request_entity.dart';
import 'package:xml/xml.dart' as xml;

class TelrPaymentRequestModel {
  // static String toXml(PaymentRequestEntity req) {
  //   final builder = xml.XmlBuilder();
  //   builder.processing('xml', 'version="1.0" encoding="UTF-8"');
  //   builder.element('mobile', nest: () {
  //     builder.element('store', nest: '19793');
  //     builder.element('key', nest: 'zd46X-jKCwC@bTp3');
  //
  //     builder.element('device', nest: () {
  //       builder.element('type', nest: '');
  //       builder.element('id', nest: '');
  //       builder.element('agent', nest: '');
  //       builder.element('accept', nest: '');
  //     });
  //
  //     builder.element('app', nest: () {
  //       builder.element('name', nest: 'World2Door_mobile');
  //       builder.element('version', nest: '1.0');
  //       builder.element('user', nest: req.email);
  //       builder.element('id', nest: '');
  //     });
  //
  //     builder.element('tran', nest: () {
  //       builder.element('test', nest: '1');
  //       builder.element('type', nest: 'paypage');
  //       builder.element('class', nest: 'ecom');
  //       builder.element('cartid', nest: req.cartId);
  //       builder.element('description', nest: 'Test transaction');
  //       builder.element('currency', nest: req.currency);
  //       builder.element('amount', nest: req.amount);
  //       builder.element('ref', nest: '');
  //     });
  //
  //     builder.element('billing', nest: () {
  //       builder.element('name', nest: () {
  //         builder.element('first', nest: req.firstName);
  //         builder.element('last', nest: req.lastName);
  //       });
  //       builder.element('address', nest: () {
  //         builder.element('line1', nest: req.street);
  //         builder.element('city', nest: req.city);
  //         builder.element('region', nest: req.region);
  //         builder.element('country', nest: req.country);
  //         builder.element('zip', nest: req.zip);
  //       });
  //       builder.element('phone', nest: req.phone);
  //       builder.element('email', nest: req.email);
  //     });
  //   });
  //
  //   return builder.buildDocument().toXmlString(pretty: true);
  // }

  static String toXml(PaymentRequestEntity req) {
    final builder = xml.XmlBuilder();
    builder.processing('xml', 'version="1.0" encoding="UTF-8"');
    builder.element(
      'mobile',
      nest: () {
        builder.element(
          'store',
          nest: () {
            builder.text('19793');
          },
        );
        builder.element(
          'key',
          nest: () {
            builder.text('zd46X-jKCwC@bTp3');
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
                builder.text('1');
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

// <?xml version="1.0" encoding="UTF-8"?>
// <mobile>
// <store>19793</store>
// <key>zd46X-jKCwC@bTp3</key>
// <device>
// <type>Android</type>
// <id>36C0EC49-AA2F-47DC-A4D7-D9927A739F5F</id>
// </device>
// <app>
// <name>TelrSDK</name>
// <version>0.0.1</version>
// <user>123456</user>
// <id>1234567892</id>
// </app>
// <tran>
// <test>1</test>
// <type>paypage</type>
// <class>ecom</class>
// <cartid>1575918720222330</cartid>
// <description>Test Mobile API</description>
// <currency>AED</currency>
// <amount>10</amount>
// <ref>1234</ref>
// </tran>
// <billing>
// <name>
// <title>MRs</title>
// <first>John</first>
// <last>Smith</last>
// </name>
// <address>
// <line1>SIT TOWER</line1>
// <city>Dubai</city>
// <region>Dubai</region>
// <country>AE</country>
// </address>
// <email>stackfortytwo@gmail.com</email>
// </billing>
// </mobile>

// String _parseIntoXml() {
//   final builder = XmlBuilder();
//   builder.processing('xml', 'version="1.0"');
//   builder.element(
//     'mobile', nest: () {
//       builder.element(
//         'store', nest: () {
//           builder.text('19793');
//         },
//       );
//       builder.element(
//         'key', nest: () {
//           builder.text('zd46X-jKCwC@bTp3');
//         },
//       );
//
//       builder.element(
//         'device', nest: () {
//           builder.element(
//             'type', nest: () {
//               builder.text('iAndroid');
//             },
//           );
//           builder.element(
//             'id',
//             nest: () {
//               builder.text('36C0EC49-AA2F-47DC-A4D7-D9927A739F5F');
//             },
//           );
//         },
//       );
//
//       // app
//       builder.element(
//         'app',
//         nest: () {
//           builder.element(
//             'name',
//             nest: () {
//               builder.text('Telr');
//             },
//           );
//           builder.element(
//             'version',
//             nest: () {
//               builder.text('1.1.6');
//             },
//           );
//           builder.element(
//             'user',
//             nest: () {
//               builder.text('2');
//             },
//           );
//           builder.element(
//             'id',
//             nest: () {
//               builder.text('1237546345');
//             },
//           );
//         },
//       );
//
//       //tran
//       builder.element(
//         'tran',
//         nest: () {
//           builder.element(
//             'test',
//             nest: () {
//               builder.text('1');
//             },
//           );
//           builder.element(
//             'type',
//             nest: () {
//               builder.text('auth');
//             },
//           );
//           builder.element(
//             'class',
//             nest: () {
//               builder.text('paypage');
//             },
//           );
//           builder.element(
//             'cartid',
//             nest: () {
//               builder.text(100000000 + Random().nextInt(999999999));
//             },
//           );
//           builder.element(
//             'description',
//             nest: () {
//               builder.text('Test for Mobile API order');
//             },
//           );
//           builder.element(
//             'currency',
//             nest: () {
//               builder.text('AED');
//             },
//           );
//           builder.element(
//             'amount',
//             nest: () {
//               builder.text('1');
//             },
//           );
//           builder.element(
//             'language',
//             nest: () {
//               builder.text('en');
//             },
//           );
//           builder.element(
//             'firstref',
//             nest: () {
//               builder.text('first');
//             },
//           );
//           builder.element(
//             'ref',
//             nest: () {
//               builder.text('null');
//             },
//           );
//         },
//       );
//
//       //billing
//       builder.element(
//         'billing',
//         nest: () {
//           // name
//           builder.element(
//             'name',
//             nest: () {
//               builder.element(
//                 'title',
//                 nest: () {
//                   builder.text('');
//                 },
//               );
//               builder.element(
//                 'first',
//                 nest: () {
//                   builder.text('Div');
//                 },
//               );
//               builder.element(
//                 'last',
//                 nest: () {
//                   builder.text('V');
//                 },
//               );
//             },
//           );
//           // address
//           builder.element(
//             'address',
//             nest: () {
//               builder.element(
//                 'line1',
//                 nest: () {
//                   builder.text('Dubai');
//                 },
//               );
//               builder.element(
//                 'city',
//                 nest: () {
//                   builder.text('Dubai');
//                 },
//               );
//               builder.element(
//                 'region',
//                 nest: () {
//                   builder.text('');
//                 },
//               );
//               builder.element(
//                 'country',
//                 nest: () {
//                   builder.text('AE');
//                 },
//               );
//             },
//           );
//
//           builder.element(
//             'phone',
//             nest: () {
//               builder.text('551188269');
//             },
//           );
//           builder.element(
//             'email',
//             nest: () {
//               builder.text('test@telr.com');
//             },
//           );
//         },
//       );
//     },
//   );
//
//   final bookshelfXml = builder.buildDocument();
//   return bookshelfXml.toXmlString();
// }
