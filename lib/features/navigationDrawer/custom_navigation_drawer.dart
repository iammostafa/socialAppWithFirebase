import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:social_app/features/login/screens/login_screen.dart';
import 'package:social_app/features/main/cubit/main_cubit.dart';
import 'package:social_app/global/navigation.dart';
import 'package:social_app/global/spManager.dart';

class CustomNavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainCubitState>(
      listener: (context, state) {},
      builder: (context, state) {
        MainCubit cubit = MainCubit.get(context);
        return SafeArea(
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35),
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.80,
              child: Drawer(
                elevation: 0,
                child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: ListView(
                    // Important: Remove any padding from the ListView.
                    padding: EdgeInsets.zero,
                    children: [
                      drawerTopWidget(context),
                      drawerUserWidget(
                          context, cubit.user!.name, cubit.user!.photoUrl),
                      drawerListTile(
                          context, 'assets/images/Contacts.png', 'Contacts'),
                      drawerListTile(
                          context, 'assets/images/phone.png', 'Calls'),
                      drawerListTile(context, 'assets/images/inviteFriends.png',
                          'Save messages'),
                      drawerListTile(context, 'assets/images/bookMark.png',
                          'Invite Friends'),
                      drawerListTile(
                          context, 'assets/images/FAQ.png', 'Telegram FAQ'),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: CustomEButton(
                          onPressed: () async {
                            await FirebaseAuth.instance.signOut();
                            CacheHelper.deleteData(key: 'Token');
                            cubit.logout();
                            Navigation.goAndReplace(context, LoginScreen());
                          },
                          style: ButtonStyle(),
                          textStyle: Theme.of(context).textTheme.headline5!,
                          title: 'logout',
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget drawerListTile(BuildContext context, String image, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        leading: Image.asset(
          image,
          width: 25,
          height: 25,
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ),
    );
  }

  Container drawerUserWidget(
      BuildContext context, String name, String photoUrl) {
    return Container(
      height: 110,
      width: double.infinity,
      child: Row(
        children: [
          SizedBox(
            width: 15,
          ),
          ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: CachedNetworkImage(
                imageUrl: photoUrl,
                width: 82,
                height: 82,
                fit: BoxFit.cover,
              )),
          SizedBox(
            width: 15,
          ),
          Container(
              height: 50,
              width: 90,
              child: Center(
                child: Text(
                  name,
                  style: Theme.of(context).copyWith().textTheme.bodyText1,
                ),
              ))
        ],
      ),
    );
  }

  Row drawerTopWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Image.asset(
              'assets/images/back.png',
              width: 23,
              height: 23,
            )),
        IconButton(
            onPressed: () {},
            icon: Image.asset(
              'assets/images/Settings.png',
              width: 23,
              height: 23,
            )),
      ],
    );
  }
}
