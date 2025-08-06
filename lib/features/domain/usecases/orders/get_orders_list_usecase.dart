import 'package:dartz/dartz.dart';
import 'package:w2d_customer_mobile/core/error/failure.dart';
import 'package:w2d_customer_mobile/core/usecase/usecase.dart';
import 'package:w2d_customer_mobile/features/domain/entities/orders/orders_list_entity.dart';
import 'package:w2d_customer_mobile/features/domain/repositories/repository.dart';

class GetOrdersListUseCase extends UseCase<OrderListEntity, GetOrdersListParams> {
  final Repository _repository;

  GetOrdersListUseCase(this._repository);

  @override
  Future<Either<Failure, OrderListEntity>> call(GetOrdersListParams params) async {
    return await _repository.getOrdersList(params);
  }
}

class GetOrdersListParams {
  final int page;
  final int pageSize;

  GetOrdersListParams({required this.page, required this.pageSize});

  Map<String, dynamic> toJson() {
    return {'page': page, 'page_size': pageSize};
  }
}
