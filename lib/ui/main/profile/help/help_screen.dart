import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vendorapp/core/core.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  HelpScreenState createState() => HelpScreenState();
}

class HelpScreenState extends State<HelpScreen> {
  bool manageOrder = true;
  bool returnRefund = true;
  bool transaction = true;
  bool other = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.appRed,
          iconTheme: IconThemeData(color: AppTheme.appWhite),
          centerTitle: true,
          title: Container(
            margin: const EdgeInsets.only(right: 40),
            height: 50,
            alignment: Alignment.center,
            child: Text(
              'Help',
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
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: ListView(
            children: [
              Image.asset(
                AppIconKeys.helpImage,
                height: 120,
                width: 120,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Help Centre',
                style: TextStyle(
                    color: AppTheme.appBlack,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Please get in touch and we will be happy to help you',
                style: TextStyle(color: AppTheme.appBlack, fontSize: 10),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                height: 1,
                thickness: 1,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Welcome to the help centre. Munda Snacks and Foods is serving its customers, We value our customer above all.\nIf you are facing any problem, you can contact us directly on customer care number given below:',
                style: TextStyle(color: AppTheme.appBlack, fontSize: 14),
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'You can call us',
                style: TextStyle(
                    color: AppTheme.appBlack,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              Text(
                '(9:00 AM to 7:00 PM)',
                style: TextStyle(color: AppTheme.appBlack, fontSize: 10),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.local_hospital_outlined,
                    color: AppTheme.appGrey,
                  ),
                  Text(
                    '+91 730940 02814',
                    style: TextStyle(
                        color: AppTheme.appBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_on_sharp,
                    color: AppTheme.appGrey,
                  ),
                  Text(
                    'Kareli, Dariyabad',
                    style: TextStyle(
                        color: AppTheme.appBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                height: 1,
                thickness: 1,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Customer Service',
                style: TextStyle(
                    color: AppTheme.appBlack,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.left,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    manageOrder = !manageOrder;
                    other = true;
                    returnRefund = true;
                    transaction = true;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Manage Orders',
                      style: TextStyle(
                          color: AppTheme.appBlack,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.justify,
                    ),
                    Visibility(
                      visible: manageOrder,
                      replacement: const Icon(Icons.keyboard_arrow_up_outlined),
                      child: const Icon(Icons.keyboard_arrow_down_outlined),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Visibility(
                  visible: !manageOrder,
                  child: Text(
                    'All of your orders have been stored under "My Orders" section. The orders have been categorised under 3 sections namely completed, pending & cancelled. You can repeat any order by clicking icon given in front of them. The order list also help you find a particular product, which you ordered earlier, liked it but forget its name.',
                    style: TextStyle(
                        color: AppTheme.appBlack,
                        fontSize: 12,
                        fontFamily: 'Montserrat'),
                    textAlign: TextAlign.justify,
                  )),
              Visibility(
                visible: !manageOrder,
                child: const SizedBox(
                  height: 10,
                ),
              ),
              const Divider(
                height: 1,
                thickness: 1,
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    returnRefund = !returnRefund;
                    other = true;
                    manageOrder = true;
                    transaction = true;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Returns & Refunds',
                      style: TextStyle(
                          color: AppTheme.appBlack,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.justify,
                    ),
                    Visibility(
                      visible: returnRefund,
                      replacement: const Icon(Icons.keyboard_arrow_up_outlined),
                      child: const Icon(Icons.keyboard_arrow_down_outlined),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Visibility(
                  visible: !returnRefund,
                  child: Text(
                    'Once a order has been placed by the customer & received by Munda Snacks & Foods and accepted, It directly goes to kitchen to either cooked freshly or for being packed. As food is fresh in nature, we can not cancel the order once it has been gone into cooking.',
                    style: TextStyle(
                        color: AppTheme.appBlack,
                        fontSize: 12,
                        fontFamily: 'Montserrat'),
                    textAlign: TextAlign.justify,
                  )),
              Visibility(
                visible: !returnRefund,
                child: const SizedBox(
                  height: 10,
                ),
              ),
              const Divider(
                height: 1,
                thickness: 1,
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    transaction = !transaction;
                    other = true;
                    manageOrder = true;
                    returnRefund = true;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Transaction',
                      style: TextStyle(
                          color: AppTheme.appBlack,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.justify,
                    ),
                    Visibility(
                      visible: transaction,
                      replacement: const Icon(Icons.keyboard_arrow_up_outlined),
                      child: const Icon(Icons.keyboard_arrow_down_outlined),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Visibility(
                  visible: !transaction,
                  child: Text(
                    'You need to pay online to place the order. You can contact us with provided helpline number to cancel the order before it cooked',
                    style: TextStyle(
                        color: AppTheme.appBlack,
                        fontSize: 12,
                        fontFamily: 'Montserrat'),
                    textAlign: TextAlign.justify,
                  )),
              Visibility(
                visible: !transaction,
                child: const SizedBox(
                  height: 10,
                ),
              ),
              const Divider(
                height: 1,
                thickness: 1,
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    other = !other;
                    transaction = true;
                    manageOrder = true;
                    returnRefund = true;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Other',
                      style: TextStyle(
                          color: AppTheme.appBlack,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.justify,
                    ),
                    Visibility(
                      visible: other,
                      replacement: const Icon(Icons.keyboard_arrow_up_outlined),
                      child: const Icon(Icons.keyboard_arrow_down_outlined),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Visibility(
                  visible: !other,
                  child: Text(
                    'Contact on the helpline number for any other query not covered in this section between 9am to 7pm.',
                    style: TextStyle(
                        color: AppTheme.appBlack,
                        fontSize: 12,
                        fontFamily: 'Montserrat'),
                    textAlign: TextAlign.justify,
                  )),
              Visibility(
                visible: !other,
                child: const SizedBox(
                  height: 10,
                ),
              ),
              const Divider(
                height: 1,
                thickness: 1,
              ),
            ],
          ),
        ));
  }
}
