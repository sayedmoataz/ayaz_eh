import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hadayek_hof/Cubit/cubit.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../Modules/Categore/all_categories.dart';
import '../NavigationFunction/navigate_to.dart';

Widget RTLContainer(HomeCubit cubit, int index, BuildContext context) =>
    Container(
      clipBehavior: Clip.antiAlias,
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      child: Stack(
          alignment: Alignment.center,
          children: [
        CachedNetworkImage(
          errorWidget: (context, string, dynamic) =>
              Icon(Icons.error, size: 100, color: HexColor('#ECB365')),
          imageUrl: cubit.responseBodyGetZones[index]['img'].toString(),
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.black12,
            border: Border.all(color: HexColor('#ECB365'), width: 3),
          ),
        ),
        InkWell(
            onTap: () {
              cubit
                  .getCategoriesData(cubit.responseBodyGetZones[index]['id'])
                  .then((value) {
                navigateTo(context, AllCategory(zoneIndex: index));
              });
            },
            child: Center(
                child: Text(
              cubit.responseBodyGetZones[index]['ar_name'] ??
                  "Error Fetching Data",
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'HSNIbtisam',
                  height: 1),
            ))),
      ]),
    );
