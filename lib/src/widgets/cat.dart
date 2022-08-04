import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Cat extends StatelessWidget
{
  const Cat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) 
  {
    return CachedNetworkImage(
      placeholder: (context, url) => const CircularProgressIndicator(),
      imageUrl: 'https://beeimg.com/images/p50200193861.png',
    );
  }
}