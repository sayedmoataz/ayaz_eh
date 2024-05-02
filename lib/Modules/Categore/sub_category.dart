


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadayek_hof/Shared/NavigationFunction/navigate_to.dart';

import '../../Cubit/cubit.dart';
import '../../Cubit/states.dart';
import '../../Shared/AppBar/my_app_bar.dart';
import '../../Shared/CategoryWidgets/sub_category_view.dart';
import '../../Shared/drawer/my_drawer.dart';
import '../Stores/store.dart';

class SubCategory extends StatelessWidget {
  final int zoneId;
  final int Zoneindex;

  const SubCategory(this.zoneId,this.Zoneindex, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                appBar: myAppBar(),
                drawer: const MyDrawer(),
                body:
                cubit.allSubCategory.isEmpty
                    ? const Center(
                      child: Text(
                      'لم نقم بإضافة خدمات بعد',
                      maxLines: 2,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'HSNIbtisam',
                          height: 1
                      ),
                    ),)
                    : GridView(
                  padding: const EdgeInsets.all(8),
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 32.0,
                    crossAxisSpacing: 32.0,
                    childAspectRatio: 0.8,
                  ),
                  children: List.generate(
                    cubit.allSubCategory.length, 
                        (int index) => subCategoryView(
                      callback: () async{
                        
                        await cubit.fetchStores(
                          cubit.zoneNames![Zoneindex].toString(),
                          cubit.categoryStructure.keys.toList()[index].toString(),
                          cubit.allSubCategory[index].toString()
                        );
                        navigateTo(context, CategoryDetails(zoneIndex: Zoneindex,categoryIndex: zoneId,subCategoryIndex:index));
                      },
                      subCategory: cubit.allSubCategory,
                      index: index,
                      zoneId : zoneId
                    ),
                  ),
                )
              )
          );
        }
    );
  }
}
