import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class FoodDetailsScreen extends StatefulWidget {
  final int orderId;
  final int productId;
  final int unitPrice;
  final int quantity;
  final int price;
  final int id;
  final String nameProduct;
  final String imageProduct;
  final String unitqty;
  final String unitqtyname;
  final String categoryName;
  const FoodDetailsScreen({
    super.key,
    required this.id,
    required this.orderId,
    required this.unitPrice,
    required this.price,
    required this.quantity,
    required this.productId,
    required this.nameProduct,
    required this.imageProduct,
    required this.unitqty,
    required this.unitqtyname,
    required this.categoryName,
  });

  @override
  State<FoodDetailsScreen> createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen> {
  int? orderId;
  int? productId;
  int? unitPrice;
  int? quantity;
  int? price;
  int? id;
  String? nameProduct;
  String? imageProduct;
  String? unitqty;
  String? unitqtyname;
  String? categoryName;
  @override
  void initState() {
    super.initState();

    orderId = widget.orderId;
    productId = widget.productId;
    unitPrice = widget.unitPrice;
    quantity = widget.quantity;
    price = widget.price;
    id = widget.id;
    nameProduct = widget.nameProduct;
    imageProduct = widget.imageProduct;
    unitqty = widget.unitqty;
    unitqtyname = widget.unitqtyname;
    categoryName=widget.categoryName;
    if (kDebugMode) {
      print(orderId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              'Detail',
              style: TextStyle(
                  color: AppTheme.appWhite,
                  fontSize: 20,
                  fontStyle: FontStyle.normal,
                  fontFamily: "Montserrat"),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        body: Stack(
          children: [
            Container(
              color: AppTheme.appRed,
              height: MediaQuery.of(context).size.height * 1 / 4,
              width: MediaQuery.of(context).size.width,
              child: Text('$categoryName',style: TextStyle(color: AppTheme.appWhite,
                  fontSize: 20,
                  fontStyle: FontStyle.normal,
                  fontFamily: "Montserrat",),textAlign: TextAlign.center,),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 1 / 12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: NetworkImage(
                          Apis.imageBaseUrl + imageProduct!,
                        ),
                        fit: BoxFit.cover,
                      )),
                  width: MediaQuery.of(context).size.width * 2 / 3,
                  height: MediaQuery.of(context).size.width * 2 / 3,
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 1 / 12 +
                      MediaQuery.of(context).size.width * 2 / 3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: AppTheme.appRed,
                          elevation: 3,
                          padding: const EdgeInsets.all(4),
                          alignment: Alignment.center,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0.0)),
                          // fixedSize: const Size(150, 52),
                          //////// HERE
                        ),
                        onPressed: () {

                        },
                        child: Text(
                          "ADD",
                          style:
                              TextStyle(fontSize: 16, color: AppTheme.appBlack),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Text(
                        '$nameProduct ( $unitqty $unitqtyname)',
                        style: TextStyle(
                            color: AppTheme.appBlack,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      )),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: Text(
                        '$nameProduct',
                        style:
                            TextStyle(color: AppTheme.appBlack, fontSize: 14),
                      )),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: Text(
                        '₹$price',
                        style: TextStyle(
                            color: AppTheme.appRed,
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                      )),
                ],
              ),
            ),
            // Container(
            //   margin: EdgeInsets.only(top:MediaQuery.of(context).size.height * 1 /10 +MediaQuery.of(context).size.height * 1 /3 ),
            //   child: Text('${nameProduct}'),
            // )
          ],
        ));
    //const Center(child: Text("profile",style: TextStyle(color: Colors.red),));
  }
}
