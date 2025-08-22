import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:w2d_customer_mobile/core/extension/widget_ext.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';
import 'package:w2d_customer_mobile/features/domain/entities/address/customer_address_entity.dart';
import 'package:w2d_customer_mobile/features/presentation/cubit/address/address_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/screens/checkout/address_bottomsheet.dart';
import 'package:w2d_customer_mobile/injection_container.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  List<CustomerAddressesEntity> addressList = [];

  @override
  void initState() {
    _callGetSavedAddressApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddressCubit, AddressState>(
      listener: (context, state) {
        if (state is GetSavedAddressLoaded) {
          addressList = state.list;
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text("Address"), centerTitle: true),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _addAddressButtonWidget(),
                SizedBox(height: 10),
                _addressList(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _addressList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.black70,
                blurRadius: 2,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    addressList[index].fullName,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Text("Street: ${addressList[index].addressLine1}"),
                  Text("City: ${addressList[index].city}"),
                  Text("Country: ${addressList[index].country}"),
                  Text("Phone No: ${addressList[index].primaryPhoneNumber}"),

                  Text(addressList[index].isDefault.toString()),
                ],
              ),
              Positioned(
                right: 5,
                child: GestureDetector(
                  onTap: () {},
                  child: Icon(LucideIcons.edit2),
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 10);
      },
      itemCount: addressList.length,
    );
  }

  Widget _addAddressButtonWidget() {
    return GestureDetector(
      onTap: () {
        _addNewAddress();
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.worldGreen),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(LucideIcons.plus),
            SizedBox(width: 5),
            Text("Add Address"),
          ],
        ),
      ),
    );
  }

  _addNewAddress() {
    return showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      enableDrag: true,
      useSafeArea: true,
      showDragHandle: true,
      scrollControlDisabledMaxHeightRatio: 1,
      builder: (BuildContext context) {
        return BlocProvider<AddressCubit>(
          create: (context) => sl<AddressCubit>(),
          child: BlocListener<AddressCubit, AddressState>(
            listener: (context, state) {
              if (state is CreateAddressLoaded) {
                context.pop();
                _callGetSavedAddressApi();
              } else if (state is CreateAddressError) {
                widget.showErrorToast(context: context, message: state.error);
              }
            },
            child: AddressBottomSheet(),
          ),
        );
      },
    );
  }

  void _callGetSavedAddressApi() {
    context.read<AddressCubit>().getSavedAddress();
  }
}
