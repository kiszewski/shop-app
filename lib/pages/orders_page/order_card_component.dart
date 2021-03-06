import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/models/order_model.dart';
import 'package:shopApp/utils/size_config.dart';
import 'package:shopApp/viewmodels/order_viewmodel.dart';

class OrderCard extends StatefulWidget {
  final OrderModel order;

  const OrderCard(this.order);

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  bool expandedCard = false;

  toggleExpandCard() {
    setState(() {
      expandedCard = !expandedCard;
    });
  }

  @override
  Widget build(BuildContext context) {
    OrderViewModel _orderViewModel =
        Provider.of<OrderViewModel>(context, listen: false);

    return Card(
      elevation: 6,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          ListTile(
            title: Text(
                'R\$ ${_orderViewModel.totalOrder(widget.order).toString()}'),
            subtitle: Text(
                DateFormat('dd/M/y HH:mm').format(widget.order.date.toDate())),
            trailing: IconButton(
              icon: Icon(expandedCard ? Icons.expand_less : Icons.expand_more),
              onPressed: toggleExpandCard,
            ),
          ),
          expandedCard
              ? Padding(
                  padding: EdgeInsets.only(
                      left: SizeConfig.blockSizeHorizontal * 5,
                      right: SizeConfig.blockSizeHorizontal * 5,
                      bottom: SizeConfig.blockSizeVertical * 1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: widget.order.products
                        .map((product) => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(product.name),
                                Text('${product.qtd}x${product.price}'),
                              ],
                            ))
                        .toList(),
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
