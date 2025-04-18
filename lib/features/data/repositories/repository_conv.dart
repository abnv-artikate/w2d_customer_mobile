import 'package:w2d_customer_mobile/core/utils/decode_jwt.dart';
import 'package:w2d_customer_mobile/features/data/model/auth/verify_otp_model.dart';
import 'package:w2d_customer_mobile/features/domain/entities/user_entity.dart';

class RepositoryConv {
  static UserEntity convertVerifyOtpModelToUserEntity(VerifyOtpModel model) {
    Map<String, dynamic> parsedJson = DecodeJWT().parseJwt(model.data!.access!);
    return UserEntity(email: parsedJson['email']);
  }
}
