import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sultan_pizza/bloc/order/order_bloc.dart';
import 'package:sultan_pizza/components/confirm_order.dart';
import 'package:sultan_pizza/components/map.dart';
import 'package:sultan_pizza/components/reciepe.dart';
import 'package:sultan_pizza/config/constants.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int currentStep = 0;
  Map<String, Object> map;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    map = ModalRoute.of(context).settings.arguments;
    print(map['cost']);
    final orderBloc = BlocProvider.of<OrderBloc>(context);
    orderBloc.finalOrder = map['cart'];
    orderBloc.price = map['cost'];

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: kSecondColor),
          title: Text(
            'خطوات الطلب',
            style: TextStyle(fontFamily: 'Tajwal', color: kSecondColor),
          ),
        ),
        body: BlocListener<OrderBloc, OrderState>(
          listener: (context, state) {
            currentStep = state.step;
            if (state is OrderFailure) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.error,
                    style: TextStyle(fontFamily: 'Tajwal', fontSize: 15.0),
                  ),
                ),
              );
            } else if (state is OrderCompleted) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'لقد تم الطلب بنجاح',
                    style: TextStyle(fontFamily: 'Tajwal', fontSize: 15.0),
                  ),
                ),
              );

              Navigator.popUntil(context, ModalRoute.withName(kHome_Screen));
            }
          },
          child: BlocBuilder<OrderBloc, OrderState>(
            builder: (context, state) {
              return Stepper(
                physics: NeverScrollableScrollPhysics(),
                currentStep: state.step,
                steps: getStepList(),
                onStepContinue: () {
                  orderBloc.add(ContinueEvent());
                },
                onStepCancel: () {
                  orderBloc.add(CancelEvent());
                },
              );
            },
          ),
        ));
  }

  List<Step> getStepList() {
    List<Step> steps = [
      Step(
        title: Text(
          'تفاصيل الطلب',
          style: TextStyle(
              fontFamily: 'Tajwal', fontSize: 15.0, color: kSecondColor),
        ),
        content: Reciepe(map['cart'], map['cost']),
        isActive: currentStep >= 0,
      ),
      Step(
        title: Text(
          'تحديد مكان التوصيل',
          style: TextStyle(
              fontFamily: 'Tajwal', fontSize: 15.0, color: kSecondColor),
        ),
        content: MapLocation(),
        isActive: currentStep >= 1,
      ),
      Step(
        title: Text(
          'تأكيد الطلب',
          style: TextStyle(
              fontFamily: 'Tajwal', fontSize: 15.0, color: kSecondColor),
        ),
        content: ConfirmOrder(myCart: map['cart'], price: map['cost']),
        state: StepState.complete,
        isActive: currentStep >= 2,
      ),
    ];
    return steps;
  }
}
