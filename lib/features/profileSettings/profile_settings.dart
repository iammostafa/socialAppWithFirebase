import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:social_app/features/user/models/user_model.dart';
import 'package:social_app/global/globalWidgets.dart';

class ProfileSettings extends StatelessWidget {
  final UserModel userModel;
  const ProfileSettings({Key? key, required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: EdgeInsets.all(11.sp),
            child: Image.asset(
              'assets/images/back2.png',

              // fit: BoxFit.scaleDown,
            ),
          ),
        ),
        actions: [
          SizedBox(
            width: 14.w,
          ),
          Center(
            child: SizedBox(
              width: 59.w,
              child: Text(
                userModel.name,
                style: Theme.of(context).textTheme.subtitle2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Expanded(child: SizedBox())
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 4.h,
              ),
              Container(
                  child: Row(
                children: [
                  RoundedUserPicture(
                    height: 82,
                    width: 82,
                    userPicture: userModel.photoUrl,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(userModel.name,
                          style: Theme.of(context).textTheme.headline3),
                      Text(userModel.email,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(fontSize: 14.sp)),
                    ],
                  ),
                ],
              )),
              SizedBox(
                height: 4.h,
              ),
              Text(
                'Account',
                style: Theme.of(context).textTheme.headline3,
              ),
              SizedBox(
                height: 1.5.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userModel.email,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox( 
                    height: 0.8.h,
                  ),
                  Text(
                    'Tap to change email',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              Divider(
                color: Colors.grey.withOpacity(0.5),
                thickness: 1,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    '@iammosstafa',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 0.8.h,
                  ),
                  Text(
                    'Username',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              Divider(
                color: Colors.grey.withOpacity(0.5),
                thickness: 1,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    'I’m Senior Frontend Developer',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 0.8.h,
                  ),
                  Text(
                    'Bio',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
              SizedBox(
                height: 3.h,
              ),
              Text(
                'Settings',
                style: Theme.of(context).textTheme.headline3,
              ),
              SizedBox(
                height: 1.5.h,
              ),
              _settingsTile('assets/images/Union.png',
                  'Notification and Sounds', context),
              _settingsTile(
                  'assets/images/Group 5.png', 'Privaty and Security', context),
              _settingsTile(
                  'assets/images/Group 6.png', 'Data and Stronge', context),
              _settingsTile('assets/images/Chat.png', 'Chat settings', context),
              _settingsTile('assets/images/Device.png', 'Devices', context),
            ],
          ),
        ),
      ),
    );
  }

  Row _settingsTile(String icon, String title, context) => Row(children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 2.w),
          child: SizedBox(
              child: Image.asset(
            icon,
            width: 30,
            height: 30,
          )),
        ),
        SizedBox(
          width: 5.w,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        )
      ]);
}
