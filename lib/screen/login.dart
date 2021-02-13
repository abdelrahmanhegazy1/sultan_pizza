import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sultan_pizza/bloc/login/login_bloc.dart';
import 'package:sultan_pizza/bloc/register/register_bloc.dart';
import 'package:sultan_pizza/config/constants.dart';

class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kSecondColor,
        body: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginFailed)
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            else if (state is LoginSuccess)
              Navigator.pushNamed(context, kHome_Screen);
          },
          child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
            if (state is LoginInitial)
              return buildInitialWidget(context);
            else if (state is LoginLoading)
              return buildProgressBar(context);
            else if (state is LoginFailed)
              return buildInitialWidget(context);
            else if (state is LoginSuccess) return buildInitialWidget(context);
          }),
        ));
  }

  Widget buildProgressBar(context) {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.lightBlueAccent,
      ),
    );
  }

  Widget buildInitialWidget(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Flexible(
          child: Image.asset(
            'images/sultan_pizza_logo.png',
            height: 300,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextField(
            controller: emailController,
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
            style: TextStyle(color: kMainColor, fontSize: 17.0),
            obscureText: true,
            controller: passwordController,
            keyboardType: TextInputType.visiblePassword,
            textAlign: TextAlign.center,
            cursorColor: kMainColor,
            decoration: getDecorationTextField('Enter Password', 'password'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Material(
            borderRadius: BorderRadius.circular(30),
            color: kMainColor,
            child: MaterialButton(
              child: Text(
                'LOGIN',
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                BlocProvider.of<LoginBloc>(context).add(
                  LoginButtonClicked(
                      emailController.text, passwordController.text),
                );
              },
            ),
          ),
        ),
        BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state is OpenRegisterPage) {
              Navigator.pushNamed(context, kRegister_Screen);
            }
          },
          child: Padding(
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
                  //Navigator.pushNamed(context, kRegister_Screen);
                  BlocProvider.of<RegisterBloc>(context)
                      .add(GoingToRegisterPage());
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
