import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sultan_pizza/bloc/history/history_bloc.dart';
import 'package:sultan_pizza/components/history_order.dart';
import 'package:sultan_pizza/config/constants.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();
    final myBloc = BlocProvider.of<HistoryBloc>(context);
    myBloc.add(InitializeData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'الطلبات السابقه',
          style: TextStyle(fontFamily: 'Tajwal', color: kSecondColor),
        ),
        iconTheme: IconThemeData(color: kSecondColor),
      ),
      body: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          if (state is HistoryInitial) {
            return buildProgressBar(context);
          } else if (state is HistoryLoaded) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color(0xFFFFC61F),
                        ),
                        child: HistoryComponent(state.allOrders[index])),
                  );
                },
                itemCount: state.allOrders.length,
              ),
            );
          }
        },
      ),
    );
  }

  Widget buildProgressBar(context) {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.lightBlueAccent,
      ),
    );
  }
}
