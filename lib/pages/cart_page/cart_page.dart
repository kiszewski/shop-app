import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/models/item_cart_model.dart';
import 'package:shopApp/pages/cart_page/item_cart_component.dart';
import 'package:shopApp/utils/size_config.dart';
import 'package:shopApp/viewmodels/cart_viewmodel.dart';
import 'package:shopApp/viewmodels/order_viewmodel.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final CartViewModel _cartViewModel =
        Provider.of<CartViewModel>(context, listen: false);
    final OrderViewModel _orderViewModel =
        Provider.of<OrderViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black87),
        backgroundColor: Colors.white12,
        elevation: 0,
        title: Text(
          'Carrinho de compras',
          style: TextStyle(color: Colors.black87),
        ),
      ),
      body: Container(
        color: Colors.white70,
        height: SizeConfig.blockSizeVertical * 100,
        child: StreamBuilder<List<ItemCartModel>>(
          initialData: [],
          stream: _cartViewModel.cart,
          builder: (context, snapshot) {
            double _totalInCart = _cartViewModel.totalInCart(snapshot.data);

            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 8),
                  width: SizeConfig.blockSizeHorizontal * 100,
                  height: SizeConfig.blockSizeVertical * 75,
                  child: snapshot.data.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/cart-empty.png',
                              fit: BoxFit.fill,
                              height: SizeConfig.blockSizeVertical * 15,
                              width: SizeConfig.blockSizeHorizontal * 30,
                            ),
                            Text(
                              'Seu carrinho de compras está vazio',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        )
                      : ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            final ItemCartModel product =
                                snapshot.data.toList()[index];
                            return ItemCartComponent(product);
                          },
                        ),
                ),
                Container(
                  height: SizeConfig.blockSizeVertical * 14.15,
                  child: Card(
                    margin: EdgeInsets.all(0),
                    elevation: 16,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    )),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: SizeConfig.blockSizeHorizontal * 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'R\$ ${_totalInCart.toStringAsFixed(2)}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          SizeConfig.blockSizeHorizontal * 25),
                                  color: Theme.of(context).primaryColor,
                                  textColor: Colors.white,
                                  onPressed: () =>
                                      _orderViewModel.checkOut(snapshot.data),
                                  child: Text(
                                    'Finalizar Compra',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
