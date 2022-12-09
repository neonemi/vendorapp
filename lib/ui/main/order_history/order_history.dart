
import 'package:flutter/material.dart';

import '../../../core/core.dart';

class OrderHistoryScreen extends StatefulWidget {
  final bool showAppBar;
  const OrderHistoryScreen({super.key,required this.showAppBar});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      appBar: widget.showAppBar==true?AppBar(
        backgroundColor: AppTheme.appRed,
        centerTitle: true,
        elevation: 0.0,
        iconTheme: IconThemeData(color: AppTheme.appWhite),
        title: Container(
          margin: const EdgeInsets.only(right: 40),
          height: 50,
          alignment: Alignment.center,
          child: Text(
            'My Orders',
            style: TextStyle(
                color: AppTheme.appWhite,
                fontSize: 20,
                fontStyle: FontStyle.normal,
                fontFamily: "Montserrat"),
            textAlign: TextAlign.center,
          ),
        ),
      ):null,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          shrinkWrap: true,
            children: [
              if(widget.showAppBar==false)
              Container(
                 margin: const EdgeInsets.only(top: 10,bottom: 10),
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
              Container(
              margin: widget.showAppBar==true? const EdgeInsets.only(top: 10,bottom: 10):null,
                child: Text(
                  'We are early waiting for your first order',
                  style: TextStyle(
                      color: AppTheme.appBlack,
                      fontSize: 14,
                      fontStyle: FontStyle.normal,
                      fontFamily: "Montserrat"),
                  textAlign: TextAlign.center,
                ),
              ),
              ListBody(
                children: [

                ],
              )
            ],
        ),
      ),
    );
      //const Center(child: Text("order",style: TextStyle(color: Colors.red),));
  }
}
