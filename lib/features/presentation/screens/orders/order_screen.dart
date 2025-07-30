import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w2d_customer_mobile/core/extension/widget_ext.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/orders/get_orders_list_usecase.dart';
import 'package:w2d_customer_mobile/features/presentation/cubit/orders/orders_cubit.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int page = 1;
  int pageSize = 10;

  @override
  void initState() {
    _callGetOrdersApi(page: page, pageSize: pageSize);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrdersCubit, OrdersState>(
      listener: (context, state) {
        if (state is GetOrdersLoaded) {
          widget.showErrorToast(context: context, message: "Orderes Laded");
        } else if (state is GetOrdersError) {
          widget.showErrorToast(context: context, message: state.error);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text('Orders'), centerTitle: true),
          body: Center(child: Text('Order Page')),
        );
      },
    );
  }

  void _callGetOrdersApi({required int page, required int pageSize}) {
    context.read<OrdersCubit>().getOrderList(
      GetOrdersListParams(page: page, pageSize: pageSize),
    );
  }
}
