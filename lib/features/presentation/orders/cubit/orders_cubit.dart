import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/orders/create_order_usecase.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit({required this.createOrderUseCase}) : super(OrdersInitial());

  final CreateOrderUseCase createOrderUseCase;

  createOrder(CreateOrderParams params) async {
    emit(CreateOrderLoading());
    final result = await createOrderUseCase.call(params);

    result.fold(
      (l) => emit(CreateOrderError()),

      (r) => emit(CreateOrderLoaded()),
    );
  }
}
