import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:vendorapp/core/core.dart';

extension AlertExtension on BuildContext {

  showSuccessAlert({
    required String message,
    required String title,
    final void Function()? onConfirm,
    String? confirmTextButton,
    String? cancelTextButton,
    required double height,
    required double width
  }) {
    SmartDialog.show(builder: (context) {
      return Container(
        height: height,
        width: width,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child:Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Container(
                  padding: const EdgeInsets.all(8),
                  child: Text(title.isEmpty?'Alert':title,style: TextStyle(color: AppTheme.appBlack,fontWeight: FontWeight.w600,fontSize: 18),textAlign: TextAlign.left,)),
              if(message.isNotEmpty)Container(
                  padding: const EdgeInsets.all(8),child: Text(message)),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () => SmartDialog.dismiss(),
                    child: Text(cancelTextButton ??'Cancel',style: TextStyle(color: AppTheme.appBlack),textAlign: TextAlign.left,),
                  ),
                  ElevatedButton(
                    //Colors.green,
                    onPressed: () {
                      onConfirm?.call();
                      SmartDialog.dismiss();
                    },
                    child: Text(confirmTextButton ??'Ok',style: TextStyle(color: AppTheme.appBlack),textAlign: TextAlign.left,),
                  ),
                ],
              )
            ]),
      );
    });
  }
  // hideSuccessAlert(){
  //   SmartDialog.dismiss(status: SmartStatus.dialog);
  // }
  showCartEmptyAlert({
    required String title,
    required double height,
    required double width
  }) {
    SmartDialog.show(builder: (context) {
      return Container(
        height: height,
        width: width,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child:Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Container(
                  padding: const EdgeInsets.all(8),
                  child: Text(title.isEmpty?'Alert':title,style: TextStyle(color: AppTheme.appBlack,fontWeight: FontWeight.w600,fontSize: 18),textAlign: TextAlign.left,)),
              Container(
                  padding: const EdgeInsets.all(8),child: const Text('Your cart is empty. Click the Proceed button to Order Kirana Products in your cart.')),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () => SmartDialog.dismiss(),
                    child: Text('CANCEL',style: TextStyle(color: AppTheme.appBlack),textAlign: TextAlign.left,),
                  ),
                  ElevatedButton(
                    //Colors.green,
                    onPressed: ()  => SmartDialog.dismiss(),
                    child: Text('PROCEED',style: TextStyle(color: AppTheme.appBlack),textAlign: TextAlign.left,),
                  ),
                ],
              )
            ]),
      );
    });
  }
  showCameraAlert({
    required String title,
    final void Function()? onCamera,
    final void Function()? onGallery,
    String? cancelTextButton,
    required double height,
    required double width
  }) {
    SmartDialog.show(builder: (context) {
      return Container(
        height: height,
        width: width,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child:Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Container(
                  padding: const EdgeInsets.all(8),
                  child: Text(title,style: TextStyle(color: AppTheme.appBlack,fontWeight: FontWeight.w600,fontSize: 18),textAlign: TextAlign.left,)),
              GestureDetector(
                onTap: (){
                  onCamera?.call();
                  SmartDialog.dismiss();
                },
                child: Container(
                    padding: const EdgeInsets.all(8),child:  Text('Camera',style: TextStyle(color: AppTheme.appBlack,fontSize: 14))),
              ),
              Divider(color: AppTheme.appGrey,),
              GestureDetector(
                onTap: (){
                  onGallery?.call();
                  SmartDialog.dismiss();
                },
                child: Container(
                    padding: const EdgeInsets.all(8),child:  Text('Gallery',style: TextStyle(color: AppTheme.appBlack,fontSize: 14))),
              ),
              Divider(color: AppTheme.appGrey,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => SmartDialog.dismiss(),
                    child: Text(cancelTextButton ??'Cancel',style: TextStyle(color: AppTheme.appBlack,fontWeight: FontWeight.w600,fontSize: 16),textAlign: TextAlign.left,),
                  ),
                ],
              )
            ]),
      );
    });
  }
  showSmartLoadingDialog() {
    SmartDialog.show(builder: (context) {
      return Container(
        height: 80,
        width: 180,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child:const CircularProgressIndicator(),
      );
    });
  }
  hideSmartLoadingDialog(){
    SmartDialog.dismiss(status: SmartStatus.dialog);
  }

  showTimeOutAlert({
    final void Function()? onConfirm,
    String? confirmTextButton,
    String? cancelTextButton,
  }) {
    SmartDialog.show(builder: (context) {
      return Container(
        height: 140,
        width: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child:Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[
              Text('Time Out',style: TextStyle(color: AppTheme.appBlack,fontSize: 24),textAlign: TextAlign.center,),
              Icon(Icons.timer_off_rounded,size: 30,color: AppTheme.appRed,),
              Container(
                width: 180,
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.only(right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: AppTheme.appRed,
                        elevation: 3,
                        padding: const EdgeInsets.all(4),
                        alignment: Alignment.center,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(30.0)),
                        // fixedSize: const Size(150, 52),
                        //////// HERE
                      ),
                      onPressed: () {
                        onConfirm?.call();
                        SmartDialog.dismiss();
                      },
                      child: Text(confirmTextButton ??'Ok',style: TextStyle(color: AppTheme.appWhite),textAlign: TextAlign.left,),
                    ),
                  ],
                ),
              )
            ]),
      );
    });
  }

  showOtpConfirm({
    final void Function()? onConfirm,
    String? confirmTextButton,
    String? cancelTextButton,
    required String message,
    required String title,
  }) {
    SmartDialog.show(builder: (context) {
      return Container(
        height: 160,
        padding: const EdgeInsets.all(8),
        width: MediaQuery.of(context).size.width-100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child:Column(
            children:[
              Container(alignment: Alignment.centerLeft,
                  width: MediaQuery.of(context).size.width-100,
                  child: Text(title,style: TextStyle(color: AppTheme.appBlack,fontSize: 22),textAlign: TextAlign.left,)),
              const SizedBox(height: 10,),
              Text(message,style: TextStyle(color: AppTheme.appBlack,fontSize: 16),textAlign: TextAlign.left,),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                    ),
                    //Colors.orange,
                    onPressed: () {
                      onConfirm?.call();
                      SmartDialog.dismiss();
                    },
                    child: Text(confirmTextButton ??'Ok',style: TextStyle(color: AppTheme.appBlack),),
                  ),
                ],
              )
            ]),
      );
    });
  }
  showPaymentMethodDialog({
    final void Function()? onCashDelivery,
    final void Function()? onPayNow,
  }) {
    SmartDialog.show(builder: (context) {
      return Container(
        height: 150,
        padding: const EdgeInsets.all(8),
        width: MediaQuery.of(context).size.width-100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child:Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:[
              Container(alignment: Alignment.centerLeft,
                  width: MediaQuery.of(context).size.width-100,
                  child: Text('Alert',style: TextStyle(color: AppTheme.appBlack,fontSize: 22),textAlign: TextAlign.left,)),
              const SizedBox(height: 10,),
              Container(alignment: Alignment.centerLeft,
                  width: MediaQuery.of(context).size.width-100,
                  child: Text('Select Payment Method',style: TextStyle(color: AppTheme.appBlack,fontSize: 18),textAlign: TextAlign.left,)),
              const SizedBox(height: 10,),
              Container(alignment: Alignment.centerLeft,
                width: MediaQuery.of(context).size.width-100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: AppTheme.appRed,
                        elevation: 3,
                        padding: const EdgeInsets.all(8),
                        alignment: Alignment.center,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(0.0)),
                        //fixedSize: const Size(100, 30),
                        //////// HERE
                      ),
                      //Colors.orange,
                      onPressed: () {
                        onCashDelivery?.call();
                        SmartDialog.dismiss();
                      },
                      child: Text('Cash on Delivery',style: TextStyle(color: AppTheme.appWhite),),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: AppTheme.appGreen,
                        elevation: 3,
                        padding: const EdgeInsets.all(8),
                        alignment: Alignment.center,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(0.0)),
                        //fixedSize: const Size(100, 30),
                        //////// HERE
                      ),
                      //Colors.orange,
                      onPressed: () {
                        onPayNow?.call();
                        SmartDialog.dismiss();
                      },
                      child: Text('Pay Now',style: TextStyle(color: AppTheme.appWhite),),
                    )
                  ],
                ),
              )
            ]),
      );
    });
  }
  showBottomSheet({
    bool isScrollControlled = true,
    Color backgroundColor = Colors.transparent,
    bool enableDrag = false,
    required WidgetBuilder builder,
  }) {
    showModalBottomSheet<void>(
      context: this,
      isScrollControlled: isScrollControlled,
      backgroundColor: backgroundColor,
      enableDrag: enableDrag,
      builder: builder,
    );
  }

  showRequestError({
    final void Function()? onConfirm,
    String? confirmTextButton,
    String? cancelTextButton,
    required String message,
  }) {
    SmartDialog.show(builder: (context) {
      return Container(
        height: 180,
        width: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child:Column(
            children:[
              Text(message),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    //Colors.orange,
                    onPressed: () {
                      onConfirm?.call();
                      SmartDialog.dismiss();
                    },
                    child: Text(confirmTextButton ??'Ok'),
                  ),
                ],
              )
            ]),
      );
    });
  }

  showPlaceOrderAlert({
    final void Function()? onProceed,
    final void Function()? onAddressChange,
    String? confirmTextButton,
    String? cancelTextButton,
    required String address
  }) {
    SmartDialog.show(builder: (context) {
      return Container(
        height: 300,
        width: MediaQuery.of(context).size.width-40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child:Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Container(
                  margin: const EdgeInsets.only(bottom: 10,left: 10),
                  child: Text('Place Order',style: TextStyle(color: AppTheme.appBlack,fontSize: 24,fontWeight: FontWeight.w600),textAlign: TextAlign.left,)),
              Container(
                  margin: const EdgeInsets.only(bottom: 10,left: 10),
                  child: Text('Your order will be delivered at $address',style: TextStyle(color: AppTheme.appBlack,fontSize:16),textAlign: TextAlign.left,)),
              Container(
                width: MediaQuery.of(context).size.width-40,
                alignment: Alignment.centerRight,

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(

                      onPressed: () {
                        SmartDialog.dismiss();
                        onProceed?.call();

                      },
                      child: Text(confirmTextButton ??'PROCEED',style: TextStyle(color: AppTheme.appBlack),textAlign: TextAlign.left,),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width-40,
                alignment: Alignment.centerRight,
                // margin: EdgeInsets.only(right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(

                      onPressed: () {
                        SmartDialog.dismiss();
                        onAddressChange?.call();

                      },
                      child: Text(confirmTextButton ??'CHANGE ADDRESS',style: TextStyle(color: AppTheme.appBlack),textAlign: TextAlign.left,),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width-40,
                alignment: Alignment.centerRight,
                // margin: EdgeInsets.only(right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(

                      onPressed: () {

                        SmartDialog.dismiss();
                      },
                      child: Text(confirmTextButton ??'CANCEL',style: TextStyle(color: AppTheme.appBlack),textAlign: TextAlign.left,),
                    ),
                  ],
                ),
              )
            ]),
      );
    });
  }

}
