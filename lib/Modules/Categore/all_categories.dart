
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadayek_hof/Shared/NavigationFunction/navigate_to.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../Cubit/cubit.dart';
import '../../Cubit/states.dart';
import '../../Shared/AppBar/my_app_bar.dart';
import '../../Shared/drawer/my_drawer.dart';
import '../../core/app_strings.dart';
import 'sub_category.dart';


class AllCategory extends StatelessWidget {
  const AllCategory({super.key, required this.zoneIndex});
  final int zoneIndex;
  @override
  Widget build(BuildContext context) {
    var size, height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return Directionality(
              textDirection:TextDirection.rtl,
              child:  Scaffold(
                  appBar: myAppBar(),
                  drawer: const MyDrawer(),
                  body: 
                  cubit.categoryStructure.isEmpty ? 
                  const Center(child: CircularProgressIndicator()) 
                  : ListView.builder(
                      itemCount: cubit.categoryStructure.length,
                      itemBuilder: (context, index) => buildCategoryItem(index,zoneIndex, cubit, context, height, width, cubit.categoryStructure.keys.toList())
                  )
              )
          );
        }
    );
  }

  Widget buildCategoryItem(int index, int zoneIndex, HomeCubit cubit, BuildContext context,double heightx, double widthx, var allCategoriesList) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: heightx * .15,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: HexColor('#081C31'),
        ),
        child: InkWell(
          onTap: () {
            cubit.showSubCategories(allCategoriesList[index]);
            navigateTo(context, SubCategory(index,zoneIndex));
          },
          child: Row(
            children: [
              // category icon
              Padding(
                padding: const EdgeInsets.all(10),
                child: CachedNetworkImage(
                  width: 50,
                  height: double.infinity,
                  imageUrl: AppStrings.offerImages[index],
                  fit: BoxFit.contain,
                  alignment: Alignment.centerRight,
                  errorWidget: (context, url, error) => Icon(Icons.error,size: 50,color: HexColor('#ECB365')),
                ),
              ),
              // category name
              Flexible(
                child: Text(
                  allCategoriesList[index], 
                  maxLines: 2,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'HSNIbtisam',
                      height: 1
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
