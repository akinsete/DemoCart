import 'package:flutter/material.dart';

class CartItem {
  int total;
  int qty;
  int price;

  CartItem({this.total, this.qty, this.price});
}

class ProductProvider extends ChangeNotifier {
  var cartItems = List<CartItem>();

  int _allQty = 0;
  int get getAllQty => _allQty;

  double _allTotal = 0.0;
  double get getAllTotal => _allTotal;

  void init() {
    cartItems.clear();
    cartItems.add(CartItem(price: 35, qty: 1, total: 35));
    cartItems.add(CartItem(price: 45, qty: 1, total: 45));
    cartItems.add(CartItem(price: 50, qty: 2, total: 100));
    cartItems.add(CartItem(price: 75, qty: 2, total: 150));
  }

  void increment(int index) {
    int x = cartItems[index].qty += 1;
    cartItems[index].total = cartItems[index].price * x;
    calculateTotal();
  }

  void decrement(int index) {
    if (cartItems[index].qty > 0) {
      int x = cartItems[index].qty -= 1;
      cartItems[index].total = cartItems[index].price * x;
      calculateTotal();
    }
  }

  void calculateTotal() {
    _resetTotalCalculation();
    cartItems.forEach((cartItem) {
      _allQty += cartItem.qty;
      _allTotal += cartItem.total;
    });
    notifyListeners();
  }

  void _resetTotalCalculation() {
    _allTotal = 0.0;
    _allQty = 0;
  }
}
