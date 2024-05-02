import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadayek_hof/Cubit/cubit.dart';
import 'package:hadayek_hof/Cubit/states.dart';
import 'package:hadayek_hof/core/app_strings.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../Shared/AppBar/my_app_bar.dart';
import '../../Shared/NavigationFunction/navigate_to.dart';
import '../../Shared/StroresWidgets/store_widget.dart';
import '../../Shared/drawer/my_drawer.dart';
import 'store_profile.dart';

class CategoryDetails extends StatelessWidget {
  CategoryDetails({required this.zoneIndex,required this.categoryIndex,required this.subCategoryIndex, super.key});
  int zoneIndex;
  int categoryIndex;
  int subCategoryIndex;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, states){ },
        builder: (context, states){
          var cubit = HomeCubit.get(context);
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: myAppBar(),
              drawer: const MyDrawer(),
              body: cubit.stores.isEmpty
                  ? Center(child: CircularProgressIndicator(color: HexColor('#ECB365')))
                  : SingleChildScrollView(
                child: Container(
                  color:const Color(0xFFFFFFFF),
                  child: CustomScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      slivers: [
                      SliverList(
                      delegate: SliverChildBuilderDelegate(
                      (context, index) =>
                        SubCategoryDetails(
                          cubit: cubit,
                        callback: () {
                          // cubit.getStoreProfile(cubit.responseBodyServices[index]["id"].toString());
                          // cubit.getStoreRate(cubit.responseBodyServices[index]["id"].toString());
                          navigateTo(context, StoreProfile(zoneId:zoneIndex, categoryId:categoryIndex, subCategoryId:subCategoryIndex, storeId:index, storeData: cubit.stores[index]));
                        },
                        image: AppStrings.image,
                        padding:5 ,
                        rate: 2.5, 
                        reviews: 28 ,
                        storeID: cubit.data['id'].toString(), 
                        titleTxt: cubit.stores[index].name.toString(),
                        subTxt: cubit.stores[index].description.toString(),
                      ),
                          childCount: cubit.stores.length
                      ),
                      ),
                      ],
                  ),
                  ),
              ),
              ),

          );
        },
    );
  }
}
