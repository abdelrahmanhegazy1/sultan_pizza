import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sultan_pizza/bloc/home/home_bloc.dart';
import 'package:sultan_pizza/components/sultan_item.dart';
import 'package:sultan_pizza/config/constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(Load('helw'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondColor,
      appBar: AppBar(
        title: Text(
          'السلطان',
          textDirection: TextDirection.rtl,
          style: TextStyle(
              fontFamily: 'Tajwal',
              fontSize: 20.0,
              color: kSecondColor,
              fontWeight: FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: kSecondColor),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: Container(
          color: kSecondColor,
          child: ListView(
            children: [
              DrawerHeader(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: Image.asset(
                        'images/sultan_pizza_logo.png',
                        height: 80,
                      ),
                    ),
                    Text(
                      'السلطان',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Tajwal',
                          color: kSecondColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: kMainColor,
                ),
              ),
              ListTile(
                title: Text(
                  'عربة التسوق',
                  style: TextStyle(
                      fontFamily: 'Tajwal',
                      fontSize: 15.0,
                      color: Colors.white),
                ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pushNamed(
                    context,
                    kCart_Screen,
                  );
                },
                leading: Icon(
                  Icons.shopping_cart,
                  color: kMainColor,
                ),
              ),
              ListTile(
                title: Text(
                  'حسابي',
                  style: TextStyle(
                      fontFamily: 'Tajwal',
                      fontSize: 15.0,
                      color: Colors.white),
                ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pushNamed(
                    context,
                    kCart_Screen,
                  );
                },
                leading: Icon(Icons.person, color: kMainColor),
              ),
              ListTile(
                title: Text(
                  'الطلبات السابقه',
                  style: TextStyle(
                      fontFamily: 'Tajwal',
                      fontSize: 15.0,
                      color: Colors.white),
                ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pushNamed(
                    context,
                    kHistory_Screen,
                  );
                },
                leading: Icon(
                  Icons.history,
                  color: kMainColor,
                ),
              ),
              ListTile(
                title: Text(
                  'التواصل مع المطور',
                  style: TextStyle(
                      fontFamily: 'Tajwal',
                      fontSize: 15.0,
                      color: Colors.white),
                ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pushNamed(
                    context,
                    kCart_Screen,
                  );
                },
                leading: Icon(
                  Icons.developer_board,
                  color: kMainColor,
                ),
              ),
            ],
          ),
        ),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoaded) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0, top: 5.0),
                    child: Text(
                      'افتكاسات',
                      style: TextStyle(
                          fontFamily: 'Tajwal',
                          fontSize: 40.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                  SizedBox(
                    height: 240.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          child: SultanItem(state.myMenuEftakast[index]),
                          onTap: () {
                            Navigator.pushNamed(context, kPizza_Screen,
                                arguments: state.myMenuEftakast[index]);
                          },
                        );
                      },
                      itemCount: state.myMenuEftakast.length,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0, top: 5.0),
                    child: Text(
                      'بيتزا شرقي',
                      style: TextStyle(
                          fontFamily: 'Tajwal',
                          fontSize: 40.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                  SizedBox(
                    height: 240.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          child: SultanItem(state.myMenuPizzaSharky[index]),
                          onTap: () {
                            Navigator.pushNamed(context, kPizza_Screen,
                                arguments: state.myMenuPizzaSharky[index]);
                          },
                        );
                      },
                      itemCount: state.myMenuPizzaSharky.length,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0, top: 5.0),
                    child: Text(
                      'بيتزا ايطالي',
                      style: TextStyle(
                          fontFamily: 'Tajwal',
                          fontSize: 40.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                  SizedBox(
                    height: 240.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          child: SultanItem(state.myMenuPizzaItaly[index]),
                          onTap: () {
                            Navigator.pushNamed(context, kPizza_Screen,
                                arguments: state.myMenuPizzaItaly[index]);
                          },
                        );
                      },
                      itemCount: state.myMenuPizzaItaly.length,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0, top: 5.0),
                    child: Text(
                      'فطائر',
                      style: TextStyle(
                          fontFamily: 'Tajwal',
                          fontSize: 40.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                  SizedBox(
                    height: 240.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          child: SultanItem(state.myMenuFeter[index]),
                          onTap: () {
                            Navigator.pushNamed(context, kPizza_Screen,
                                arguments: state.myMenuFeter[index]);
                          },
                        );
                      },
                      itemCount: state.myMenuFeter.length,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0, top: 5.0),
                    child: Text(
                      'الحلويات',
                      style: TextStyle(
                          fontFamily: 'Tajwal',
                          fontSize: 40.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                  SizedBox(
                    height: 240.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          child: SultanItem(state.myMenuHelw[index]),
                          onTap: () {
                            Navigator.pushNamed(context, kPizza_Screen,
                                arguments: state.myMenuHelw[index]);
                          },
                        );
                      },
                      itemCount: state.myMenuHelw.length,
                    ),
                  ),
                ],
              ),
            );
          } else if (state is HomeLoading) {
            return buildProgressBar(context);
          } else if (state is HomeInitial) {
            return buildProgressBar(context);
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
