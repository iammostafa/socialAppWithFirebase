import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:social_app/features/login/cubit/login_cubit.dart';
import 'package:social_app/features/login/screens/login_screen.dart';
import 'package:social_app/features/register/cubit/register_cubit.dart';
import 'package:social_app/global/custom_colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController _email;
  late TextEditingController _password;
  late TextEditingController _phone;
  late TextEditingController _name;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
    _phone = TextEditingController();
    _name = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          state is LoginFaild ? print('failed') : print('success');
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
                        'Register',
                        style: textTheme.headline1,
                      ),
                      CustomVSpacer(13),
                      CustomTextField(
                          txController: _name,
                          label: 'Name',
                          textInputType: TextInputType.name),
                      CustomTextField(
                          txController: _email,
                          label: 'Email',
                          textInputType: TextInputType.emailAddress),
                      CustomTextField(
                          isObsecure: true,
                          txController: _password,
                          label: 'Password',
                          textInputType: TextInputType.visiblePassword),
                      CustomTextField(
                          isObsecure: false,
                          txController: _phone,
                          label: 'Phone',
                          textInputType: TextInputType.phone),
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
                                      RegisterCubit.get(context)
                                          .createUserWithEmailAndPassword(
                                              _name.text,
                                              _email.text,
                                              _password.text,
                                              _phone.text,
                                              context);
                                    },
                                    textStyle: textTheme.caption!,
                                    title: 'Register',
                                    style: Theme.of(context)
                                        .elevatedButtonTheme
                                        .style!
                                        .copyWith(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.white),
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
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
