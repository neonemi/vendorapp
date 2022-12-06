
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';


class HiveFunctions {

  var cartList = [];

  void addToCart(int index){

    var keyBox = Hive.box('keyedBox');
    var quantity = keyBox.get('quantity');
    if(cartList.contains(quantity)){
      //already added
      // customSnackBar('Add to cart', 'this item has already added to cart');

    }else{
     // var quantity = keyBox.get('quantity');
      keyBox.put('quantity', '1');
      cartList.add(quantity);
      // customSnackBar('Add to cart', '${item.name} successfully added to cart');
      //update(['updateCartList']);
    }
   print(quantity);
  }

  void removeFromCart(int index){
    var keyBox = Hive.box('keyedBox');
    var quantity = keyBox.get('quantity');
    keyBox.deleteAt(index);
    cartList.remove(quantity);
    // customSnackBar('Item removed', '${item.name} removed from cart');
    //update(['updateCartList']);
  }


  quantityIncrement(int index){
    var keyBox = Hive.box('keyedBox');
    var quantity = keyBox.get('quantity');
      quantity ??= 0;
      var quantitytNew = int.parse(quantity.toString());

    if(quantitytNew <9){
      quantitytNew += 1;
      keyBox.put('quantity', quantitytNew.toString());

    }else{
      // customSnackBar('Wrong quantity', 'quantity can not be upper than 9');
    }

  }

  quantityDecrement(int index){
    var keyBox = Hive.box('keyedBox');
    var quantity = keyBox.get('quantity');
    quantity ??= 0;
    var quantitytNew=int.parse(quantity.toString());
    if(quantitytNew > 1){
      quantitytNew -= 1;
      keyBox.put('quantity', quantity.toString());
    }
    else{
      // customSnackBar('Wrong quantity', 'quantity can not be lower than 1');
    }

  }


}