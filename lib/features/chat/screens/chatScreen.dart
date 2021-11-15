import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:social_app/features/chat/cubit/chat_cubit.dart';
import 'package:social_app/features/login/screens/login_screen.dart';
import 'package:social_app/features/user/models/user_model.dart';
import 'package:social_app/global/custom_colors.dart';
import 'package:social_app/global/globalWidgets.dart';
import 'package:social_app/main.dart';

class ChatScreen extends StatefulWidget {
  final UserModel? user;
  const ChatScreen({Key? key, this.user}) : super(key: key);
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late TextEditingController _controller;
  late ScrollController _scrollController;
  @override
  void initState() {
    _controller = TextEditingController();
    _scrollController = ScrollController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(),
      child: Builder(builder: (context) {
        ChatCubit.get(context).getMessages(
          widget.user!,
          tokenValue,
          widget.user!.uid,
        );
        return BlocConsumer<ChatCubit, ChatState>(
          listener: (context, state) {
          },
          builder: (context, state) {
            var cubit = ChatCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                elevation: 0,
                actions: [
                  SizedBox(
                    width: 100.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: Image.asset(
                                  'assets/images/back2.png',
                                  height: 20,
                                  width: 20,
                                )),
                            RoundedUserPicture(
                              userPicture: widget.user!.photoUrl,
                              width: 64,
                              height: 64,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${widget.user!.name}',
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                                Text(
                                  'Online',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: (){
                            print('ss');
                            cubit.addFriend(tokenValue!, tokenValue!, widget.user!.uid);
                          } ,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 19.0),
                            child: Image.asset(
                              'assets/images/Profile menu.png',
                              height: 20,
                              width: 20,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              body: SafeArea(
                child: Column(
                  children: [
                    state is ChatLoading
                        ? CircularProgressIndicator()
                        : CustomVSpacer(1.5),
                    Expanded(
                      child: ListView.separated(
                          shrinkWrap: true,
                          reverse: true,
                          controller: _scrollController,
                          itemBuilder: (c, i) {
                            return _textmessage(
                                context: context,
                                isSender: cubit.messagesList2[i].senderId ==
                                        tokenValue
                                    ? false
                                    : true,
                                text: cubit.messagesList2[i].message);
                          },
                          separatorBuilder: (c, i) => Divider(
                                color: Colors.transparent,
                              ),
                          itemCount: cubit.messagesList2.length),
                    ),
                    // Spacer(),
                    _chatTextField(context, widget.user!)
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }

  Row _textmessage(
      {required BuildContext context,
      required String text,
      required bool isSender}) {
    return Row(
      mainAxisAlignment:
          isSender == false ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        SizedBox(),
        Flexible(
            child: Container(
          margin: isSender == false
              ? EdgeInsets.only(right: 19)
              : EdgeInsets.only(left: 19),
          decoration: BoxDecoration(
              color: isSender == false
                  ? CustomColors.textChatColor
                  : CustomColors.primaryColor,
              borderRadius: isSender == false
                  ? BorderRadius.only(
                      topLeft: Radius.circular(35),
                      bottomLeft: Radius.circular(35),
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(35))
                  : BorderRadius.only(
                      topLeft: Radius.circular(35),
                      bottomLeft: Radius.circular(10),
                      topRight: Radius.circular(35),
                      bottomRight: Radius.circular(35))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
            child: Text(
              text,
              style: isSender == false
                  ? Theme.of(context).textTheme.headline6
                  : Theme.of(context).textTheme.headline5,
            ),
          ),
        )),
      ],
    );
  }

  Padding _chatTextField(BuildContext context, UserModel user) {
    return Padding(
      padding: EdgeInsets.only(
          right: 35,
          left: 35,
          top: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom == 0 ? 20 : 5),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFFFAFAFA),
            borderRadius: BorderRadius.circular(25),
          ),
          padding: EdgeInsets.only(left: 30),
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: MediaQuery.of(context).viewInsets.bottom == 0
                ? <Widget>[
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        maxLength: null,
                        onTap: () {
                          _scrollController.animateTo(
                              _scrollController.position.maxScrollExtent *
                                  -0.005,
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.fastOutSlowIn);
                        },
                        decoration: InputDecoration(
                            hintText: "Write message...",
                            hintStyle: Theme.of(context).textTheme.subtitle1,
                            border: InputBorder.none),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Row(
                        children: <Widget>[
                          IconButton(
                              onPressed: null,
                              icon: Image.asset(
                                'assets/images/plus.png',
                                width: 23,
                                height: 23,
                              )),
                          IconButton(
                              onPressed: null,
                              icon: Image.asset(
                                'assets/images/smile.png',
                                width: 23,
                                height: 23,
                              )),
                          IconButton(
                              onPressed: null,
                              icon: Image.asset(
                                'assets/images/Group 12.png',
                                width: 23,
                                height: 23,
                              )),
                        ],
                      ),
                    )
                  ]
                : <Widget>[
                    Expanded(
                      child: TextField(
                        maxLines: null,
                        onTap: () {
                          // _scrollController.position.maxScrollExtent * 2.0;
                        },
                        controller: _controller,
                        decoration: InputDecoration(
                            hintText: "Write message...",
                            hintStyle: Theme.of(context).textTheme.subtitle1,
                            border: InputBorder.none),
                      ),
                    ),
                    BlocConsumer<ChatCubit, ChatState>(
                      listener: (context, state) {
                      },
                      builder: (context, state) {
                        var cubit = ChatCubit.get(context);
                        return Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Row(
                            children: <Widget>[
                              IconButton(
                                  onPressed: () {
                                    cubit.sendMessage(
                                      user,
                                      tokenValue,
                                      user.uid,
                                      _controller.text,
                                    );
                                    _scrollController.animateTo(
                                        _scrollController
                                                .position.maxScrollExtent *
                                            -0.025,
                                        duration:
                                            const Duration(milliseconds: 400),
                                        curve: Curves.fastOutSlowIn);
                                    _controller.clear();
                                  },
                                  icon: Icon(Icons.send,
                                      color: CustomColors.primaryColor)),
                            ],
                          ),
                        );
                      },
                    )
                  ],
          ),
        ),
      ),
    );
  }
}
