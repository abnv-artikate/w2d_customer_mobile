import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w2d_customer_mobile/features/domain/entities/orders/orders_list_entity.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/orders/get_orders_by_id_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/orders/get_orders_list_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/orders/order_success_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/orders/pending_order_usecase.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit({
    required this.orderPendingUseCase,
    required this.orderSuccessUseCase,
    required this.getOrdersListUseCase,
    required this.getOrdersByIdUseCase,
  }) : super(OrdersInitial());

  final OrderPendingUseCase orderPendingUseCase;
  final OrderSuccessUseCase orderSuccessUseCase;
  final GetOrdersListUseCase getOrdersListUseCase;
  final GetOrdersByIdUseCase getOrdersByIdUseCase;

  pendingOrder({
    required OrderPendingParams params,
    required String startUrl,
    required String transactionCode,
  }) async {
    emit(OrderPendingLoading());
    final result = await orderPendingUseCase.call(params);

    result.fold(
      (l) => emit(OrderPendingError(error: l.message)),

      (r) => emit(
        OrderPendingLoaded(
          startUrl: startUrl,
          transactionCode: transactionCode,
        ),
      ),
    );
  }

  orderSuccess(OrderSuccessParams params) async {
    emit(OrderSuccessLoading());
    final result = await orderSuccessUseCase.call(params);

    result.fold(
      (l) {
        emit(OrderSuccessError(error: l.message));
      },
      (r) {
        emit(OrderSuccessLoaded());
      },
    );
  }

  getOrderList(GetOrdersListParams params) async {
    emit(GetOrdersLoading());
    final result = await getOrdersListUseCase.call(params);

    result.fold(
      (l) {
        emit(GetOrdersError(error: l.message));
      },
      (r) {
        emit(GetOrdersLoaded(orderList: r));
      },
    );
  }
}
