import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logintestapp/domain/cubit/auth_cubit.dart';
import 'package:logintestapp/domain/cubit/post_code_cubit.dart';
import 'package:logintestapp/injection.dart';
import 'package:logintestapp/presentation/account_screen/account_screen.dart';
import 'package:logintestapp/presentation/decoration/login_button.dart';
import 'package:logintestapp/presentation/decoration/title_text.dart';
import 'package:pinput/pinput.dart';

class CheckCodeScreen extends StatefulWidget {
  final String email;
  const CheckCodeScreen({required this.email, super.key});

  @override
  State<CheckCodeScreen> createState() => _CheckCodeScreenState();
}

class _CheckCodeScreenState extends State<CheckCodeScreen> {
  late final TextEditingController pinController;
  late final FocusNode focusNode;
  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    pinController = TextEditingController();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE5E5E5),
      body: Center(
        child: BlocProvider(
          create: (context) => inj.postCodeCubit,
          child: BlocConsumer<PostCodeCubit, PostCodeState>(
            listener: (context, state) {
              if (state is PostCodeError) {
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
              if (state is PostCodeReady) {
                context.read<AuthCubit>().checkStatus();
                Navigator.of(
                  context,
                ).pushReplacement(
                  MaterialPageRoute(builder: (_) => AccountScreen()),
                );
              }
            },
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 49,
                  horizontal: 24,
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TitleText(title: 'Enter the code sent to your email:'),
                        SizedBox(
                          height: 49,
                        ),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Pinput(
                            length: 6,
                            controller: pinController,
                            focusNode: focusNode,
                            separatorBuilder: (index) =>
                                const SizedBox(width: 8),
                            onCompleted: (pin) {
                              debugPrint('onCompleted: $pin');
                            },
                            onChanged: (value) {
                              debugPrint('onChanged: $value');
                            },

                            defaultPinTheme: PinTheme(
                              width: 46,
                              height: 56,
                              textStyle: TextStyle(
                                fontSize: 22,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 49,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: LoginButton(
                            isLoading: state is PostCodeLoading,
                            onTap: () {
                              final code = int.parse(pinController.text);
                              context.read<PostCodeCubit>().sendCode(
                                widget.email,
                                code,
                              );
                            },
                            title: 'Validate',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
