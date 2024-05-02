import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

PreferredSizeWidget shareAppBar() => AppBar(
  backgroundColor: HexColor('#081C31'),
  leading: Builder(
    builder: (BuildContext context) {
      return IconButton(
        icon: Icon(Icons.arrow_back_ios, color: HexColor('#ECB365')),
        onPressed: () {
          Navigator.pop(context);
        },
      );
    },
  ),
  actions: [
    IconButton(onPressed: (){}, icon: Icon(Icons.share, color: HexColor('#ECB365')))
  ],
);