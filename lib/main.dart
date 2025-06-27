import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logintestapp/domain/cubit/auth_cubit.dart';
import 'package:logintestapp/injection.dart';
import 'package:logintestapp/presentation/account_screen/account_screen.dart';
import 'package:logintestapp/presentation/login_screen/login_screen.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => inj.authCubit..checkStatus(),
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromARGB(229, 229, 229, 229),
          ),
        ),
        home: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            switch (state) {
              case AuthStateLoading():
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              case AuthStateReady():
                return state.isAuth ? AccountScreen() : LoginScreen();
            }
          },
        ),
      ),
    ),
  );
}
