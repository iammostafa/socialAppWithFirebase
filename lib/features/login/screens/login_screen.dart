import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:sizer/sizer.dart';
import 'package:social_app/features/login/cubit/login_cubit.dart';
import 'package:social_app/features/register/screens/register_screen.dart';
import 'package:social_app/global/custom_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _email;
  late TextEditingController _password;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          // state is LoginFaild ? Fluttertoast.showToast(msg: ) : print('success');
        },
        builder: (context, state) {
          return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Scaffold(
                body: SizedBox(
                  width: 100.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Telegram',
                        style: textTheme.headline1,
                      ),
                      CustomVSpacer(13),
                      CustomTextField(
                          txController: _email,
                          label: 'Email',
                          textInputType: TextInputType.emailAddress),
                      CustomTextField(
                          isObsecure: true,
                          txController: _password,
                          label: 'Password',
                          textInputType: TextInputType.visiblePassword),
                      CustomVSpacer(5),
                      SizedBox(
                        width: 100.w,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            state is LoginLoading
                                ? CircularProgressIndicator()
                                : CustomEButton(
                                    onPressed: () {
                                      LoginCubit.get(context)
                                          .signInWithEmailAndPassword(
                                              _email.text,
                                              _password.text,
                                              context);
                                    },
                                    title: 'login',
                                    textStyle: textTheme.headline5!,
                                    style: Theme.of(context)
                                        .elevatedButtonTheme
                                        .style!,
                                  ),
                            // ElevatedButton(
                            //     onPressed: () {
                            //       print('object');
                            //     },
                            //     child: Text('data')),
                            CustomEButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (c) => RegisterScreen()));
                              },
                              textStyle: textTheme.caption!,
                              title: 'Register',
                              style: Theme.of(context)
                                  .elevatedButtonTheme
                                  .style!
                                  .copyWith(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: CustomColors
                                                    .primaryColor))),
                                  ),
                            ),
                          ],
                        ),
                      ),
                      state is LoginGmailLoading
                          ? CircularProgressIndicator()
                          : SignInButton(
                              Buttons.Google,
                              onPressed: () {
                                LoginCubit.get(context)
                                    .signInWithGoogle(context);
                              },
                            )
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController _txController;
  final TextInputType _textInputType;
  final String label;
  final bool isObsecure;
  const CustomTextField({
    Key? key,
    required TextEditingController txController,
    required TextInputType textInputType,
    required this.label,
    this.isObsecure = false,
  })  : _txController = txController,
        _textInputType = textInputType,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: TextField(
        controller: _txController,
        keyboardType: _textInputType,
        obscureText: isObsecure,
        // inputFormatters: [
        //   FilteringTextInputFormatter.digitsOnly,
        // ],
        decoration: InputDecoration(
          labelText: label,
          // hintText: 'Enter Your Phone number',
        ),
      ),
    );
  }
}

class CustomEButton extends StatelessWidget {
  final String title;
  final ButtonStyle style;
  final TextStyle textStyle;
  final Function onPressed;
  const CustomEButton({
    Key? key,
    required this.title,
    required this.style,
    required this.textStyle,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          onPressed();
        },
        style: style,
        child: Text(
          title,
          style: textStyle,
        ));
  }
}

class CustomVSpacer extends StatelessWidget {
  final double space;
  const CustomVSpacer(
    this.space,
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: space.h,
    );
  }
}
