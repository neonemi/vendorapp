
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../../core/core.dart';
import '../../ui.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  String userName= 'Guest';
  String userEmail= '';
  @override
  void initState() {
    super.initState();
    userData();
  }
  void userData(){
    userName = context.read<LocalRepository>().getUserName();
    if(userName.isEmpty){
      userName ='Guest';
    }
    setState(() {
      userName;
    });
    print('username $userName');
  }
  @override
  Widget build(BuildContext context) {
    return
      SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: Colors.red,
              height: MediaQuery.of(context).size.height * 1 / 3,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: Container(
                margin: const EdgeInsets.only(left: 10,right: 10),
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        child: Text('Profile',style: TextStyle(color: AppTheme.appWhite,fontSize: 18))),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap:(){
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                  const UpdateProfileScreen()));
                    },
                            child: Image.asset(
                              AppIconKeys.userPlaceholder,
                              height: 100,
                              width: 100,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    width: 200,
                                    child: Text(userName,style: TextStyle(color: AppTheme.appWhite,fontSize: 18,fontWeight: FontWeight.w600),)),
                                if(userName!='Guest')
                                Container(
                                  width: 200,
                                    child: Text(userEmail,style: TextStyle(color: AppTheme.appWhite,fontSize: 14)))
                              ]
                            ),
                          )
                        ],
                      ),
                    ),
                 // if(userName!='Guest')
                  GestureDetector(
                    onTap:(){
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                          const UpdateProfileScreen()));
                    },
                      child: Text('Edit',style: TextStyle(color: AppTheme.appWhite,fontSize: 14)))
                  ],
                ),
              ),
            ),
            ListBody(
              children: [
              //  if(userName!='Guest')
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

                  },
                ),
               // if(userName!='Guest')
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
                  onTap: () {

                  },
                ),
                //if(userName!='Guest')
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
                        builder: (BuildContext context) =>
                         PrivacyScreen(url: Apis.menuUrl, heading: "Menu",)));

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
               // if(userName!='Guest')
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
                //if(userName=='Guest')
                ListTile(
                  visualDensity:
                  const VisualDensity(horizontal: 0, vertical: -2),
                  leading: Icon(
                    Icons.logout,
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
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
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
      //const Center(child: Text("profile",style: TextStyle(color: Colors.red),));
  }

  _onTapLogout(BuildContext context){
    AlertExtension(context).showSuccessAlert(message: 'Are you sure, you want to logout?',cancelTextButton: 'NO',confirmTextButton: 'YES',onConfirm: (){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
        builder: (context) {
          return const LoginScreen();
        },
      ), (e) => false);
    }, height: 150, width: MediaQuery.of(context).size.width-40);
  }
}
