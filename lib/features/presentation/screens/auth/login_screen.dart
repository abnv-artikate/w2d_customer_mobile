import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:w2d_customer_mobile/core/extension/widget_ext.dart';
import 'package:w2d_customer_mobile/routes/routes_constants.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/auth/send_otp_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/auth/verify_otp_usecase.dart';
import 'package:w2d_customer_mobile/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/blank_button_widget.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/custom_filled_button_widget.dart';
import 'package:w2d_customer_mobile/generated/assets.dart';

class LoginScreen extends StatefulWidget {
  final bool isCheckout;

  const LoginScreen({super.key, required this.isCheckout});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLogin = true;
  bool isVerify = false;
  String buttonText = "Continue";
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _otpCtrl = TextEditingController();
  final TextEditingController _nameCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _otpCtrl.dispose();
    _nameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(toolbarHeight: 10),
      body: SafeArea(
        bottom: true,
        top: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is SendOtpSuccess) {
                buttonText = "Verify";
                isVerify = true;
                isLogin = true;
              } else if (state is AuthError) {
                widget.showErrorToast(context: context, message: state.error);
              }

              if (state is VerifyOtpSuccess) {
                if (widget.isCheckout) {
                  context.pop();
                  context.push(AppRoutes.checkoutRoute);
                } else {
                  context.go(AppRoutes.initial, extra: state.userEntity);
                }
              } else if (state is AuthError) {
                widget.showErrorToast(context: context, message: state.error);
              }
            },
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _logo(),
                  _inputForm(
                    context,
                    emailCtrl: _emailCtrl,
                    otpCtrl: _otpCtrl,
                    nameCtrl: _nameCtrl,
                  ),
                  _guestOrSignUp(context),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  _logo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          Assets.iconsW2DVerticalLogo,
          width: 120,
          color: AppColors.deepBlue,
        ),
        SizedBox(height: 10),
        Text(
          'Enter your email to Sign In',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  // _termsAndCondition() {
  //   return Column(
  //     children: [
  //       SizedBox(height: 20),
  //       Text(
  //         'By continuing, you agree to World 2 Door’s Conditions of Use and Privacy Notice.',
  //         style: TextStyle(
  //           fontFamily: 'CormorantGaramond',
  //           fontWeight: FontWeight.w400,
  //           fontSize: 12,
  //         ),
  //       ),
  //       SizedBox(height: 20),
  //     ],
  //   );
  // }

  _guestOrSignUp(BuildContext context) {
    return Column(
      children: [
        CustomFilledButtonWidget(
          title: isLogin ? 'Sign-Up' : 'Sign-In',
          color: AppColors.deepBlue,
          height: 60,
          width: MediaQuery.of(context).size.width,
          onTap: () {
            setState(() {
              isLogin = !isLogin;
            });
          },
        ),
        // SizedBox(height: 10),
        // BlankButtonWidget(
        //   title: 'Continue as Guest',
        //   height: 50,
        //   width: MediaQuery.of(context).size.width,
        //   onTap: () {
        //     context.go(AppRoutes.initial);
        //   },
        // ),
        // _termsAndCondition(),
      ],
    );
  }

  _inputForm(
    BuildContext context, {
    required TextEditingController emailCtrl,
    required TextEditingController otpCtrl,
    required TextEditingController nameCtrl,
  }) {
    return Column(
      children: [
        TextField(
          controller: emailCtrl,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.black70),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.worldGreen, width: 2),
            ),
            hintText: 'Email',
            hintStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
            contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
          ),
          style: TextStyle(
            color: AppColors.black,
            fontSize: 24,
            fontWeight: FontWeight.w400,
          ),
        ),
        if (isVerify) ...[
          SizedBox(height: 10),
          TextField(
            controller: otpCtrl,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColors.black70),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColors.black70),
              ),
              hintText: 'OTP',
              hintStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 16,
              ),
            ),
            style: TextStyle(
              color: AppColors.black,
              fontSize: 24,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
        if (!isLogin) ...[
          SizedBox(height: 10),
          TextField(
            controller: nameCtrl,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColors.black70),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColors.black70),
              ),
              hintText: 'Full Name',
              hintStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 16,
              ),
            ),
            style: TextStyle(
              color: AppColors.black,
              fontSize: 24,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
        SizedBox(height: 10),
        CustomFilledButtonWidget(
          title: buttonText,
          color: AppColors.worldGreen,
          height: 60,
          width: MediaQuery.of(context).size.width,
          onTap: () {
            if (isLogin && !isVerify) {
              if (emailCtrl.text.isNotEmpty) {
                context.read<AuthCubit>().sendOtp(
                  SendOtpParams(email: emailCtrl.text, type: "existing"),
                );
              } else {
                widget.showErrorToast(
                  context: context,
                  message: 'Email cannot be blank',
                );
              }
            }

            if (isLogin && isVerify) {
              if (emailCtrl.text.isNotEmpty && otpCtrl.text.isNotEmpty) {
                context.read<AuthCubit>().verifyOtp(
                  VerifyOtpParams(email: emailCtrl.text, otp: otpCtrl.text),
                );
              } else {
                widget.showErrorToast(
                  context: context,
                  message: 'Email or OTP cannot be empty',
                );
              }
            }
          },
        ),
      ],
    );
  }
}
