
import 'package:flutter/material.dart';
import 'package:vendorapp/ui/main/home/home_screen.dart';
import 'package:vendorapp/ui/main/main.dart';

import '../../../core/core.dart';
import '../../../core/icons/app_icon_keys.g.dart';
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

  @override
  void initState() {
    super.initState();
    currentItem = widget.homeItem;
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
        return const OrderHistoryScreen();
      case HomeItems.myCart:
        return const CartScreen();
      case HomeItems.profile:
        return const ProfileScreen();
      default:
        return const HomeScreen();
    }
  }

  int _getPageIndex() {
    switch (currentItem) {
      case HomeItems.home:
        return 0;
      case HomeItems.orderHistory:
        return 1;
      case HomeItems.myCart:
        return 2;
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
          currentItem = HomeItems.orderHistory;
          break;
        case 2:
          currentItem = HomeItems.myCart;
          break;
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
      context.showToast('Press again to close app');
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
              textTheme: Theme
                  .of(context)
                  .textTheme
                  .copyWith(caption: TextStyle(color:AppTheme.appWhite,))), // sets the inactive color of the `BottomNavigationBar`

          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
        backgroundColor: AppTheme.appRed,
        currentIndex: currentPage,
        elevation: 0.0,
        onTap: onTapItem,
        items: [
          _bottomNavigationBarItem(image: AppIconKeys.homeIcon, text: 'Home'),
          _bottomNavigationBarItem(image: AppIconKeys.payment, text: 'Order History'),
          _bottomNavigationBarItem(image: AppIconKeys.cards, text: 'My Cart'),
          _bottomNavigationBarItem(image: AppIconKeys.placeholder, text: 'Profile'),
        ],
      ),
    );
  }
}

_bottomNavigationBarItem({
  required String image,
  required String text,
}) {
  return BottomNavigationBarItem(
    icon: BottomItemWidget(
      isActive: false,
      image: image, text: text,
    ),
    label: "",
    activeIcon: BottomItemWidget(
      isActive: true,
      image: image, text: text,
    ),
  );
}
