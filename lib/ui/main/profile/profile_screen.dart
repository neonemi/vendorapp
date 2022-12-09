import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../core/core.dart';
import '../../ui.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final ProfileCubit _cubit;
  String userName = 'Guest';
  String userEmail = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (context) {
        _cubit = ProfileCubit(context.read<CoreRepository>());
        _cubit.loadData();
        return _cubit;
      },
      child: BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLoading) {
            context.loaderOverlay.show();
          } else {
            context.loaderOverlay.hide();
          }
          if (state is ProfileLogoutSuccess) {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
              builder: (context) {
                return const LoginScreen();
              },
            ), (e) => false);
          }
          if (state is ProfileError) {
            context.showToast(state.message);
          }
        },
        child:
            BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
          if (state is ProfileSuccess) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: AppTheme.appRed,
                centerTitle: true,
                elevation: 0.0,
                iconTheme: IconThemeData(color: AppTheme.appWhite),
                title: Container(
                  height: 50,
                  alignment: Alignment.center,
                  child: Text(
                    'Profile',
                    style: TextStyle(
                        color: AppTheme.appWhite,
                        fontSize: 20,
                        fontStyle: FontStyle.normal,
                        fontFamily: "Montserrat"),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              body: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      color: AppTheme.appRed,
                      height: MediaQuery.of(context).size.height * 1 / 4,
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  const UpdateProfileScreen()));
                                    },
                                    child:state.image.isEmpty? Image.asset(
                                      AppIconKeys.userPlaceholder,
                                      height: 100,
                                      width: 100,
                                    ):SizedBox(
                                        height: 100,
                                        width: 100,
                                        child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(50),child:Image.network(Apis.imageBaseUrl+state.image,fit: BoxFit.cover,))),
                                  ),
                                  Container(
                                    margin:
                                        const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                              width: 200,
                                              child: Text(
                                                state.userName,
                                                style: TextStyle(
                                                    color: AppTheme.appWhite,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600),
                                              )),
                                          SizedBox(
                                              width: 200,
                                              child: Text(state.email,
                                                  style: TextStyle(
                                                      color: AppTheme.appWhite,
                                                      fontSize: 14)))
                                        ]),
                                  )
                                ],
                              ),
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const UpdateProfileScreen()));
                                },
                                child: Text('Edit',
                                    style: TextStyle(
                                        color: AppTheme.appWhite, fontSize: 14)))
                          ],
                        ),
                      ),
                    ),
                    ListBody(
                      children: [
                        ListTile(
                          visualDensity:
                              const VisualDensity(horizontal: 0, vertical: -2),
                          leading: Icon(
                            Icons.card_travel,
                            color: AppTheme.appBlack,
                            size: 22,
                          ),
                          title: Text(
                            'Your Orders',
                            style: TextStyle(
                                fontSize: 16,
                                color: AppTheme.appBlack,
                                fontFamily: 'Montserrat'),
                            textAlign: TextAlign.start,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_sharp,
                            color: AppTheme.appBlack,
                            size: 22,
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                    const OrderHistoryScreen(showAppBar: true,)));
                          },
                        ),
                        ListTile(
                          visualDensity:
                              const VisualDensity(horizontal: 0, vertical: -2),
                          leading: Icon(
                            Icons.notifications_rounded,
                            color: AppTheme.appBlack,
                            size: 22,
                          ),
                          title: Text(
                            'Notifications',
                            style: TextStyle(
                                fontSize: 16,
                                color: AppTheme.appBlack,
                                fontFamily: 'Montserrat'),
                            textAlign: TextAlign.start,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_sharp,
                            color: AppTheme.appBlack,
                            size: 22,
                          ),
                          onTap: () {},
                        ),
                        ListTile(
                          visualDensity:
                              const VisualDensity(horizontal: 0, vertical: -2),
                          leading: Icon(
                            Icons.location_on_sharp,
                            color: AppTheme.appBlack,
                            size: 22,
                          ),
                          title: Text(
                            'Address',
                            style: TextStyle(
                                fontSize: 16,
                                color: AppTheme.appBlack,
                                fontFamily: 'Montserrat'),
                            textAlign: TextAlign.start,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_sharp,
                            color: AppTheme.appBlack,
                            size: 22,
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                const AddressScreen()));
                          },
                        ),
                        ListTile(
                          visualDensity:
                              const VisualDensity(horizontal: 0, vertical: -2),
                          leading: Icon(
                            Icons.menu_book,
                            color: AppTheme.appBlack,
                            size: 22,
                          ),
                          title: Text(
                            'Menu',
                            style: TextStyle(
                                fontSize: 16,
                                color: AppTheme.appBlack,
                                fontFamily: 'Montserrat'),
                            textAlign: TextAlign.start,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_sharp,
                            color: AppTheme.appBlack,
                            size: 22,
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) => PrivacyScreen(
                                      url: Apis.menuUrl,
                                      heading: "Menu",
                                    )));
                          },
                        ),
                        ListTile(
                          visualDensity:
                              const VisualDensity(horizontal: 0, vertical: -2),
                          leading: Icon(
                            Icons.help,
                            color: AppTheme.appBlack,
                            size: 22,
                          ),
                          title: Text(
                            'Help',
                            style: TextStyle(
                                fontSize: 16,
                                color: AppTheme.appBlack,
                                fontFamily: 'Montserrat'),
                            textAlign: TextAlign.start,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_sharp,
                            color: AppTheme.appBlack,
                            size: 22,
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const HelpScreen()));
                          },
                        ),
                        ListTile(
                          visualDensity:
                              const VisualDensity(horizontal: 0, vertical: -2),
                          leading: Icon(
                            Icons.logout,
                            color: AppTheme.appBlack,
                            size: 22,
                          ),
                          title: Text(
                            'Logout',
                            style: TextStyle(
                                fontSize: 16,
                                color: AppTheme.appBlack,
                                fontFamily: 'Montserrat'),
                            textAlign: TextAlign.start,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_sharp,
                            color: AppTheme.appBlack,
                            size: 22,
                          ),
                          onTap: () {
                            _onTapLogout(context);
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          }
          if (state is ProfileGuestSuccess) {
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                children: [
                  Container(
                    color: Colors.red,
                    height: MediaQuery.of(context).size.height * 1 / 3,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    child: Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.center,
                              child: Text('Profile',
                                  style: TextStyle(
                                      color: AppTheme.appWhite, fontSize: 18))),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  AppIconKeys.userPlaceholder,
                                  height: 100,
                                  width: 100,
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                            width: 200,
                                            child: Text(
                                              state.userName,
                                              style: TextStyle(
                                                  color: AppTheme.appWhite,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600),
                                            )),
                                      ]),
                                )
                              ],
                            ),
                          ),

                               ],
                      ),
                    ),
                  ),
                  ListBody(
                    children: [
                      ListTile(
                        visualDensity:
                            const VisualDensity(horizontal: 0, vertical: -2),
                        leading: Icon(
                          Icons.menu_book,
                          color: AppTheme.appBlack,
                          size: 22,
                        ),
                        title: Text(
                          'Menu',
                          style: TextStyle(
                              fontSize: 16,
                              color: AppTheme.appBlack,
                              fontFamily: 'Montserrat'),
                          textAlign: TextAlign.start,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_sharp,
                          color: AppTheme.appBlack,
                          size: 22,
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => PrivacyScreen(
                                    url: Apis.menuUrl,
                                    heading: "Menu",
                                  )));
                        },
                      ),
                      ListTile(
                        visualDensity:
                            const VisualDensity(horizontal: 0, vertical: -2),
                        leading: Icon(
                          Icons.help,
                          color: AppTheme.appBlack,
                          size: 22,
                        ),
                        title: Text(
                          'Help',
                          style: TextStyle(
                              fontSize: 16,
                              color: AppTheme.appBlack,
                              fontFamily: 'Montserrat'),
                          textAlign: TextAlign.start,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_sharp,
                          color: AppTheme.appBlack,
                          size: 22,
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const HelpScreen()));
                        },
                      ),
                      ListTile(
                        visualDensity:
                            const VisualDensity(horizontal: 0, vertical: -2),
                        leading: Icon(
                          Icons.login,
                          color: AppTheme.appBlack,
                          size: 22,
                        ),
                        title: Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 16,
                              color: AppTheme.appBlack,
                              fontFamily: 'Montserrat'),
                          textAlign: TextAlign.start,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_sharp,
                          color: AppTheme.appBlack,
                          size: 22,
                        ),
                        onTap: () {
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(
                            builder: (context) {
                              return const LoginScreen();
                            },
                          ), (e) => false);
                        },
                      ),
                    ],
                  )
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        }),
      ),
    );
    //const Center(child: Text("profile",style: TextStyle(color: Colors.red),));
  }

  _onTapLogout(BuildContext context) {
    AlertExtension(context).showSuccessAlert(
        message: 'Are you sure, you want to logout?',
        cancelTextButton: 'NO',
        confirmTextButton: 'YES',
        onConfirm: () {
         _cubit.logout();
        },
        height: 150,
        width: MediaQuery.of(context).size.width - 40);
  }
}
