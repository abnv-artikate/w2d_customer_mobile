import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:w2d_customer_mobile/features/presentation/common/cubit/common_cubit.dart';

class LocationWidget extends StatefulWidget {
  final VoidCallback onTap;

  const LocationWidget({super.key, required this.onTap});

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  String _location = "Tap to fetch location";

  @override
  void initState() {
    callLocationAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        callLocationAPI();
      },
      child: Container(
        margin: EdgeInsets.only(right: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(LucideIcons.mapPin),
            SizedBox(width: 5),
            BlocConsumer<CommonCubit, CommonState>(
              listener: (context, state) {
                if (state is GetLocationLoading) {
                  _location = "Fetching Location";
                } else if (state is GetLocationLoaded) {
                  _getAddressFromLatLng(state.location);
                } else if (state is CommonError) {
                  _location = state.error;
                }
              },
              builder: (context, state) {
                return Text(
                  _location,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  _getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      Placemark place = placemarks[0];

      setState(() {
        _location = "${place.subLocality}, ${place.locality}";
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void callLocationAPI() {
    context.read<CommonCubit>().getCurrentLocation();
  }
}
