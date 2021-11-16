import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RoundedUserPicture extends StatelessWidget {
  final double width, height;
  final String userPicture;
  const RoundedUserPicture({
    Key? key,
    this.height = 72,
    this.width = 72,
    this.userPicture = 'assets/images/person1.jpeg',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.all(
            height > 80 ? Radius.circular(30) : Radius.circular(23)),
        child: userPicture != ''
            ? CachedNetworkImage(
                imageUrl: userPicture,
                width: width,
                height: height,
                fit: BoxFit.cover,
              )
            : Image.asset(
                'assets/images/person1.jpeg',
                width: width,
                height: height,
                fit: BoxFit.cover,
              ));
  }
}
