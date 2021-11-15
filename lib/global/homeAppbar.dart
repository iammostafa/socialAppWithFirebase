import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;
  final GlobalKey<ScaffoldState> keyk;

  /// you can add more fields that meet your needs

  const HomeAppBar({required this.appBar, required this.keyk});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: SizedBox(
            width: 93.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Telegram',
                    style: Theme.of(context).copyWith().textTheme.headline1),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.39,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Image.asset(
                            'assets/images/plus.png',
                            width: 23,
                            height: 23,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: Image.asset(
                            'assets/images/search.png',
                            width: 23,
                            height: 23,
                          )),
                      IconButton(
                          onPressed: () => keyk.currentState!.openEndDrawer(),
                          icon: Image.asset(
                            'assets/images/menu.png',
                            width: 23,
                            height: 23,
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}
