import 'package:flutter/material.dart';
import 'package:vendorapp/core/core.dart';

class SortDialogBuilder {
  SortDialogBuilder(
      this.context,
      );

  final BuildContext context;

  TextEditingController commentController = TextEditingController();

  final List<Map<String, dynamic>> sortingList = [
  {"sort": [
    'PRICE LOW TO HIGH',
    'PRICE HIGH TO LOW'
  ],
    "value":[
      'asc',
      'dsc'
    ],
    "select":[
      false,
      false
    ]
  }];
  showSortDialog(BuildContext context, final void Function(String)? onConfirm) {
    var dialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      backgroundColor: AppTheme.appRed,
      insetPadding: const EdgeInsets.only(top: 60),
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: MediaQuery.of(context).size.width-20,
        child: StatefulBuilder(builder: (context, setState) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: sortingList[0]["sort"].length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      trailing:sortingList[0]["select"][index] != true
                          ? Image.asset(AppIconKeys.unselected,
                          height: 20,
                          width: 20,)
                          : Image.asset(AppIconKeys.selected,
                          height: 20,
                          width: 20,
                         ),
                      title: Text(
                        sortingList[0]["sort"][index],
                        style: TextStyle(
                            color: AppTheme.appWhite,
                            fontSize: 16),
                        textAlign: TextAlign.start,
                      ),
                      onTap: () {
                          setState((){
                            sortingList[0]["select"][index]=!sortingList[0]["select"][index];
                          });
                       onConfirm!(sortingList[0]["value"][index]);
                          Navigator.pop(context);
                      },
                    ),
                  ],
                );
              },
            );
          }
        )
      ),
    );
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) => dialog);
  }
}