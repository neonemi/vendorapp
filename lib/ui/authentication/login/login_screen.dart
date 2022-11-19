import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:vendorapp/core/icons/app_icon_keys.g.dart';
import '../../../../core/core.dart';
import '../../ui.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  late final LoginCubit _cubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) {
        _cubit = LoginCubit(context.read<CoreRepository>());
        return _cubit;
      },
      child: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            context.loaderOverlay.show();
          } else {
            context.loaderOverlay.hide();
          }
          if (state is LoginSendOTPSuccess) {
            if (state.response.data == null) {
              if (kDebugMode) {
                print("json hello");
              }
              context.showOtpConfirm(
                  message: state.response.message.toString(),
                  onConfirm: () {},
                  title: 'Alert');
              // context.showToast(state.otp.message.toString());
            } else {
              context.showToast(state.response.message.toString());
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return OtpVerifyScreen(
                      phoneNumber: _phoneController.text.toString());
                },
              ));
            }
          }
          if (state is LoginSendOTPError) {
            context.showToast(state.message);
          }
        },
        child: Scaffold(
          appBar:  PreferredSize(
            preferredSize: const Size.fromHeight(0.0),
            child: AppBar(
              toolbarHeight: 0,
              backgroundColor: AppTheme.appRed,
              elevation: 0.0,
            ),
          ),
          body: GestureDetector(
            onTap: () {
              // Hide keyboard if touched outside of text field
              _hideKeyboard();
            },
            behavior: HitTestBehavior.translucent,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    color: AppTheme.appRed,
                    height: MediaQuery.of(context).size.height * 1 / 3,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                        child: Image.asset(
                      AppIconKeys.dwarikaLogo2,
                      height: 200,
                      width: 200,
                    )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                            fontSize: 24,
                            color: AppTheme.appBlack,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat'),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.all(10),
                      child: Text(
                        'Enter your phone number and we will send an OTP to continue',
                        style:
                            TextStyle(fontSize: 16, color: AppTheme.appBlack),
                        textAlign: TextAlign.center,
                      )),
                  Container(
                      margin:
                          const EdgeInsets.only(left: 20, right: 20, top: 10),
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Mobile No.',
                        style:
                            TextStyle(fontSize: 14, color: AppTheme.appBlack),
                        textAlign: TextAlign.left,
                      )),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    height: 70,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          margin: const EdgeInsets.only(right: 10),
                          child: Column(
                            children: [
                              Container(
                                  height: 48,
                                  width: 70,
                                  alignment: Alignment.center,
                                  child: Text(
                                    '+91',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: AppTheme.appBlack),
                                  )),
                              const Divider(
                                height: 1,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 70,
                          width: MediaQuery.of(context).size.width - 120,
                          child: Column(
                            children: [
                              TextFormField(
                                style: TextStyle(
                                    fontSize: 16, color: AppTheme.appBlack),
                                decoration: InputDecoration(
                                    hintText: 'Phone Number',
                                    hintStyle: TextStyle(
                                        fontSize: 16,
                                        color: AppTheme.appGrey),
                                    border: InputBorder.none,
                                    counterStyle: const TextStyle(
                                      height: double.minPositive,
                                    ),
                                    counterText: ""),
                                onChanged: (phone) {
                                  debugPrint(phone);
                                },
                                maxLength: 10,
                                controller: _phoneController,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                              ),
                              const Divider(
                                height: 1,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: AppTheme.appRed,
                          elevation: 3,
                          alignment: Alignment.center,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          fixedSize: const Size(170, 52),
                          //////// HERE
                        ),
                        onPressed: () => _onTapSendOtp(context),
                        child: const Text(
                          "Send OTP",
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Didn't have account?",
                          style: TextStyle(
                              fontSize: 16, color: AppTheme.appBlack),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return const RegisterScreen();
                              },
                            ));
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                                fontSize: 16, color: AppTheme.appRed),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  _onTapSendOtp(BuildContext context) {
    _hideKeyboard();
    // TODO : validate mobile number
    debugPrint(
        '_phoneNumberController.text.length ${_phoneController.text.length}');
    if (_phoneController.text.isNotEmpty &&
        _phoneController.text.length == 10) {
      _cubit.sendOTP(
        phoneNumber: _phoneController.text,
      );
    } else {
      context.showToast("Enter Mobile Number");
    }
  }
}
