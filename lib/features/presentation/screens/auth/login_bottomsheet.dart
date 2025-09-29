import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:w2d_customer_mobile/core/extension/widget_ext.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/auth/send_otp_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/auth/verify_otp_usecase.dart';
import 'package:w2d_customer_mobile/features/presentation/cubit/common/common_cubit.dart';
import 'package:w2d_customer_mobile/features/presentation/widgets/custom_filled_button_widget.dart';
import 'package:w2d_customer_mobile/generated/assets.dart';

class LoginBottomSheet extends StatefulWidget {
  const LoginBottomSheet({super.key});

  @override
  State<LoginBottomSheet> createState() => _LoginBottomSheetState();
}

class _LoginBottomSheetState extends State<LoginBottomSheet> {
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: BlocConsumer<CommonCubit, CommonState>(
        listener: (context, state) {
          if (state is SendOtpSuccess) {
            buttonText = "Verify";
            isVerify = true;
            isLogin = true;
          } else if (state is VerifyOtpSuccess) {
            context.pop();
          } else if (state is AuthError) {
            _showError(state.error);
          }
        },
        builder: (context, state) {
          return ListView(
            children: [
              _logo(),
              _inputForm(),
              _guestOrSignUp(),
              SizedBox(height: 150),
            ],
          );
        },
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

  _guestOrSignUp() {
    return Column(
      children: [
        SizedBox(height: 50),
        CustomFilledButtonWidget(
          title: Text(
            isLogin ? 'Sign-Up' : 'Sign-In',
            style: TextStyle(
              fontSize: 25,
              color: AppColors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          color: AppColors.deepBlue,
          height: 60,
          width: MediaQuery.of(context).size.width,
          onTap: () {
            setState(() {
              isLogin = !isLogin;
            });
          },
        ),
      ],
    );
  }

  _inputForm() {
    return Column(
      children: [
        TextField(
          controller: _emailCtrl,
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
            controller: _otpCtrl,
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
            controller: _nameCtrl,
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
          title: Text(
            buttonText,
            style: TextStyle(
              fontSize: 25,
              color: AppColors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          color: AppColors.worldGreen,
          height: 60,
          width: MediaQuery.of(context).size.width,
          onTap: () {
            if (!isLogin) {
              if (_nameCtrl.text.isEmpty) {
                _showError('Name cannot be blank');
              } else if (_emailCtrl.text.isEmpty) {
                _showError('Email cannot be blank');
              } else {
                _callSendOtpApi(type: "new", fullName: _nameCtrl.text);
              }
            }

            if (isLogin && !isVerify) {
              if (_emailCtrl.text.isNotEmpty) {
                _callSendOtpApi(type: "existing");
              } else {
                _showError('Email cannot be blank');
              }
            }

            if (isLogin && isVerify) {
              if (_emailCtrl.text.isNotEmpty && _otpCtrl.text.isNotEmpty) {
                _callVerifyOtpApi();
              } else {
                _showError('Email or OTP cannot be empty');
              }
            }
          },
        ),
      ],
    );
  }

  void _callVerifyOtpApi() {
    context.read<CommonCubit>().verifyOtp(
      VerifyOtpParams(email: _emailCtrl.text, otp: _otpCtrl.text),
    );
  }

  void _callSendOtpApi({required String type, String fullName = ""}) {
    context.read<CommonCubit>().sendOtp(
      fullName.isEmpty
          ? SendOtpParams(email: _emailCtrl.text, type: type)
          : SendOtpParams(
            email: _emailCtrl.text,
            fullName: fullName,
            type: type,
          ),
    );
  }

  void _showError(String text) {
    widget.showErrorToast(context: context, message: text);
  }
}
