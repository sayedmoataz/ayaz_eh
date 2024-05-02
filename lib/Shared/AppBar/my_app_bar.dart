import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

PreferredSizeWidget myAppBar() => AppBar(
  backgroundColor: HexColor('#081C31'),
  leading: Builder(
    builder: (BuildContext context) {
      return IconButton(
        icon: Icon(Icons.menu, color: HexColor('#ECB365')),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      );
    },
  ),
);