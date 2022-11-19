import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:vendorapp/core/core.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  UpdateProfileScreenState createState() => UpdateProfileScreenState();
}

class UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String? birthdayValue;
  String? birthdayDateValue;
  DateTime? birthdaySelectedDate ;
  // = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  String? anniversaryValue;
  String? anniversaryDateValue;
  DateTime? anniversarySelectedDate;
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
          return _cubit;
        },
        child: BlocListener<UpdateProfileCubit, UpdateProfileState>(
          listener: (context, state) {
            if (state is UpdateProfileLoading) {
              context.loaderOverlay.show();
            } else {
              context.loaderOverlay.hide();
            }
            if (state is UpdateProfileSuccess) {

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
              body: GestureDetector(
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
                        child: Container(
                          height: 100,
                          width: 100,
                          child: Stack(
                            children: [
                              Image.asset(
                                AppIconKeys.userPlaceholder,
                                height: 100,
                                width: 100,
                              ),
                              Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          color: AppTheme.appRed,
                                          shape: BoxShape.circle),
                                      child: Icon(
                                        Icons.facebook,
                                        color: AppTheme.appWhite,
                                        size: 40,
                                      )))
                            ],
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
                                  fontSize: fontSize, color: AppTheme.appBlack),
                              textAlign: TextAlign.left,
                            )),
                        Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              Container(
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
                                  onChanged: (phone) {
                                    debugPrint(phone);
                                  },
                                  maxLength: 200,
                                  controller: _nameController,
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
                                  fontSize: fontSize, color: AppTheme.appBlack),
                              textAlign: TextAlign.left,
                            )),
                        Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              Container(
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
                                  onChanged: (phone) {
                                    debugPrint(phone);
                                  },
                                  maxLength: 200,
                                  controller: _emailController,
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
                                  fontSize: fontSize, color: AppTheme.appBlack),
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
                                width: MediaQuery.of(context).size.width - 120,
                                child: Column(
                                  children: [
                                    Container(
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
                                  fontSize: fontSize, color: AppTheme.appBlack),
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
                                        child: birthdayValue == null
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
                                  fontSize: fontSize, color: AppTheme.appBlack),
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
                                        child: anniversaryValue == null
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
                                    borderRadius: BorderRadius.circular(30.0)),
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
              )),
        ));
  }

  void _hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  _onTapUpdate(BuildContext context) {
    _hideKeyboard();
     if(_nameController.text.isNotEmpty){
       if(_emailController.text.isNotEmpty){
         if(_phoneController.text.isNotEmpty){
         //  _cubit.updateProfile(mobile: _phoneController.text, name: _nameController.text, email: _emailController.text, imageFile: null, dob: birthdaySelectedDate!=null?birthdaySelectedDate.toString():null, anniversary: anniversarySelectedDate, address: address)
         }
       }
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
        anniversaryValue =
            "${(format1.format(anniversarySelectedDate!))} ${strDigits(anniversarySelectedDate!.day)} ${strDigits4(anniversarySelectedDate!.year)}";
      });
    }
  }
}
