import 'package:flutter/material.dart';

import '../../../../../core/core.dart';
import '../../../../ui.dart';

class FoodAllProductScreen extends StatelessWidget {
  final List<ProductListData> productData;
  const FoodAllProductScreen({super.key, required this.productData});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
     // scrollDirection: Axis.vertical,
      itemCount: productData.length,
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => {},
          child: Container(
              width: 160,
               // height: 300,
             // margin: const EdgeInsets.fromLTRB(10, 10, 10, 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    //height: 150,
                    width: 160,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: AppImageLoader(
                        imageUrl: Apis.imageBaseUrl + productData[index].image!,
                        boxFit: BoxFit.cover,
                        height: 100,
                        width: 120,
                      ),
                    ),
                  ),
                  Container(
                    width: 160,
                    alignment: Alignment.centerLeft,
                    child: Text(productData[index].name!,style: TextStyle(color: AppTheme.appBlack,fontSize: 14),),
                  ),
                  Container(
                    width: 160,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '₹${productData[index].price!}',
                              style: TextStyle(
                                  color: AppTheme.appRed,
                                  fontWeight: FontWeight.w600,fontSize: 14),
                            )),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                                height: 20,width: 20,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: AppTheme.appRed
                                ),
                                child: Icon(Icons.remove,color: AppTheme.appBlack,size: 15,)
                            ),
                            const SizedBox(width: 5,),
                            Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  productData[index].isActive!.toString(),
                                  style: TextStyle(
                                      color: AppTheme.appRed,
                                      fontWeight: FontWeight.w600),
                                )),
                            const SizedBox(width: 5,),
                            Container(
                                height: 20,width: 20,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: AppTheme.appRed
                                ),
                                child: Icon(Icons.add,color: AppTheme.appBlack,size: 15,)
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ],
              )),
        );
      },
    );
  }
}
