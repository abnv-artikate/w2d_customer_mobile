import 'package:w2d_customer_mobile/features/data/model/telr_payment/telr_confirm_payment_response_model.dart';

class ConfirmPaymentResponseEntity {
  final String status;
  final String code;
  final String message;
  final String tranRef;
  final String cvv;
  final String avs;
  final String cardCode;
  final String cardLast4;
  final String cardTypeCode;
  final String cardTypeLast4;
  final String cardCountry;
  final String cardFirst6;
  final String cardExpiryMonth;
  final String cardExpiryYear;
  final String caValid;
  final String trace;

  ConfirmPaymentResponseEntity({
    required this.status,
    required this.code,
    required this.message,
    required this.tranRef,
    required this.cvv,
    required this.avs,
    required this.cardCode,
    required this.cardLast4,
    required this.cardTypeCode,
    required this.cardTypeLast4,
    required this.cardCountry,
    required this.cardFirst6,
    required this.cardExpiryMonth,
    required this.cardExpiryYear,
    required this.caValid,
    required this.trace,
  });

  factory ConfirmPaymentResponseEntity.fromModel(TelrConfirmPaymentResponseModel model) {
    return ConfirmPaymentResponseEntity(
      status: model.auth.status,
      code: model.auth.code,
      message: model.auth.message,
      tranRef: model.auth.tranRef,
      cvv: model.auth.cvv,
      avs: model.auth.avs,
      cardCode: model.auth.cardCode,
      cardLast4: model.auth.cardLast4,
      cardTypeCode: model.auth.card.code,
      cardTypeLast4: model.auth.card.last4,
      cardCountry: model.auth.card.country,
      cardFirst6: model.auth.card.first6,
      cardExpiryMonth: model.auth.card.expiry.month,
      cardExpiryYear: model.auth.card.expiry.year,
      caValid: model.auth.caValid,
      trace: model.trace,
    );
  }
}

// class TelrPaymentResponseEntity {
//   final String status;
//   final String code;
//   final String message;
//   final String tranref;
//   final String cvv;
//   final String avs;
//   final String cardCode;
//   final String cardLast4;
//   final String cardTypeCode;
//   final String cardTypeLast4;
//   final String cardCountry;
//   final String cardFirst6;
//   final String cardExpiryMonth;
//   final String cardExpiryYear;
//   final String caValid;
//   final String trace;
//
//   TelrPaymentResponseEntity({
//     required this.status,
//     required this.code,
//     required this.message,
//     required this.tranref,
//     required this.cvv,
//     required this.avs,
//     required this.cardCode,
//     required this.cardLast4,
//     required this.cardTypeCode,
//     required this.cardTypeLast4,
//     required this.cardCountry,
//     required this.cardFirst6,
//     required this.cardExpiryMonth,
//     required this.cardExpiryYear,
//     required this.caValid,
//     required this.trace,
//   });
//
//   factory TelrPaymentResponseEntity.fromModel(TelrPaymentResponse model) {
//     return TelrPaymentResponseEntity(
//       status: model.auth.status,
//       code: model.auth.code,
//       message: model.auth.message,
//       tranref: model.auth.tranref,
//       cvv: model.auth.cvv,
//       avs: model.auth.avs,
//       cardCode: model.auth.cardCode,
//       cardLast4: model.auth.cardLast4,
//       cardTypeCode: model.auth.card.code,
//       cardTypeLast4: model.auth.card.last4,
//       cardCountry: model.auth.card.country,
//       cardFirst6: model.auth.card.first6,
//       cardExpiryMonth: model.auth.card.expiry.month,
//       cardExpiryYear: model.auth.card.expiry.year,
//       caValid: model.auth.caValid,
//       trace: model.trace,
//     );
//   }
//
//   Map<String, dynamic> toMap() {
//     return {
//       'status': status,
//       'code': code,
//       'message': message,
//       'tranref': tranref,
//       'cvv': cvv,
//       'avs': avs,
//       'cardCode': cardCode,
//       'cardLast4': cardLast4,
//       'cardTypeCode': cardTypeCode,
//       'cardTypeLast4': cardTypeLast4,
//       'cardCountry': cardCountry,
//       'cardFirst6': cardFirst6,
//       'cardExpiryMonth': cardExpiryMonth,
//       'cardExpiryYear': cardExpiryYear,
//       'caValid': caValid,
//       'trace': trace,
//     };
//   }
//
//   factory TelrPaymentResponseEntity.fromMap(Map<String, dynamic> map) {
//     return TelrPaymentResponseEntity(
//       status: map['status'],
//       code: map['code'],
//       message: map['message'],
//       tranref: map['tranref'],
//       cvv: map['cvv'],
//       avs: map['avs'],
//       cardCode: map['cardCode'],
//       cardLast4: map['cardLast4'],
//       cardTypeCode: map['cardTypeCode'],
//       cardTypeLast4: map['cardTypeLast4'],
//       cardCountry: map['cardCountry'],
//       cardFirst6: map['cardFirst6'],
//       cardExpiryMonth: map['cardExpiryMonth'],
//       cardExpiryYear: map['cardExpiryYear'],
//       caValid: map['caValid'],
//       trace: map['trace'],
//     );
//   }
// }
