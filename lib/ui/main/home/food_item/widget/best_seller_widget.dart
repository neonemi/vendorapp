import 'package:flutter/material.dart';
import 'package:vendorapp/core/core.dart';
import 'package:vendorapp/ui/ui.dart';

class FoodBestSellerList extends StatelessWidget {
  final List<BestSellerData> bestSellerData;
  const FoodBestSellerList({super.key, required this.bestSellerData});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: bestSellerData.length,
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => {},
              child: Container(
                width: 160,
                // height: 210,
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Column(
                mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 150,
                      width: 160,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: AppImageLoader(
                          imageUrl:
                              Apis.imageBaseUrl + bestSellerData[index].image!,
                          boxFit: BoxFit.cover,
                          height: 110,
                          width: 110,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: 160,
                        alignment: Alignment.centerLeft,
                        child: Text(bestSellerData[index].name!,style: TextStyle(color: AppTheme.appBlack,fontSize: 14),),
                      ),
                    ),
                    Container(
                      width: 160,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '₹${bestSellerData[index].price!}',
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
                                    bestSellerData[index].isActive!.toString(),
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
                ),
              ),
            );
          }),
    );
  }
}
