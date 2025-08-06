import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:w2d_customer_mobile/core/extension/widget_ext.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';
import 'package:w2d_customer_mobile/features/domain/entities/orders/orders_list_entity.dart';
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

  List<OrderListDataEntity> orderList = [];

  @override
  void initState() {
    _callGetOrdersApi(page: page, pageSize: pageSize);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Orders'), centerTitle: true),
      body: BlocConsumer<OrdersCubit, OrdersState>(
        listener: (context, state) {
          if (state is GetOrdersLoaded) {
            orderList = state.orderList.data;
          } else if (state is GetOrdersError) {
            widget.showErrorToast(context: context, message: state.error);
          }
        },
        builder: (context, state) {
          return state is GetOrdersLoading
              ? Center(
                child: CircularProgressIndicator(color: AppColors.worldGreen),
              )
              : SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return _buildOrderListItem(
                          orderList[index].items.first,
                        );
                      },
                      itemCount: orderList.length,
                    ),
                    SizedBox(height: 50),
                  ],
                ),
              );
        },
      ),
    );
  }

  void _callGetOrdersApi({required int page, required int pageSize}) {
    context.read<OrdersCubit>().getOrderList(
      GetOrdersListParams(page: page, pageSize: pageSize),
    );
  }

  Widget _buildOrderListItem(OrderListDataItemEntity orderItem) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(color: AppColors.deepBlue, blurStyle: BlurStyle.outer, blurRadius: 0.8, spreadRadius: 1),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
            decoration: BoxDecoration(
              color: AppColors.doorOchre.withValues(alpha: 0.1),
              border: Border.all(color: AppColors.doorOchre, width: 2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                Icon(LucideIcons.package, color: AppColors.doorOchre),
                SizedBox(width: 5),
                Text("This Item is part of order #${orderItem.readableId}"),
              ],
            ),
          ),
          SizedBox(height: 5),
          Text(
            orderItem.productName,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
          SizedBox(height: 5),
          Text("Quantity: ${orderItem.quantity}"),
        ],
      ),
    );
  }
}
