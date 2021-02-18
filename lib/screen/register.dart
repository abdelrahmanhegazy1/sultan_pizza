import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sultan_pizza/bloc/register/register_bloc.dart';
import 'package:sultan_pizza/config/constants.dart';
import 'package:sultan_pizza/model/account.dart';

class RegisterScreen extends StatelessWidget {
  final Account account = Account();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondColor,
      body: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterFailed) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          } else if (state is RegisterSuccess) {
            Navigator.pop(context);
          }
        },
        child: BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            if (state is RegisterInitial)
              return buildInitialWidget(context);
            else if (state is RegisterLoading)
              return buildProgressBar(context);
            else if (state is RegisterFailed)
              return buildInitialWidget(context);
            else if (state is RegisterSuccess) {
              return buildProgressBar(context);
            } else if (state is OpenRegisterPage) {
              return buildInitialWidget(context);
            }
          },
        ),
      ),
    );
  }

  Widget buildInitialWidget(context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            'images/sultan_pizza_logo.png',
            height: 150,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              onChanged: (value) => account.email = value,
              style: TextStyle(color: kMainColor, fontSize: 17.0),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.emailAddress,
              cursorColor: kMainColor,
              decoration: getDecorationTextField('Enter Email', 'email'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              onChanged: (value) => account.username = value,
              style: TextStyle(color: kMainColor, fontSize: 17.0),
              keyboardType: TextInputType.name,
              textAlign: TextAlign.center,
              cursorColor: kMainColor,
              decoration: getDecorationTextField('Enter Username', 'username'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              onChanged: (value) => account.password = value,
              style: TextStyle(color: kMainColor, fontSize: 17.0),
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              textAlign: TextAlign.center,
              cursorColor: kMainColor,
              decoration: getDecorationTextField('Enter Password', 'password'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              onChanged: (value) => account.age = int.parse(value),
              style: TextStyle(color: kMainColor, fontSize: 17.0),
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              cursorColor: kMainColor,
              decoration: getDecorationTextField('Enter Age', 'age'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              onChanged: (value) => account.number = value,
              style: TextStyle(color: kMainColor, fontSize: 17.0),
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              cursorColor: kMainColor,
              decoration:
                  getDecorationTextField('Enter Your Phone Number', 'age'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Material(
              borderRadius: BorderRadius.circular(30),
              color: Color(0xFF141518),
              child: MaterialButton(
                child: Text(
                  'REGISTER',
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: kMainColor),
                ),
                onPressed: () {
                  // final _bloc = RegisterBloc();
                  // _bloc.add();
                  BlocProvider.of<RegisterBloc>(context)
                      .add(RegisterButtonClicked(account));

                  // Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
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
