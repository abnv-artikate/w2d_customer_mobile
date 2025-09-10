import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';
import 'package:w2d_customer_mobile/features/presentation/cubit/common/common_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/screens/auth/login_bottomsheet.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/custom_filled_button_widget.dart';
import 'package:w2d_customer_mobile/routes/routes_constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _loginSheetQueued = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final shouldShow = _shouldShowLoginPrompt();
      if (shouldShow && !_loginSheetQueued) {
        _loginSheetQueued = true;
        _showLoginBottomSheet();
      }
    });
  }

  _showLoginBottomSheet() async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      enableDrag: true,
      useSafeArea: true,
      showDragHandle: true,
      scrollControlDisabledMaxHeightRatio: 0.9,
      builder: (BuildContext context) {
        return LoginBottomSheet();
      },
    ).then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CommonCubit, CommonState>(
      listener: (context, state) {
        if (state is LogOut) {
          _buildBody();
        }
        if (state is VerifyOtpSuccess) {
          setState(() {});
          _loginSheetQueued = false;
          _buildBody();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'My Account',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            centerTitle: true,
          ),
          body: _buildBody(),
        );
      },
    );
  }

  _buildBody() {
    return _shouldShowLoginPrompt()
        ? Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Log In / Sign Up",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 30),
              CustomFilledButtonWidget(
                onTap: () {
                  _showLoginBottomSheet();
                },
                height: 50,
                width: MediaQuery.of(context).size.width * 0.4,
                color: AppColors.worldGreen80,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(LucideIcons.logIn, color: AppColors.white),
                    SizedBox(width: 10),
                    Text(
                      "Log In",
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
        : Container(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _profileListItem(
                title: 'Profile',
                onItemTap: () {
                  context.push(AppRoutes.userProfileRoute);
                },
                iconData: LucideIcons.user2,
              ),
              Divider(),
              _profileListItem(
                title: 'Wishlist',
                onItemTap: () {
                  context.push(AppRoutes.wishlistRoute);
                },
                iconData: LucideIcons.heart,
              ),
              Divider(),
              _profileListItem(
                title: 'Addresses',
                onItemTap: () {
                  context.push(AppRoutes.addressRoute);
                },
                iconData: LucideIcons.mapPin,
              ),
              Divider(),
              _profileListItem(
                title: 'Orders',
                onItemTap: () {
                  context.push(AppRoutes.orderRoute);
                },
                iconData: LucideIcons.package,
              ),
              Divider(),
              _profileListItem(
                title: 'Logout',
                onItemTap: () {
                  context.read<CommonCubit>().logout();
                },
                iconData: LucideIcons.logOut,
              ),
            ],
          ),
        );
  }

  _profileListItem({
    required String title,
    required VoidCallback onItemTap,
    required IconData iconData,
  }) {
    return GestureDetector(
      onTap: onItemTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Icon(iconData),
            SizedBox(width: 10),
            Text(title, style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }

  bool _shouldShowLoginPrompt() {
    return !context.read<CommonCubit>().isUserLoggedIn();
  }
}
