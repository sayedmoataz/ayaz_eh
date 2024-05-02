import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadayek_hof/Cubit/cubit.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../Modules/AllZones/search_screen.dart';
import '../../Modules/AllZones/zones_screen.dart';

PreferredSizeWidget searchAppBar(BuildContext context) => AppBar(
  backgroundColor: HexColor('#081C31'),
  actions: [
    Padding(
      padding: const EdgeInsets.all(5),
      child: IconButton(
        icon: Icon(Icons.search,color: HexColor('#ECB365')),
        onPressed: () => 
        
        
        Navigator.push(
          context,
          // MaterialPageRoute(
          //   builder: ((context) => BlocProvider(
          //         create: (context) => HomeCubit(),
          //         child: const SearchScreen(),
          //       )))
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => SearchScreen(),
            transitionDuration: const Duration(milliseconds: 500),
            transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
          ),
        )
      )
    )
  ],
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