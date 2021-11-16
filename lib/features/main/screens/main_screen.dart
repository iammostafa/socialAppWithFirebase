import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/chat/cubit/chat_cubit.dart';
import 'package:social_app/features/chat/screens/chatScreen.dart';
import 'package:social_app/features/main/cubit/main_cubit.dart';
import 'package:social_app/features/navigationDrawer/custom_navigation_drawer.dart';
import 'package:social_app/features/user/models/user_model.dart';
import 'package:social_app/global/custom_colors.dart';
import 'package:social_app/global/globalWidgets.dart';
import 'package:sizer/sizer.dart';
import 'package:social_app/global/homeAppbar.dart';
import 'package:social_app/main.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<ScaffoldState> keyk = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit()..getUserData(tokenValue),
      child: BlocProvider(
        create: (context) => ChatCubit(),
        child: Scaffold(
          drawerScrimColor: Colors.transparent,
          key: keyk,
          appBar: HomeAppBar(appBar: AppBar(), keyk: keyk),
          endDrawer: CustomNavigationDrawer(),
          body: BlocConsumer<MainCubit, MainCubitState>(
            listener: (context, state) {},
            builder: (context, state) {
              MainCubit cubit = MainCubit.get(context);
              if (state is MainCubitLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is MainCubitSuccess) {
                return Column(children: [
                  RefreshIndicator(
                    onRefresh: () => cubit.getUserData(tokenValue),
                    child: ListView.builder(
                      itemBuilder: (c, i) {
                        return _buildChatCard(cubit.users![i]);
                      },
                      shrinkWrap: true,
                      itemCount: cubit.users!.length,
                    ),
                  ),
                ]);
              } else {
                return Center(child: Text('data'));
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildChatCard(UserModel user) {
    final TextTheme txTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChatScreen(
                  user: user,
                )),
      ),
      child: Card(
        elevation: 0,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 70.w,
                child: Row(
                  children: [
                    RoundedUserPicture(
                      userPicture: user.photoUrl,
                    ),
                    SizedBox(width: 3.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name,
                          style: txTheme.headline3,
                        ),
                        SizedBox(height: .05.w),
                        SizedBox(
                          width: 45.w,
                          child: Text(
                            'Hi, bro! Come to my house!',
                            style: txTheme.caption,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '10:10',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(height: .05.w),
                  CircleAvatar(
                    backgroundColor: CustomColors.primaryColor,
                    radius: 12,
                    child: Text(
                      '1',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 9.sp,
                          fontFamily: 'Gilory',
                          fontWeight: FontWeight.w700),
                    ),
                  )
                  // Text('Message', style: Theme.of(context).textTheme.subtitle1,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
