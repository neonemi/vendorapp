import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:vendorapp/core/core.dart';

import '../../../ui.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  AddressScreenState createState() => AddressScreenState();
}

class AddressScreenState extends State<AddressScreen> {
  late final AddressCubit _cubit;
  int selectedIndex = -1;
  // final Map<String, dynamic> addressList = {
  //   "title": ['Work', 'Home'],
  //   "address": [
  //     'Old Ginnani, Bikaner Fort, Bikaner, Rajasthan, India, 334001, Ginnani, 334001',
  //     '322/41, Rambagh, Prayagraj, Uttar Pradesh 211003, India, Near Station, 455611'
  //   ],
  // };
  @override
  void initState() {
    super.initState();
  }

// Nov 18 2022
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return BlocProvider<AddressCubit>(
        create: (context) {
          _cubit = AddressCubit(context.read<CoreRepository>())
            ..getAllAddress();
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
                    StringConstant.myAddresses,
                    style: TextStyle(
                        color: AppTheme.appWhite,
                        fontSize: 20,
                        fontStyle: FontStyle.normal,
                        fontFamily: StringConstant.fontFamily),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              body: Container(
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                            const AddAddressScreen()));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.add,
                                size: 12,
                                color: AppTheme.appRed,
                              ),
                              Text(
                                StringConstant.addAddress,
                                style: TextStyle(
                                    color: AppTheme.appRed,
                                    fontSize: 16,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Divider(
                            color: AppTheme.appGrey,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      StringConstant.savedAddress,
                      style: TextStyle(
                          color: AppTheme.appBlack,
                          fontSize: 14,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500),
                    ),
                    BlocBuilder<AddressCubit, AddressState>(
                        builder: (context, state) {
                          if (state is AddressLoading) {
                            context.loaderOverlay.show();
                          } else {
                            context.loaderOverlay.hide();
                          }
                          if (state is AllAddressSuccess) {
                            GetAllAddressResponse response = state.response;
                            return response.data == null
                                ? const SizedBox.shrink()
                                : response.data!.isEmpty
                                ? const SizedBox.shrink()
                                : ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: response.data!.length,
                                physics: const ClampingScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Container(
                                    alignment: Alignment.topLeft,
                                    width:
                                    MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                              .size
                                              .width,
                                          child: ListTile(
                                            visualDensity:
                                            const VisualDensity(
                                                horizontal: -2,
                                                vertical: -3),
                                            title: Text(
                                              response
                                                  .data![index].address!,
                                              style: TextStyle(
                                                  color: AppTheme.appBlack,
                                                  fontSize: 16,
                                                  fontStyle:
                                                  FontStyle.normal,
                                                  fontWeight:
                                                  FontWeight.w600),
                                            ),
                                            trailing:GestureDetector(
                                              onTap: (){
                                                // setState(() {
                                                //   selectedIndex = index;
                                                // });
                                                _cubit.defaultAddress( addressId:  response
                                                    .data![index].id.toString(), location:response
                                                    .data![index].location!);
                                              },
                                              child: response
                                                  .data![index].isDefault==1?
                                              //selectedIndex == index ?
                                              Image.asset(
                                                AppIconKeys.selected,
                                                height: 20,
                                                width: 20,
                                                color:
                                                AppTheme.appBlack,
                                              )
                                                  : Image.asset(
                                                AppIconKeys.unselected,
                                                height: 20,
                                                width: 20,
                                                color:
                                                AppTheme.appBlack,
                                              ),
                                            ),
                                            // onTap: () {
                                            //
                                            //
                                            // },
                                            subtitle: Text(
                                              response
                                                  .data![index].location!,
                                              style: TextStyle(
                                                color: AppTheme.appBlack,
                                                fontSize: 12,
                                                fontStyle: FontStyle.normal,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                              .size
                                              .width,
                                          margin: const EdgeInsets.only(
                                              left: 15, right: 15),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (BuildContext
                                                          context) =>
                                                          const AddAddressScreen()));
                                                },
                                                child: SizedBox(
                                                  width: 100,
                                                  child: Text(
                                                    StringConstant.edit,
                                                    style: TextStyle(
                                                      color: AppTheme
                                                          .appRed,
                                                      fontSize: 14,
                                                      fontStyle:
                                                      FontStyle.normal,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  _onTapDelete(context,response
                                                      .data![index].id.toString());
                                                  // _cubit.deleteAddress( addressId:  response
                                                  //     .data![index].id.toString());
                                                },
                                                child: SizedBox(
                                                  width: 100,
                                                  child: Text(
                                                    StringConstant.delete,
                                                    style: TextStyle(
                                                      color: AppTheme
                                                          .appRed,
                                                      fontSize: 14,
                                                      fontStyle:
                                                      FontStyle.normal,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          }
                          return const SizedBox.shrink();
                          // ListView.builder(
                          //   scrollDirection: Axis.vertical,
                          //   itemCount: addressList['title'].length,
                          //   physics: const ClampingScrollPhysics(),
                          //   shrinkWrap: true,
                          //   itemBuilder: (context, index) {
                          //     return Container(
                          //       alignment: Alignment.topLeft,
                          //       width: MediaQuery.of(context).size.width,
                          //       margin:
                          //           const EdgeInsets.only(top: 10, bottom: 10),
                          //       child: Column(
                          //         mainAxisAlignment: MainAxisAlignment.start,
                          //         crossAxisAlignment: CrossAxisAlignment.start,
                          //         children: [
                          //           SizedBox(
                          //             width: MediaQuery.of(context).size.width,
                          //             child: ListTile(
                          //               visualDensity: const VisualDensity(
                          //                   horizontal: -2, vertical: -3),
                          //               title: Text(
                          //                 addressList['title'][index],
                          //                 style: TextStyle(
                          //                     color: AppTheme.appBlack,
                          //                     fontSize: 16,
                          //                     fontStyle: FontStyle.normal,
                          //                     fontWeight: FontWeight.w600),
                          //               ),
                          //               trailing: selectedIndex == index
                          //                   ? Image.asset(
                          //                       AppIconKeys.selected,
                          //                       height: 20,
                          //                       width: 20,
                          //                       color: AppTheme.appBlack,
                          //                     )
                          //                   : Image.asset(
                          //                       AppIconKeys.unselected,
                          //                       height: 20,
                          //                       width: 20,
                          //                       color: AppTheme.appBlack,
                          //                     ),
                          //               onTap: () {
                          //                 setState(() {
                          //                   selectedIndex = index;
                          //                 });
                          //               },
                          //               subtitle: Text(
                          //                 addressList['address'][index],
                          //                 style: TextStyle(
                          //                   color: AppTheme.appBlack,
                          //                   fontSize: 12,
                          //                   fontStyle: FontStyle.normal,
                          //                 ),
                          //               ),
                          //             ),
                          //           ),
                          //           Container(
                          //             width: MediaQuery.of(context).size.width,
                          //             margin: const EdgeInsets.only(
                          //                 left: 15, right: 15),
                          //             child: Row(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.start,
                          //               mainAxisSize: MainAxisSize.min,
                          //               children: [
                          //                 GestureDetector(
                          //                   onTap: () {
                          //                     Navigator.of(context).push(
                          //                         MaterialPageRoute(
                          //                             builder: (BuildContext
                          //                                     context) =>
                          //                                 const AddAddressScreen()));
                          //                   },
                          //                   child: SizedBox(
                          //                     width: 100,
                          //                     child: Text(
                          //                       'EDIT',
                          //                       style: TextStyle(
                          //                         color: AppTheme.appYellow,
                          //                         fontSize: 14,
                          //                         fontStyle: FontStyle.normal,
                          //                       ),
                          //                     ),
                          //                   ),
                          //                 ),
                          //                 SizedBox(
                          //                   width: 100,
                          //                   child: Text(
                          //                     'DELETE',
                          //                     style: TextStyle(
                          //                       color: AppTheme.appYellow,
                          //                       fontSize: 14,
                          //                       fontStyle: FontStyle.normal,
                          //                     ),
                          //                   ),
                          //                 ),
                          //               ],
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //     );
                          //   });
                        }),
                  ],
                ),
              ),
            )));
  }
  _onTapDelete(BuildContext context,String id) {
    AlertExtension(context).showSuccessAlert(
        message: StringConstant.areYouSureYouWantToDeleteAddress,
        cancelTextButton: StringConstant.no,
        confirmTextButton: StringConstant.yes,
        onConfirm: () {
          _cubit.deleteAddress( addressId:  id);
        },
        height: 150,
        width: MediaQuery.of(context).size.width - 40, title: '');
  }
}
