import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logintestapp/domain/cubit/auth_cubit.dart';
import 'package:logintestapp/domain/cubit/get_user_id_cubit.dart';
import 'package:logintestapp/injection.dart';
import 'package:logintestapp/presentation/decoration/login_button.dart';
import 'package:logintestapp/presentation/decoration/title_text.dart';
import 'package:logintestapp/presentation/login_screen/login_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => inj.getUserIdCubit..getId(),
      child: Scaffold(
        backgroundColor: Color(0xFFE5E5E5),
        body: SafeArea(
          child: BlocBuilder<GetUserIdCubit, GetUserIdState>(
            builder: (context, state) {
              return switch (state) {
                GetUserIdLoading() => const Center(
                  child: CircularProgressIndicator(),
                ),
                GetUserIdError() => Center(
                  child: Column(
                    children: [
                      Text(
                        state.error.toString(),
                      ),
                      Text(
                        state.st.toString(),
                      ),
                    ],
                  ),
                ),
                GetUserIdReady() => Padding(
                  padding: const EdgeInsets.all(49),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.account_circle,
                            size: 100,
                            color: Color(0xFFF2796B),
                          ),
                          const SizedBox(height: 24),
                          TitleText(title: 'Welcome Back!'),
                          const SizedBox(height: 8),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Your id: ',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: state.userId,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 34),
                          Image(
                            image: AssetImage(
                              'assets/images/enterImg.png',
                            ),
                          ),
                          const SizedBox(height: 32),
                          LoginButton(
                            isLoading: false,
                            onTap: () {
                              context.read<AuthCubit>().logout();

                              Navigator.of(
                                context,
                              ).pushReplacement(
                                MaterialPageRoute(
                                  builder: (_) => LoginScreen(),
                                ),
                              );
                            },
                            title: 'Logout',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              };
            },
          ),
        ),
      ),
    );
  }
}
