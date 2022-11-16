
import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../ui.dart';

class HomeHorizontalList extends StatelessWidget {
 final List<BannerData> bannerData;
  const HomeHorizontalList({super.key,required this.bannerData});


  @override
  Widget build(BuildContext context) {
   return Container(
     height: 200,
     alignment: Alignment.center,
     child: ListView.builder(
         scrollDirection: Axis.horizontal,
         itemCount: bannerData.length,
         physics: const AlwaysScrollableScrollPhysics(),
         itemBuilder: (context, index) {
           return GestureDetector(
             onTap: () => {},
             child: Container(
               width:
               MediaQuery.of(context).size.width - 20,
               height: 200,
               margin: const EdgeInsets.fromLTRB(
                   0, 0, 10, 10),
               child: AppImageLoader(
                 imageUrl:Apis.imageBaseUrl+bannerData[index].image!,boxFit: BoxFit.cover,
                 height: 190, width: MediaQuery.of(context).size.width - 20,),
             ),
           );
         }),
   );
  }




}