  import 'package:flutter/material.dart';
import 'package:hadayek_hof/Modules/Stores/store_profile.dart';
import 'package:hadayek_hof/Shared/NavigationFunction/navigate_to.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../Cubit/cubit.dart';
import '../../Modules/Categore/all_categories.dart';

Widget buildSearchItem(HomeCubit cubit, BuildContext context, int index) => InkWell(
  onTap: ()  {
    cubit.getCategories(zoneName: cubit.zoneNames![index]);
    navigateTo(context, AllCategory(zoneIndex: index));
  },
  child: Card(
    elevation: 1,
    child: Container(
      decoration: BoxDecoration(
        color: HexColor('#081C31'),
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        border: Border.all(color: const Color(0xFFEDF0F2)),
      ),
      width: double.infinity,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                cubit.zoneNames![index],
                style: TextStyle(
                  color: HexColor('#ECB365'),
                  fontSize:  22,
                  fontWeight: FontWeight.normal ,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const Spacer(),
          Icon(Icons.arrow_forward_ios_outlined,color:HexColor('#ECB365')),
          const SizedBox(width: 5)
        ],
      ),
    ),
  ),
);
