import 'package:flutter/material.dart';
import 'package:sultan_pizza/components/item_order.dart';
import 'package:sultan_pizza/model/history_order.dart';

class HistoryComponent extends StatelessWidget {
  final HistoryOrder historyOrder;
  HistoryComponent(this.historyOrder);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          // height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return ItemOrder(historyOrder.foodList[index]);
            },
            itemCount: historyOrder.foodList.length,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Text(
                ' ${historyOrder.price}جنيه',
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                    fontFamily: 'Tajwal',
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Text(
                ':السعر',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontFamily: 'Tajwal',
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Text(
                historyOrder.address,
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontFamily: 'Tajwal',
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Text(
                ':العنوان',
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontFamily: 'Tajwal',
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                historyOrder.time,
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontFamily: 'Tajwal',
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Text(
                ':التوقيت',
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontFamily: 'Tajwal',
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
