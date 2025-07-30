import 'package:dartz/dartz.dart';
import 'package:w2d_customer_mobile/core/error/failure.dart';
import 'package:w2d_customer_mobile/core/usecase/usecase.dart';
import 'package:w2d_customer_mobile/features/domain/repositories/repository.dart';

class UpdateOrderByIdUseCase extends UseCase<String, UpdateOrderParams> {
  final Repository _repository;

  UpdateOrderByIdUseCase(this._repository);

  @override
  Future<Either<Failure, String>> call(UpdateOrderParams params) async {
    return await _repository.updateOrder(params);
  }
}

class UpdateOrderParams {
  final String id;

  UpdateOrderParams({required this.id});

  Map<String, dynamic> toJson() {
    return {
      "readable_id": "string",
      "seller": {"business_name": "string"},
      "customer": {
        "email": "user@example.com",
        "full_name": "string",
        "mobile_number": "string",
        "secondary_mobile_number": "string",
        "country": "string",
      },
      "customer_email": "user@example.com",
      "status": "draft",
      "charge_status": "none",
      "shipping_address": {
        "address_type": "home",
        "full_name": "string",
        "primary_phone_number": "string",
        "secondary_phone_number": "string",
        "address_line_1": "string",
        "address_line_2": "string",
        "city": "string",
        "state_province": "string",
        "postal_code": "string",
        "country": "string",
        "is_default": true,
      },
      "shipping_tax_rate": "string",
      "shipping_tax_class": 0,
      "shipping_tax_class_name": "string",
      "currency": "string",
      "shipping_price_net_amount": "string",
      "subtotal": "string",
      "total": "string",
      "platform_fee": "string",
      "destination_duty": "string",
      "vat": "string",
      "transit_insurance": "string",
      "local_transit_fee": "string",
      "invoice_number": "string",
      "display_gross_prices": true,
      "customer_note": "string",
      "redirect_url": "string",
      "search_document": "string",
      "search_vector": "string",
      "expired_at": "2025-07-29T06:44:21.548Z",
    };
  }
}
