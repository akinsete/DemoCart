import 'package:after_layout/after_layout.dart';
import 'package:demo_cart/product_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen>
    with AfterLayoutMixin<ProductListScreen> {
  @override
  void afterFirstLayout(BuildContext context) {
    var model = Provider.of<ProductProvider>(context, listen: false);
    model.init();
    model.calculateTotal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Consumer<ProductProvider>(
              builder: (context, model, widget) {
                return ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemCount: model.cartItems.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Q:" + model.cartItems[index].qty.toString(),
                                  style: TextStyle(fontSize: 22)),
                              Text(
                                  "A:" +
                                      model.cartItems[index].total.toString(),
                                  style: TextStyle(fontSize: 22)),
                              FlatButton(
                                child:
                                    Text("-", style: TextStyle(fontSize: 20)),
                                onPressed: () {
                                  model.decrement(index);
                                },
                              ),
                              FlatButton(
                                child:
                                    Text("+", style: TextStyle(fontSize: 20)),
                                onPressed: () {
                                  model.increment(index);
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            height: 100,
            child: Consumer<ProductProvider>(
              builder: (context, model, child) {
                return Container(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Quantity: " + model.getAllQty.toString(),
                          style: TextStyle(fontSize: 20)),
                      Text("Total Amount: " + model.getAllTotal.toString(),
                          style: TextStyle(fontSize: 20))
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
