
import 'package:flutter/material.dart';

import '../../../core/core.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.appWhite,
        centerTitle: true,
        elevation: 0.0,
        title: Container(
          margin: const EdgeInsets.only(right: 40),
          height: 50,
          alignment: Alignment.center,
          child: Text(
            'My Orders',
            style: TextStyle(
                color: AppTheme.appBlack,
                fontSize: 20,
                fontStyle: FontStyle.normal,
                fontFamily: "Montserrat"),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: ListView(

      ),
    );
      //const Center(child: Text("order",style: TextStyle(color: Colors.red),));
  }
}
