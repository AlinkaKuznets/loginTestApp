import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logintestapp/presentation/check_code_screen/check_code_screen.dart';
import 'package:logintestapp/domain/cubit/post_email_cubit.dart';
import 'package:logintestapp/presentation/decoration/decorate_line.dart';
import 'package:logintestapp/presentation/decoration/title_text.dart';
import 'package:logintestapp/presentation/login_screen/email_form.dart';
import 'package:logintestapp/injection.dart';
import 'package:logintestapp/presentation/decoration/login_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE5E5E5),
                  appBar: AppBar(
                    title: Row(
                      children: [
                        Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.person_outline),
                      ],
                    ),
                  ),
      body: BlocProvider(
        create: (_) => inj.postEmailCubit,
        child: BlocConsumer<PostEmailCubit, PostEmailState>(
          listener: (context, state) {
            if (state is PostEmailError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(
                SnackBar(
                  content: Text(
                    'Error: ${state.error}',
                  ),
                ),
              );
            }
            if (state is PostEmailReady) {
              final email = emailController.text.trim();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => CheckCodeScreen(
                    email: email,
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 49, horizontal: 24),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage(
                        'assets/images/loginImg.png',
                      ),
                    ),
                    const SizedBox(height: 16),
                    TitleText(title: 'Enter Your Email'),
                    const SizedBox(height: 31),
                    EmailForm(
                      formKey: formKey,
                      controller: emailController,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Change Email ?',
                          style: TextStyle(
                            color: const Color.fromARGB(156, 0, 0, 0),
                            fontSize: 12,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ),
      
                    SizedBox(
                      width: double.infinity,
                      child: LoginButton(
                        isLoading: state is PostEmailLoading,
                        onTap: () {
                          if (formKey.currentState?.validate() ?? false) {
                            final cubit = context.read<PostEmailCubit>();
                            final email = emailController.text.trim();
                            cubit.sendCode(email);
                          }
                        },
                        title: 'Login',
                      ),
                    ),
      
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        DecorateLine(),
                        SizedBox(width: 8),
                        const Text(
                          'Or Login with',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(156, 0, 0, 0),
                          ),
                        ),
                        SizedBox(width: 8),
                        DecorateLine(),
                      ],
                    ),
                    SizedBox(height: 42),
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage(
                              'assets/images/googleIcon.png',
                            ),
                            width: 21,
                            height: 21,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Text(
                            'Google',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 44),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(text: 'You don’t have an account ? '),
                          TextSpan(
                            text: 'Sign up',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

//linaolen6@mail.ru
