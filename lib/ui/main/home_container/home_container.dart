import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../ui.dart';

class HomeContainer extends StatefulWidget {
  const HomeContainer({
    Key? key,
    this.homeItem = HomeItems.home,
  }) : super(key: key);
  final HomeItems homeItem;

  @override
  State<HomeContainer> createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer> {
  late HomeItems currentItem;
  DateTime? currentBackPressTime;
  bool login = false;
  String cartListString = '';
  @override
  void initState() {
    super.initState();
    currentItem = widget.homeItem;
    userData();
    preference();
  }

  Future<void> userData() async {
    login =await context.read<LocalRepository>().isLoggedIn();
    setState(() {
      login;
    });
    if (kDebugMode) {
      print('is logged  $login');
    }
  }
  Future<void> preference() async {
    cartListString = context.read<LocalRepository>().getCartList();
    setState(() {
      cartListString;
    });
    if (kDebugMode) {
      print('cartListString  $cartListString');
    }
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: _getBody(),
        bottomNavigationBar: _BottomNavigationBar(
          currentPage: _getPageIndex(),
          onTapItem: _mapIndexToItem,
        ),
      ),
    );
  }

  Widget _getBody() {
    switch (currentItem) {
      case HomeItems.home:
        return const HomeScreen();
      case HomeItems.orderHistory:
        if (login != false) {
          return const OrderHistoryScreen(showAppBar: false,);
        } else {
          AlertExtension(context).showSuccessAlert(message: StringConstant.pleaseRegisterLogin,cancelTextButton: StringConstant.no,confirmTextButton: StringConstant.yes,onConfirm: (){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
              builder: (context) {
                return const LoginScreen();
              },
            ), (e) => false);
          }, height: 150, width: MediaQuery.of(context).size.width-40, title: '');
          // showDialog();
          return const HomeScreen();
        }
      case HomeItems.myCart:
      // if(cartListString.isNotEmpty) {
        return const CartScreen();
    // }else{
    //   AlertExtension(context).showCartEmptyAlert(height: 180, width: MediaQuery.of(context).size.width-40, title: '');
    //   return const HomeScreen();
    // }
    // case HomeItems.smartList:
    //   return const SmartListScreen();
      case HomeItems.profile:
        return const ProfileScreen();
      default:
        return const HomeScreen();
    }
  }

  void showDialog() {
    if (kDebugMode) {
      print('username hi');
    }
  }

  int _getPageIndex() {
    switch (currentItem) {
      case HomeItems.home:
        return 0;
      case HomeItems.orderHistory:
        if (login != false) {
          return 1;
        } else {
          return 0;
        }
      case HomeItems.myCart:
      // if(cartListString.isNotEmpty) {
        return 2;
    // }else{
    //   return 0;
    // }
    // case HomeItems.smartList:
    //   return 3;
      case HomeItems.profile:
        return 3;
      default:
        return 0;
    }
  }

  _mapIndexToItem(int index) {
    final int currentIndex = _getPageIndex();
    if (index == currentIndex) return;
    setState(() {
      switch (index) {
        case 0:
          currentItem = HomeItems.home;
          break;
        case 1:
          if (login != false) {
            currentItem = HomeItems.orderHistory;
          } else {
            currentItem = HomeItems.orderHistory;
          }
          break;
        case 2:
        // if(cartListString.isNotEmpty) {
          currentItem = HomeItems.myCart;
          // }else{
          //   currentItem = HomeItems.myCart;
          // }
          break;
      // case 3:
      //   currentItem = HomeItems.smartList;
      //   break;
        case 3:
          currentItem = HomeItems.profile;
          break;
      }
    });
  }

  Future<bool> _onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      context.showToast(StringConstant.pressAgain);
      return Future.value(false);
    }
    return Future.value(true);
  }
}

class _BottomNavigationBar extends StatelessWidget {
  const _BottomNavigationBar({
    required this.currentPage,
    required this.onTapItem,
  });

  final int currentPage;
  final Function(int) onTapItem;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        // sets the background color of the `BottomNavigationBar`
          canvasColor: AppTheme.appRed,
          // sets the active color of the `BottomNavigationBar` if `Brightness` is light
          primaryColor: AppTheme.appRed,
          textTheme: Theme.of(context).textTheme.copyWith(
              caption: TextStyle(
                color: AppTheme.appWhite,
              ))), // sets the inactive color of the `BottomNavigationBar`

      child: BottomNavigationBar(
        selectedFontSize: 5,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppTheme.appRed,
        currentIndex: currentPage,
        elevation: 0.0,
        onTap: onTapItem,
        items: [
          _bottomNavigationBarItem(image: FontAwesome.home, text: StringConstant.home),
          _bottomNavigationBarItem(
              image: FontAwesome.file_text, text: StringConstant.orderHistory),
          _bottomNavigationBarItem(
              image: FontAwesome.shopping_cart, text:StringConstant.myCart),
          // _bottomNavigationBarItem(
          //     image: FontAwesome.list, text: StringConstant.smartList),
          _bottomNavigationBarItem(image: MaterialIcons.person, text: StringConstant.profile),
        ],
      ),
    );
  }
}

_bottomNavigationBarItem({
  required IconData image,
  required String text,
}) {
  return BottomNavigationBarItem(
    icon: BottomItemWidget(
      isActive: false,
      image: image,
      text: text,
    ),
    label: "",
    activeIcon: BottomItemWidget(
      isActive: true,
      image: image,
      text: text,
    ),
  );
}
