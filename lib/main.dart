import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:social_app/cubit/app_cubit.dart';
import 'package:social_app/features/main/cubit/main_cubit.dart';
import 'package:social_app/global/namedRoutes.dart';
import 'package:social_app/global/spManager.dart';
import 'package:social_app/global/theme.dart';

import 'global/bloc_observer.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();

  getToken();
  runApp(const MyApp());
}

String? tokenValue;

getToken() async {
  tokenValue = await CacheHelper.getStringData(key: 'Token');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return BlocProvider(
        create: (context) => AppCubit(),
        child: BlocConsumer<AppCubit, AppcubitState>(
          listener: (context, state) {
          },
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: CustomTheme.lightTheme,
              initialRoute: tokenValue != null ? '/' : '/loginScreen',
              themeMode: AppCubit.get(context).isDark 
                  ? ThemeMode.dark
                  : ThemeMode.light,
              onGenerateRoute: RouterGenerator.generateRoute,
              darkTheme: CustomTheme.darkTheme,
            );
          },
        ),
      );
    });
  }
}
