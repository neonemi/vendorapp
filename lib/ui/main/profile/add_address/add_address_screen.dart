import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'package:vendorapp/core/core.dart';

import '../../../ui.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({Key? key}) : super(key: key);

  @override
  AddAddressScreenState createState() => AddAddressScreenState();
}

class AddAddressScreenState extends State<AddAddressScreen> {
  late final AddressCubit _cubit;
  Position? location;
  String _titleController = "";
  String _landMarkController = "";
  String _floorController = "";
  String _pinController = "";
  String locationValue = "";
  String latValue = "";
  String longValue = "";
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  double fontSize = 14.0;
  @override
  void initState() {
    super.initState();
    locationFunction();
  }

  Future<void> locationFunction() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    debugPrint('location: ${position.latitude}');
    setState(() {
      location = position;
    });
    if (location != null) {
      List<Placemark> addresses = await placemarkFromCoordinates(
          location!.latitude ?? 0.0, location!.longitude ?? 0.0);

      var first = addresses.first;
      var currentLocationValue =
          "${first.name} ${first.subLocality} ${first.locality} ${first.administrativeArea} ${first.country} ${first.postalCode}";

      setState(() {
        locationValue = currentLocationValue;
        latValue = location!.latitude.toString();
        longValue = location!.longitude.toString();
      });
    }
    print('result push location: $location');
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return BlocProvider<AddressCubit>(
        create: (context) {
          _cubit = AddressCubit(context.read<CoreRepository>());
          // _cubit.getProfile();
          return _cubit;
        },
        child: BlocListener<AddressCubit, AddressState>(
            listener: (context, state) {
              if (state is AddressLoading) {
                context.loaderOverlay.show();
              } else {
                context.loaderOverlay.hide();
              }

              if (state is AddressError) {
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
                    'My Address',
                    style: TextStyle(
                        color: AppTheme.appWhite,
                        fontSize: 20,
                        fontStyle: FontStyle.normal,
                        fontFamily: "Montserrat"),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              body: Container(
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Form(
                  key: _formkey,
                  child: ListView(
                    children: [
                      Text(
                        'Title(Home, Work....)',
                        style: TextStyle(
                            color: AppTheme.appBlack,
                            fontSize: 16,
                            fontStyle: FontStyle.normal),
                      ),
                      SizedBox(
                        height: 30,
                        width: MediaQuery.of(context).size.width,
                        child: TextFormField(
                          style: TextStyle(
                              fontSize: fontSize, color: AppTheme.appBlack),
                          decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              counterStyle: TextStyle(
                                height: double.minPositive,
                              ),
                              counterText: ""),
                          onChanged: (email) {
                            _titleController = email;
                          },
                          initialValue: _titleController,
                          maxLength: 200,
                          // controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.singleLineFormatter
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: Text(
                          'Your Location',
                          style: TextStyle(
                              color: AppTheme.appBlack,
                              fontSize: 16,
                              fontStyle: FontStyle.normal),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _navigationPush(context);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 10),
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: locationValue.isEmpty
                                        ? Text(
                                            "",
                                            style: TextStyle(
                                                fontSize: fontSize,
                                                color: AppTheme.appGrey),
                                          )
                                        : Text(
                                            locationValue.toString(),
                                            style: TextStyle(
                                                fontSize: fontSize,
                                                color: AppTheme.appBlack),
                                          ),
                                  ),
                                  Icon(
                                    Icons.pin_drop,
                                    size: 28,
                                    color: AppTheme.appGrey,
                                  )
                                ],
                              ),
                              const Divider(
                                height: 1,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                      ),
                      Text(
                        'Landmark',
                        style: TextStyle(
                            color: AppTheme.appBlack,
                            fontSize: 16,
                            fontStyle: FontStyle.normal),
                      ),
                      SizedBox(
                        height: 30,
                        width: MediaQuery.of(context).size.width,
                        child: TextFormField(
                          style: TextStyle(
                              fontSize: fontSize, color: AppTheme.appBlack),
                          decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              counterStyle: TextStyle(
                                height: double.minPositive,
                              ),
                              counterText: ""),
                          onChanged: (landmark) {
                            _landMarkController = landmark;
                          },
                          initialValue: _landMarkController,
                          maxLength: 200,
                          // controller: _emailController,
                          keyboardType: TextInputType.text,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.singleLineFormatter
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: Text(
                          'Floor(Optional)',
                          style: TextStyle(
                              color: AppTheme.appBlack,
                              fontSize: 16,
                              fontStyle: FontStyle.normal),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        width: MediaQuery.of(context).size.width,
                        child: TextFormField(
                          style: TextStyle(
                              fontSize: fontSize, color: AppTheme.appBlack),
                          decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              counterStyle: TextStyle(
                                height: double.minPositive,
                              ),
                              counterText: ""),
                          onChanged: (landmark) {
                            _floorController = landmark;
                          },
                          initialValue: _floorController,
                          maxLength: 200,
                          // controller: _emailController,
                          keyboardType: TextInputType.text,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.singleLineFormatter
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: Text(
                          'Pincode',
                          style: TextStyle(
                              color: AppTheme.appBlack,
                              fontSize: 16,
                              fontStyle: FontStyle.normal),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        width: MediaQuery.of(context).size.width,
                        child: TextFormField(
                          style: TextStyle(
                              fontSize: fontSize, color: AppTheme.appBlack),
                          decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              counterStyle: TextStyle(
                                height: double.minPositive,
                              ),
                              counterText: ""),
                          onChanged: (landmark) {
                            _pinController = landmark;
                          },
                          initialValue: _pinController,
                          maxLength: 200,
                          // controller: _emailController,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.singleLineFormatter
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: AppTheme.appRed,
                                elevation: 3,
                                alignment: Alignment.center,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0)),
                                // fixedSize: const Size(150, 52),
                                //////// HERE
                              ),
                              onPressed: () => _onTapSave(context),
                              child: Text(
                                "Save Address",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.appWhite),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }

  _onTapSave(context) {
    if(_titleController.isNotEmpty) {
      if(locationValue.isNotEmpty && latValue.isNotEmpty && longValue.isNotEmpty){
          if(_landMarkController.isNotEmpty){
            if(_pinController.isNotEmpty){
              _cubit.addAddress(
                  address: _titleController,
                  location: locationValue,
                  lat: latValue,
                  lng: longValue,
                  floor: _floorController,
                  landmark: _landMarkController,
                  pincode: _pinController);
            }else{
              context.showToast("Please enter pin code");
            }
          }else{
            context.showToast("Please enter landmark");
          }
      }else{
        context.showToast("Please enter location");
      }
    }else{
      context.showToast("Please enter title");
    }
  }

  Future<void> _navigationPush(BuildContext context) async {
    var result = await Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (BuildContext context) => const SearchLocationScreen()))
        .then((value) {});

    if (result == null) {
      locationFunction();
    }

  }
}
