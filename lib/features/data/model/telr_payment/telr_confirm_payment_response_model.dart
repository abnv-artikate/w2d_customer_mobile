import 'package:xml/xml.dart';

class TelrConfirmPaymentResponseModel {
  final Auth auth;
  final String trace;

  TelrConfirmPaymentResponseModel({required this.auth, required this.trace});

  // factory TelrConfirmPaymentResponseModel.fromXml(String xmlString) {
  //   final document = XmlDocument.parse(xmlString);
  //   final mobileElement = document.getElement('mobile');
  //   final authElement = mobileElement?.getElement('auth');
  //   return TelrConfirmPaymentResponseModel(
  //     auth: Auth.fromXml(authElement!),
  //     trace: document.getElement('trace')?.innerText ?? '',
  //   );
  // }

  factory TelrConfirmPaymentResponseModel.fromXml(String xmlString) {
    final document = XmlDocument.parse(xmlString);
    final root = document.getElement('mobile');
    if (root == null) {
      throw Exception('Invalid XML: <mobile> root not found');
    }

    final authElement = root.getElement('auth');
    final trace = root.getElement('trace')?.innerText ?? '';

    if (authElement == null) {
      throw Exception('Invalid XML: <auth> section not found');
    }

    return TelrConfirmPaymentResponseModel(
      auth: Auth.fromXml(authElement),
      trace: trace,
    );
  }
}

class Auth {
  final String status;
  final String code;
  final String message;
  final String tranRef;
  final String cvv;
  final String avs;
  final String cardCode;
  final String cardLast4;
  final CardDetails card;
  final String caValid;

  Auth({
    required this.status,
    required this.code,
    required this.message,
    required this.tranRef,
    required this.cvv,
    required this.avs,
    required this.cardCode,
    required this.cardLast4,
    required this.card,
    required this.caValid,
  });

  factory Auth.fromXml(XmlElement element) {
    final cardElement = element.getElement('card');
    return Auth(
      status: element.getElement('status')?.innerText ?? '',
      code: element.getElement('code')?.innerText ?? '',
      message: element.getElement('message')?.innerText ?? '',
      tranRef: element.getElement('tranref')?.innerText ?? '',
      cvv: element.getElement('cvv')?.innerText ?? '',
      avs: element.getElement('avs')?.innerText ?? '',
      cardCode: element.getElement('cardcode')?.innerText ?? '',
      cardLast4: element.getElement('cardlast4')?.innerText ?? '',
      card: CardDetails.fromXml(cardElement!),
      caValid: element.getElement('ca_valid')?.innerText ?? '',
    );
  }
}

class CardDetails {
  final String code;
  final String last4;
  final String country;
  final String first6;
  final Expiry expiry;

  CardDetails({
    required this.code,
    required this.last4,
    required this.country,
    required this.first6,
    required this.expiry,
  });

  factory CardDetails.fromXml(XmlElement element) {
    final expiryElement = element.getElement('expiry');
    return CardDetails(
      code: element.getElement('code')?.innerText ?? '',
      last4: element.getElement('last4')?.innerText ?? '',
      country: element.getElement('country')?.innerText ?? '',
      first6: element.getElement('first6')?.innerText ?? '',
      expiry: Expiry.fromXml(expiryElement!),
    );
  }
}

class Expiry {
  final String month;
  final String year;

  Expiry({required this.month, required this.year});

  factory Expiry.fromXml(XmlElement element) {
    return Expiry(
      month: element.getElement('month')?.innerText ?? '',
      year: element.getElement('year')?.innerText ?? '',
    );
  }
}
