import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:vendorapp/core/core.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  UpdateProfileScreenState createState() => UpdateProfileScreenState();
}

class UpdateProfileScreenState extends State<UpdateProfileScreen> {
  String _phoneController = "";
  String _nameController = "";
  String _emailController = "";
  String birthdayValue = "";
  String? birthdayDateValue;
  DateTime? birthdaySelectedDate;
  String imageValue = "";
  // = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  String anniversaryValue = "";
  String? anniversaryDateValue;
  DateTime? anniversarySelectedDate;
  File? _image;
  final ImagePicker _picker = ImagePicker();
  // = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  String strDigits(int n) => n.toString().padLeft(2, '0');
  String strDigits4(int n) => n.toString().padLeft(2, '0');
  double fontSize = 14.0;

  late final UpdateProfileCubit _cubit;
  @override
  void initState() {
    super.initState();
  }

// Nov 18 2022
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return BlocProvider<UpdateProfileCubit>(
        create: (context) {
          _cubit = UpdateProfileCubit(context.read<CoreRepository>());
          _cubit.getProfile();
          return _cubit;
        },
        child: BlocListener<UpdateProfileCubit, UpdateProfileState>(
          listener: (context, state) {
            if (state is UpdateProfileLoading) {
              context.loaderOverlay.show();
            } else {
              context.loaderOverlay.hide();
            }

            if (state is UpdateProfileError) {
              context.showToast(state.message);
            }
          },
          child: Scaffold(
              appBar: AppBar(
                backgroundColor: AppTheme.appRed,
                iconTheme: IconThemeData(color: AppTheme.appWhite),
                centerTitle: true,
                elevation: 0.0,
                title: Container(
                  margin: const EdgeInsets.only(right: 40),
                  height: 50,
                  alignment: Alignment.center,
                  child: Text(
                    'Update Profile',
                    style: TextStyle(
                        color: AppTheme.appWhite,
                        fontSize: 20,
                        fontStyle: FontStyle.normal,
                        fontFamily: "Montserrat"),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              body: BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
                  builder: (context, state) {
                    final DateFormat format1 = DateFormat('MMM');
                if (state is GetProfileSuccess) {
                  if (_nameController.isEmpty) {
                    _nameController = state.userName;
                  }
                  print(_nameController);
                  if (_emailController.isEmpty) {
                    _emailController = state.email;
                  }
                  if (_phoneController.isEmpty) {
                    _phoneController = state.mobile;
                  }
                  if (birthdayValue.isEmpty && state.dob.isNotEmpty) {
                    birthdayValue =
                        "${(format1.format(DateTime.parse(state.dob.toString())))} ${strDigits(DateTime.parse(state.dob.toString()).day)} ${strDigits4(DateTime.parse(state.dob.toString()).year)}";
                  }
                  if (anniversaryValue.isEmpty && state.anniversary.isNotEmpty) {
                    anniversaryValue =
                        "${(format1.format(DateTime.parse(state.anniversary)))} ${strDigits(DateTime.parse(state.anniversary).day)} ${strDigits4(DateTime.parse(state.anniversary).year)}";
                  }
                  if (imageValue.isEmpty) {
                    imageValue = state.image;
                  }
                  return GestureDetector(
                    onTap: () {
                      // Hide keyboard if touched outside of text field
                      _hideKeyboard();
                    },
                    behavior: HitTestBehavior.translucent,
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: ListView(
                        children: [
                          Container(
                            height: 150,
                            width: MediaQuery.of(context).size.width,
                            color: AppTheme.appRed,
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () {
                                _onTapProfile(context);
                              },
                              child: SizedBox(
                                height: 100,
                                width: 100,
                                child: Stack(
                                  children: [
                                    _image == null
                                        ? imageValue.isEmpty
                                            ? Image.asset(
                                                AppIconKeys.userPlaceholder,
                                                height: 100,
                                                width: 100,
                                              )
                                            : SizedBox(
                                                height: 100,
                                                width: 100,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  child: Image.network(
                                                    '${Apis.imageBaseUrl}$imageValue',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              )
                                        : SizedBox(
                                            height: 100,
                                            width: 100,
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                child: Image.file(
                                                  _image!,
                                                  fit: BoxFit.cover,
                                                ))),
                                    Align(
                                        alignment: Alignment.bottomRight,
                                        child: Container(
                                            height: 40,
                                            width: 40,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: AppTheme.appWhite,
                                                shape: BoxShape.circle),
                                            child: Icon(
                                              Icons.edit,
                                              color: AppTheme.appRed,
                                              size: 20,
                                            )))
                                  ],
                                ),
                              ),
                            ),
                          ),
                          ListBody(children: [
                            Container(
                                margin: const EdgeInsets.only(
                                    left: 20, right: 20, top: 30),
                                width: MediaQuery.of(context).size.width,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Full Name',
                                  style: TextStyle(
                                      fontSize: fontSize,
                                      color: AppTheme.appBlack),
                                  textAlign: TextAlign.left,
                                )),
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 20, right: 20),
                              height: 40,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 38,
                                    child: TextFormField(
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: AppTheme.appBlack),
                                      decoration: InputDecoration(
                                          hintText: 'Enter your name',
                                          hintStyle: TextStyle(
                                              fontSize: fontSize,
                                              color: AppTheme.appGrey),
                                          border: InputBorder.none,
                                          counterStyle: const TextStyle(
                                            height: double.minPositive,
                                          ),
                                          counterText: ""),
                                      onChanged: (value) {
                                        setState(() {
                                          _nameController = value;
                                        });
                                      },
                                      initialValue: state.userName,
                                      maxLength: 200,
                                      // controller: _nameController,
                                      keyboardType: TextInputType.name,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter
                                            .singleLineFormatter
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    height: 1,
                                    color: Colors.grey,
                                  )
                                ],
                              ),
                            ),
                            Container(
                                margin: const EdgeInsets.only(
                                    left: 20, right: 20, top: 10),
                                width: MediaQuery.of(context).size.width,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Email',
                                  style: TextStyle(
                                      fontSize: fontSize,
                                      color: AppTheme.appBlack),
                                  textAlign: TextAlign.left,
                                )),
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 20, right: 20),
                              height: 40,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 38,
                                    child: TextFormField(
                                      style: TextStyle(
                                          fontSize: fontSize,
                                          color: AppTheme.appBlack),
                                      decoration: InputDecoration(
                                          hintText: 'Enter your email',
                                          hintStyle: TextStyle(
                                              fontSize: fontSize,
                                              color: AppTheme.appGrey),
                                          border: InputBorder.none,
                                          counterStyle: const TextStyle(
                                            height: double.minPositive,
                                          ),
                                          counterText: ""),
                                      onChanged: (email) {
                                        _emailController = email;
                                      },
                                      initialValue: _emailController,
                                      maxLength: 200,
                                      // controller: _emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter
                                            .singleLineFormatter
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    height: 1,
                                    color: Colors.grey,
                                  )
                                ],
                              ),
                            ),
                            Container(
                                margin: const EdgeInsets.only(
                                    left: 20, right: 20, top: 10),
                                width: MediaQuery.of(context).size.width,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Mobile No.',
                                  style: TextStyle(
                                      fontSize: fontSize,
                                      color: AppTheme.appBlack),
                                  textAlign: TextAlign.left,
                                )),
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 20, right: 20),
                              height: 40,
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 70,
                                    margin: const EdgeInsets.only(right: 10),
                                    child: Column(
                                      children: [
                                        Container(
                                            height: 38,
                                            width: 70,
                                            alignment: Alignment.center,
                                            child: Text(
                                              '+91',
                                              style: TextStyle(
                                                  fontSize: fontSize,
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
                                    height: 40,
                                    width:
                                        MediaQuery.of(context).size.width - 120,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 38,
                                          child: TextFormField(
                                            style: TextStyle(
                                                fontSize: fontSize,
                                                color: AppTheme.appBlack),
                                            decoration: InputDecoration(
                                                hintText: 'Phone Number',
                                                hintStyle: TextStyle(
                                                    fontSize: fontSize,
                                                    color: AppTheme.appGrey),
                                                border: InputBorder.none,
                                                counterStyle: const TextStyle(
                                                  height: double.minPositive,
                                                ),
                                                counterText: ""),
                                            // onChanged: (phone) {
                                            //   debugPrint(phone);
                                            // },
                                            cursorHeight: 0.0,
                                            cursorWidth: 0.0,
                                            cursorRadius: Radius.zero,
                                            enableInteractiveSelection: false,
                                            initialValue: _phoneController,
                                            maxLength: 10,
                                            // controller: _phoneController,
                                            keyboardType: TextInputType.none,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                          ),
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
                                margin: const EdgeInsets.only(
                                    left: 20, right: 20, top: 10),
                                width: MediaQuery.of(context).size.width,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Your Birthday',
                                  style: TextStyle(
                                      fontSize: fontSize,
                                      color: AppTheme.appBlack),
                                  textAlign: TextAlign.left,
                                )),
                            GestureDetector(
                              onTap: () {
                                _selectBirthday(context);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                    left: 20, right: 20, top: 10),
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: birthdayValue.isEmpty
                                                ? Text(
                                                    "Select Birthday",
                                                    style: TextStyle(
                                                        fontSize: fontSize,
                                                        color:
                                                            AppTheme.appGrey),
                                                  )
                                                : Text(
                                                    birthdayValue.toString(),
                                                    style: TextStyle(
                                                        fontSize: fontSize,
                                                        color:
                                                            AppTheme.appBlack),
                                                  ),
                                          ),
                                          Icon(
                                            Icons.keyboard_arrow_down,
                                            size: 28,
                                            color: AppTheme.appGrey,
                                          )
                                        ],
                                      ),
                                    ),
                                    const Divider(
                                      height: 1,
                                      color: Colors.grey,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                                margin: const EdgeInsets.only(
                                    left: 20, right: 20, top: 0),
                                width: MediaQuery.of(context).size.width,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Your Anniversary',
                                  style: TextStyle(
                                      fontSize: fontSize,
                                      color: AppTheme.appBlack),
                                  textAlign: TextAlign.left,
                                )),
                            GestureDetector(
                              onTap: () {
                                _selectAnniversary(context);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                    left: 20, right: 20, top: 10),
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: anniversaryValue.isEmpty
                                                ? Text(
                                                    "Select Anniversary",
                                                    style: TextStyle(
                                                        fontSize: fontSize,
                                                        color:
                                                            AppTheme.appGrey),
                                                  )
                                                : Text(
                                                    anniversaryValue.toString(),
                                                    style: TextStyle(
                                                        fontSize: fontSize,
                                                        color:
                                                            AppTheme.appBlack),
                                                  ),
                                          ),
                                          Icon(
                                            Icons.keyboard_arrow_down,
                                            size: 28,
                                            color: AppTheme.appGrey,
                                          )
                                        ],
                                      ),
                                    ),
                                    const Divider(
                                      height: 1,
                                      color: Colors.grey,
                                    )
                                  ],
                                ),
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
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                    fixedSize: const Size(150, 52),
                                    //////// HERE
                                  ),
                                  onPressed: () => _onTapUpdate(context),
                                  child: const Text(
                                    "Update",
                                    style: TextStyle(fontSize: 16),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ])
                        ],
                      ),
                    ),
                  );
                }
                if (state is UpdateProfileSuccess) {
                  final DateFormat format1 = DateFormat('MMM');
                  UpdateProfileResponse updateProfileResponse = state.response;
                  if (kDebugMode) {
                    print(updateProfileResponse);
                  }
                  _nameController = updateProfileResponse.data!.name!;
                  _emailController = updateProfileResponse.data!.email!;
                  _phoneController = updateProfileResponse.data!.mobile!;
                  String dob = updateProfileResponse.data!.dob ?? "";
                  if (dob.isNotEmpty) {
                    birthdayValue =
                        "${(format1.format(DateTime.parse(dob)))} ${strDigits(DateTime.parse(dob).day)} ${strDigits4(DateTime.parse(dob).year)}";
                  }
                  String anniversary =
                      updateProfileResponse.data!.anniversary ?? "";
                  if (anniversary.isNotEmpty) {
                    anniversaryValue =
                        "${(format1.format(DateTime.parse(anniversary)))} ${strDigits(DateTime.parse(anniversary).day)} ${strDigits4(DateTime.parse(anniversary).year)}";
                  }

                  imageValue = updateProfileResponse.data!.image ?? "";

                  return GestureDetector(
                    onTap: () {
                      // Hide keyboard if touched outside of text field
                      _hideKeyboard();
                    },
                    behavior: HitTestBehavior.translucent,
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: ListView(
                        children: [
                          Container(
                            height: 150,
                            width: MediaQuery.of(context).size.width,
                            color: AppTheme.appRed,
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () {
                                _onTapProfile(context);
                              },
                              child: SizedBox(
                                height: 100,
                                width: 100,
                                child: Stack(
                                  children: [
                                    _image == null
                                        ? imageValue.isEmpty
                                            ? Image.asset(
                                                AppIconKeys.userPlaceholder,
                                                height: 100,
                                                width: 100,
                                              )
                                            : SizedBox(
                                                height: 100,
                                                width: 100,
                                                child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    child: Image.network(
                                                      '${Apis.imageBaseUrl}$imageValue',
                                                      fit: BoxFit.cover,
                                                    )))
                                        : SizedBox(
                                            height: 100,
                                            width: 100,
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                child: Image.file(
                                                  _image!,
                                                  fit: BoxFit.cover,
                                                ))),
                                    Align(
                                        alignment: Alignment.bottomRight,
                                        child: Container(
                                            height: 40,
                                            width: 40,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: AppTheme.appWhite,
                                                shape: BoxShape.circle),
                                            child: Icon(
                                              Icons.edit,
                                              color: AppTheme.appRed,
                                              size: 20,
                                            )))
                                  ],
                                ),
                              ),
                            ),
                          ),
                          ListBody(children: [
                            Container(
                                margin: const EdgeInsets.only(
                                    left: 20, right: 20, top: 30),
                                width: MediaQuery.of(context).size.width,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Full Name',
                                  style: TextStyle(
                                      fontSize: fontSize,
                                      color: AppTheme.appBlack),
                                  textAlign: TextAlign.left,
                                )),
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 20, right: 20),
                              height: 40,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 38,
                                    child: TextFormField(
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: AppTheme.appBlack),
                                      decoration: InputDecoration(
                                          hintText: 'Enter your name',
                                          hintStyle: TextStyle(
                                              fontSize: fontSize,
                                              color: AppTheme.appGrey),
                                          border: InputBorder.none,
                                          counterStyle: const TextStyle(
                                            height: double.minPositive,
                                          ),
                                          counterText: ""),
                                      onChanged: (value) {
                                        setState(() {
                                          _nameController = value;
                                        });
                                      },
                                      initialValue: _nameController,
                                      maxLength: 200,
                                      // controller: _nameController,
                                      keyboardType: TextInputType.name,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter
                                            .singleLineFormatter
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    height: 1,
                                    color: Colors.grey,
                                  )
                                ],
                              ),
                            ),
                            Container(
                                margin: const EdgeInsets.only(
                                    left: 20, right: 20, top: 10),
                                width: MediaQuery.of(context).size.width,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Email',
                                  style: TextStyle(
                                      fontSize: fontSize,
                                      color: AppTheme.appBlack),
                                  textAlign: TextAlign.left,
                                )),
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 20, right: 20),
                              height: 40,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 38,
                                    child: TextFormField(
                                      style: TextStyle(
                                          fontSize: fontSize,
                                          color: AppTheme.appBlack),
                                      decoration: InputDecoration(
                                          hintText: 'Enter your email',
                                          hintStyle: TextStyle(
                                              fontSize: fontSize,
                                              color: AppTheme.appGrey),
                                          border: InputBorder.none,
                                          counterStyle: const TextStyle(
                                            height: double.minPositive,
                                          ),
                                          counterText: ""),
                                      onChanged: (email) {
                                        _emailController = email;
                                      },
                                      initialValue: _emailController,
                                      maxLength: 200,
                                      // controller: _emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter
                                            .singleLineFormatter
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    height: 1,
                                    color: Colors.grey,
                                  )
                                ],
                              ),
                            ),
                            Container(
                                margin: const EdgeInsets.only(
                                    left: 20, right: 20, top: 10),
                                width: MediaQuery.of(context).size.width,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Mobile No.',
                                  style: TextStyle(
                                      fontSize: fontSize,
                                      color: AppTheme.appBlack),
                                  textAlign: TextAlign.left,
                                )),
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 20, right: 20),
                              height: 40,
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 70,
                                    margin: const EdgeInsets.only(right: 10),
                                    child: Column(
                                      children: [
                                        Container(
                                            height: 38,
                                            width: 70,
                                            alignment: Alignment.center,
                                            child: Text(
                                              '+91',
                                              style: TextStyle(
                                                  fontSize: fontSize,
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
                                    height: 40,
                                    width:
                                        MediaQuery.of(context).size.width - 120,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 38,
                                          child: TextFormField(
                                            style: TextStyle(
                                                fontSize: fontSize,
                                                color: AppTheme.appBlack),
                                            decoration: InputDecoration(
                                                hintText: 'Phone Number',
                                                hintStyle: TextStyle(
                                                    fontSize: fontSize,
                                                    color: AppTheme.appGrey),
                                                border: InputBorder.none,
                                                counterStyle: const TextStyle(
                                                  height: double.minPositive,
                                                ),
                                                counterText: ""),
                                            // onChanged: (phone) {
                                            //   debugPrint(phone);
                                            // },
                                            cursorHeight: 0.0,
                                            cursorWidth: 0.0,
                                            cursorRadius: Radius.zero,
                                            enableInteractiveSelection: false,
                                            initialValue: _phoneController,
                                            maxLength: 10,
                                            // controller: _phoneController,
                                            keyboardType: TextInputType.none,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                          ),
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
                                margin: const EdgeInsets.only(
                                    left: 20, right: 20, top: 10),
                                width: MediaQuery.of(context).size.width,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Your Birthday',
                                  style: TextStyle(
                                      fontSize: fontSize,
                                      color: AppTheme.appBlack),
                                  textAlign: TextAlign.left,
                                )),
                            GestureDetector(
                              onTap: () {
                                _selectBirthday(context);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                    left: 20, right: 20, top: 10),
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: birthdayValue.isEmpty
                                                ? Text(
                                                    "Select Birthday",
                                                    style: TextStyle(
                                                        fontSize: fontSize,
                                                        color:
                                                            AppTheme.appGrey),
                                                  )
                                                : Text(
                                                    birthdayValue.toString(),
                                                    style: TextStyle(
                                                        fontSize: fontSize,
                                                        color:
                                                            AppTheme.appBlack),
                                                  ),
                                          ),
                                          Icon(
                                            Icons.keyboard_arrow_down,
                                            size: 28,
                                            color: AppTheme.appGrey,
                                          )
                                        ],
                                      ),
                                    ),
                                    const Divider(
                                      height: 1,
                                      color: Colors.grey,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                                margin: const EdgeInsets.only(
                                    left: 20, right: 20, top: 0),
                                width: MediaQuery.of(context).size.width,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Your Anniversary',
                                  style: TextStyle(
                                      fontSize: fontSize,
                                      color: AppTheme.appBlack),
                                  textAlign: TextAlign.left,
                                )),
                            GestureDetector(
                              onTap: () {
                                _selectAnniversary(context);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                    left: 20, right: 20, top: 10),
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: anniversaryValue.isEmpty
                                                ? Text(
                                                    "Select Anniversary",
                                                    style: TextStyle(
                                                        fontSize: fontSize,
                                                        color:
                                                            AppTheme.appGrey),
                                                  )
                                                : Text(
                                                    anniversaryValue.toString(),
                                                    style: TextStyle(
                                                        fontSize: fontSize,
                                                        color:
                                                            AppTheme.appBlack),
                                                  ),
                                          ),
                                          Icon(
                                            Icons.keyboard_arrow_down,
                                            size: 28,
                                            color: AppTheme.appGrey,
                                          )
                                        ],
                                      ),
                                    ),
                                    const Divider(
                                      height: 1,
                                      color: Colors.grey,
                                    )
                                  ],
                                ),
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
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                    fixedSize: const Size(150, 52),
                                    //////// HERE
                                  ),
                                  onPressed: () => _onTapUpdate(context),
                                  child:  Text(
                                    "Update",
                                    style: TextStyle(fontSize: 16,color: AppTheme.appWhite),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ])
                        ],
                      ),
                    ),
                  );
                }
                return
                    //SizedBox();
                    GestureDetector(
                  onTap: () {
                    // Hide keyboard if touched outside of text field
                    _hideKeyboard();
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Container(
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                          color: AppTheme.appRed,
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () {
                              _onTapProfile(context);
                            },
                            child: SizedBox(
                              height: 100,
                              width: 100,
                              child: Stack(
                                children: [
                                  _image == null
                                      ? imageValue.isEmpty
                                          ? Image.asset(
                                              AppIconKeys.userPlaceholder,
                                              height: 100,
                                              width: 100,
                                            )
                                          : SizedBox(
                                              height: 100,
                                              width: 100,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                child: Image.network(
                                                  '${Apis.imageBaseUrl}$imageValue',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            )
                                      : SizedBox(
                                          height: 100,
                                          width: 100,
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              child: Image.file(
                                                _image!,
                                                fit: BoxFit.cover,
                                              ))),
                                  Align(
                                      alignment: Alignment.bottomRight,
                                      child: Container(
                                          height: 40,
                                          width: 40,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: AppTheme.appWhite,
                                              shape: BoxShape.circle),
                                          child: Icon(
                                            Icons.edit,
                                            color: AppTheme.appRed,
                                            size: 20,
                                          )))
                                ],
                              ),
                            ),
                          ),
                        ),
                        ListBody(children: [
                          Container(
                              margin: const EdgeInsets.only(
                                  left: 20, right: 20, top: 30),
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Full Name',
                                style: TextStyle(
                                    fontSize: fontSize,
                                    color: AppTheme.appBlack),
                                textAlign: TextAlign.left,
                              )),
                          Container(
                            margin: const EdgeInsets.only(left: 20, right: 20),
                            height: 40,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 38,
                                  child: TextFormField(
                                    style: TextStyle(
                                        fontSize: 16, color: AppTheme.appBlack),
                                    decoration: InputDecoration(
                                        hintText: 'Enter your name',
                                        hintStyle: TextStyle(
                                            fontSize: fontSize,
                                            color: AppTheme.appGrey),
                                        border: InputBorder.none,
                                        counterStyle: const TextStyle(
                                          height: double.minPositive,
                                        ),
                                        counterText: ""),
                                    onChanged: (value) {
                                      setState(() {
                                        _nameController = value;
                                      });
                                    },
                                    initialValue: _nameController,
                                    maxLength: 200,
                                    // controller: _nameController,
                                    keyboardType: TextInputType.name,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter
                                          .singleLineFormatter
                                    ],
                                  ),
                                ),
                                const Divider(
                                  height: 1,
                                  color: Colors.grey,
                                )
                              ],
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10),
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Email',
                                style: TextStyle(
                                    fontSize: fontSize,
                                    color: AppTheme.appBlack),
                                textAlign: TextAlign.left,
                              )),
                          Container(
                            margin: const EdgeInsets.only(left: 20, right: 20),
                            height: 40,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 38,
                                  child: TextFormField(
                                    style: TextStyle(
                                        fontSize: fontSize,
                                        color: AppTheme.appBlack),
                                    decoration: InputDecoration(
                                        hintText: 'Enter your email',
                                        hintStyle: TextStyle(
                                            fontSize: fontSize,
                                            color: AppTheme.appGrey),
                                        border: InputBorder.none,
                                        counterStyle: const TextStyle(
                                          height: double.minPositive,
                                        ),
                                        counterText: ""),
                                    onChanged: (email) {
                                      _emailController = email;
                                    },
                                    initialValue: _emailController,
                                    maxLength: 200,
                                    // controller: _emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter
                                          .singleLineFormatter
                                    ],
                                  ),
                                ),
                                const Divider(
                                  height: 1,
                                  color: Colors.grey,
                                )
                              ],
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10),
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Mobile No.',
                                style: TextStyle(
                                    fontSize: fontSize,
                                    color: AppTheme.appBlack),
                                textAlign: TextAlign.left,
                              )),
                          Container(
                            margin: const EdgeInsets.only(left: 20, right: 20),
                            height: 40,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: 40,
                                  width: 70,
                                  margin: const EdgeInsets.only(right: 10),
                                  child: Column(
                                    children: [
                                      Container(
                                          height: 38,
                                          width: 70,
                                          alignment: Alignment.center,
                                          child: Text(
                                            '+91',
                                            style: TextStyle(
                                                fontSize: fontSize,
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
                                  height: 40,
                                  width:
                                      MediaQuery.of(context).size.width - 120,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 38,
                                        child: TextFormField(
                                          style: TextStyle(
                                              fontSize: fontSize,
                                              color: AppTheme.appBlack),
                                          decoration: InputDecoration(
                                              hintText: 'Phone Number',
                                              hintStyle: TextStyle(
                                                  fontSize: fontSize,
                                                  color: AppTheme.appGrey),
                                              border: InputBorder.none,
                                              counterStyle: const TextStyle(
                                                height: double.minPositive,
                                              ),
                                              counterText: ""),
                                          // onChanged: (phone) {
                                          //   debugPrint(phone);
                                          // },
                                          cursorHeight: 0.0,
                                          cursorWidth: 0.0,
                                          cursorRadius: Radius.zero,
                                          enableInteractiveSelection: false,
                                          initialValue: _phoneController,
                                          maxLength: 10,
                                          // controller: _phoneController,
                                          keyboardType: TextInputType.none,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                        ),
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
                              margin: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10),
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Your Birthday',
                                style: TextStyle(
                                    fontSize: fontSize,
                                    color: AppTheme.appBlack),
                                textAlign: TextAlign.left,
                              )),
                          GestureDetector(
                            onTap: () {
                              _selectBirthday(context);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10),
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: birthdayValue.isEmpty
                                              ? Text(
                                                  "Select Birthday",
                                                  style: TextStyle(
                                                      fontSize: fontSize,
                                                      color: AppTheme.appGrey),
                                                )
                                              : Text(
                                                  birthdayValue.toString(),
                                                  style: TextStyle(
                                                      fontSize: fontSize,
                                                      color: AppTheme.appBlack),
                                                ),
                                        ),
                                        Icon(
                                          Icons.keyboard_arrow_down,
                                          size: 28,
                                          color: AppTheme.appGrey,
                                        )
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    height: 1,
                                    color: Colors.grey,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.only(
                                  left: 20, right: 20, top: 0),
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Your Anniversary',
                                style: TextStyle(
                                    fontSize: fontSize,
                                    color: AppTheme.appBlack),
                                textAlign: TextAlign.left,
                              )),
                          GestureDetector(
                            onTap: () {
                              _selectAnniversary(context);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10),
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: anniversaryValue.isEmpty
                                              ? Text(
                                                  "Select Anniversary",
                                                  style: TextStyle(
                                                      fontSize: fontSize,
                                                      color: AppTheme.appGrey),
                                                )
                                              : Text(
                                                  anniversaryValue.toString(),
                                                  style: TextStyle(
                                                      fontSize: fontSize,
                                                      color: AppTheme.appBlack),
                                                ),
                                        ),
                                        Icon(
                                          Icons.keyboard_arrow_down,
                                          size: 28,
                                          color: AppTheme.appGrey,
                                        )
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    height: 1,
                                    color: Colors.grey,
                                  )
                                ],
                              ),
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
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                  fixedSize: const Size(150, 52),
                                  //////// HERE
                                ),
                                onPressed: () => _onTapUpdate(context),
                                child: const Text(
                                  "Update",
                                  style: TextStyle(fontSize: 16),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ])
                      ],
                    ),
                  ),
                );
              })),
        ));
  }

  void _hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  _onTapUpdate(BuildContext context) {
    _hideKeyboard();
    if (kDebugMode) {
      print(_nameController);
    }
    if (kDebugMode) {
      print(_emailController);
    }
    if (kDebugMode) {
      print(birthdaySelectedDate);
    }
    if (_nameController.isNotEmpty && _nameController.length > 2) {
      if (_emailController.isNotEmpty &&
          AppFunctions.isEmailValid(_emailController)) {
        if(_image==null) {
          _cubit.updateProfile(
            name: _nameController,
            email: _emailController,
            imageFile: null,
            dob: birthdaySelectedDate,
            anniversary: anniversarySelectedDate);
        }else{
          _cubit.updateProfileFile(
              name: _nameController,
              email: _emailController,
              imageFile: _image,
              dob: birthdaySelectedDate,
              anniversary: anniversarySelectedDate
          );
        }
      }else{
        context.showToast("Please enter email");
      }
    }else{
      context.showToast("Please enter name");
    }
  }

  _selectBirthday(BuildContext context) async {
    var date =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(DateTime.now().year - 99),
      lastDate: date,
    );
    final DateFormat format1 =
        DateFormat('MMM'); // abbreviated, exp. : Jan, Feb, Mar
    if (selected != null) {
      setState(() {
        //Nov 18 2022
        //api formate 2000-01-15 00:00:00
        birthdaySelectedDate = selected;
        birthdayDateValue =
            "${strDigits(birthdaySelectedDate!.day)}-${strDigits(birthdaySelectedDate!.month)}-${strDigits4(birthdaySelectedDate!.year)}";
        birthdayValue =
            "${(format1.format(birthdaySelectedDate!))} ${strDigits(birthdaySelectedDate!.day)} ${strDigits4(birthdaySelectedDate!.year)}";
        if (kDebugMode) {
          print(birthdayValue);
        }
      });
    }
  }

  _selectAnniversary(BuildContext context) async {
    var date =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(DateTime.now().year - 99),
      lastDate: date,
    );
    final DateFormat format1 =
        DateFormat('MMM'); // abbreviated, exp. : Jan, Feb, Mar
    if (selected != null) {
      setState(() {
        //Nov 18 2022
        anniversarySelectedDate = selected;
        anniversaryDateValue =
            "${strDigits(anniversarySelectedDate!.day)}-${strDigits(anniversarySelectedDate!.month)}-${strDigits4(anniversarySelectedDate!.year)}";
        anniversaryValue = anniversarySelectedDate!.toString();
      });
    }
  }

  Future getImagefromcamera() async {
    var image = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = File(image!.path);
    });
  }

  Future getImagefromGallery() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = File(image!.path);
    });
  }

  _onTapProfile(BuildContext context) {
    AlertExtension(context).showCameraAlert(
      title: 'Select Profile',
      cancelTextButton: 'CANCEL',
      onCamera: () {
        getImagefromcamera();
      },
      onGallery: () {
        getImagefromGallery();
      },
      height: 220,
      width: MediaQuery.of(context).size.width - 40,
    );
  }
}
