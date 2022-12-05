import 'package:flutter/material.dart';
import 'package:vendorapp/core/core.dart';

class SortDialogBuilder {
  SortDialogBuilder(
      this.context,
      );

  final BuildContext context;
  bool selected = false;

  TextEditingController commentController = TextEditingController();
  showSortDialog(BuildContext context, final void Function(String)? onConfirm) {
    Dialog dialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      backgroundColor: AppTheme.appRed,
      child: Container(
        height: 180,
        width: 250,
        alignment: Alignment.center,
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
            // height:250,
            // width: 250,
            alignment: Alignment.center,
            //margin: EdgeInsets.fromLTRB(0,10,0,10),
             child: Column(
               children: [
                 ListTile(
                   leading:selected != true
                       ? Image.asset(AppIconKeys.unselected,
                       height: 20,
                       width: 20,)
                       : Image.asset(AppIconKeys.selected,
                       height: 20,
                       width: 20,
                      ),
                   title: Text(
                     "PRICE LOW TO HIGH",
                     style: TextStyle(
                         color: AppTheme.appWhite,
                         fontSize: 16),
                     textAlign: TextAlign.start,
                   ),
                   onTap: () {

                       selected=true;

                   },
                 ),
                 ListTile(
                   leading:selected != true
                       ? Image.asset(AppIconKeys.unselected,
                     height: 20,
                     width: 20,)
                       : Image.asset(AppIconKeys.selected,
                     height: 20,
                     width: 20,
                   ),
                   title: Text(
                     "PRICE HIGH TO LOW",
                     style: TextStyle(
                         color: AppTheme.appWhite,
                         fontSize: 16),
                     textAlign: TextAlign.start,
                   ),
                   onTap: () {

                     selected=true;

                   },
                 ),
               ],
             ),
        )
      ),
    );
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) => dialog);
  }
}