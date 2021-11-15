// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sizer/sizer.dart';
// import 'package:social_app/features/login/cubit/login_cubit.dart';
// import 'package:social_app/features/login/screens/login_screen.dart';

// class ActiveCodeScreen extends StatefulWidget {
//   const ActiveCodeScreen({Key? key}) : super(key: key);

//   @override
//   State<ActiveCodeScreen> createState() => _ActiveCodeScreenState();
// }

// class _ActiveCodeScreenState extends State<ActiveCodeScreen> {
//   late TextEditingController _phoneNumber;
//   late User _user;

//   @override
//   void initState() {
//     super.initState();
//     _phoneNumber = TextEditingController();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final textTheme = Theme.of(context).textTheme;
//     return BlocProvider(
//       create: (context) => LoginCubit(),
//       child: BlocConsumer<LoginCubit, LoginState>(
//         listener: (context, state) {
//           // TODO: implement listener
//         },
//         builder: (context, state) {
//           return Scaffold(
//             body: Column(
//               children: [
//                 CustomVSpacer(20),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 10.w),
//                   child: TextField(
//                     controller: _phoneNumber,
//                     keyboardType: TextInputType.number,
//                     inputFormatters: [
//                       FilteringTextInputFormatter.digitsOnly,
//                     ],
//                     decoration: InputDecoration(
//                       labelText: 'Enter Phone number',
//                       // hintText: 'Enter Your Phone number',
//                     ),
//                   ),
//                 ),
//                 CustomEButton(
//                   onPressed: () {
//                     // LoginCubit.get(context).s
//                         // .veriftPhoneCode(_phoneNumber.text.trim());
//                   },
//                   title: 'login',
//                   textStyle: textTheme.headline5!,
//                   style: Theme.of(context).elevatedButtonTheme.style!,
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
