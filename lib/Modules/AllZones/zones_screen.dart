

// ignore_for_file: prefer_typing_uninitialized_variables


import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadayek_hof/Shared/image/cashed_images.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../Cubit/cubit.dart';
import '../../Cubit/states.dart';
import '../../Shared/AllZonesWidgets/zone_item.dart';
import '../../Shared/AppBar/my_app_bar.dart';
import '../../Shared/AppBar/search_app_bar.dart';
import '../../Shared/NavigationFunction/navigate_to.dart';
import '../../Shared/drawer/my_drawer.dart';
import '../../core/app_strings.dart';
import '../Categore/all_categories.dart';
import '../Drawer/one_offer.dart';


class ZonesScreen extends StatefulWidget {
  const ZonesScreen({super.key});

  @override
  State<ZonesScreen> createState() => _ZonesScreenState();
}

class _ZonesScreenState extends State<ZonesScreen> {
  var size, height, width;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white,
              appBar: searchAppBar(context), // myAppBar(),
              drawer: const MyDrawer(),
              body:  cubit.zoneNames == null || cubit.offerItems == null
                ? const Center(child: CircularProgressIndicator()) 
                : cubit.zoneNames!.isEmpty || cubit.offerItems!.isEmpty
                  ? const Center(child: CircularProgressIndicator()) 
                  : Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'اكتشف خدماتنا',
                          style: TextStyle(
                            fontSize: 28,
                            color: HexColor('#081C31'),
                            fontWeight: FontWeight.bold,
                            fontFamily:'HSNIbtisam',
                            height: 1,
                          ),
                        ),
                        SizedBox(height: height * .01),
                        CarouselSlider(
                          items: List.generate(
                            cubit.offerItems!.length,
                            (i) => InkWell(
                              onTap: () => navigateTo(context, OneOffer(index: i,)),
                              child: Stack(
                                children: [
                                  defaultNetworkImg(
                                    context,
                                    double.infinity,
                                    double.infinity,
                                    cubit.offerItems![i].offerImages.first,
                                    BoxFit.cover,
                                    0
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text(
                                      cubit.offerItems![i].storeName,
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                        height: 1,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ),
                          options: CarouselOptions(
                          height: MediaQuery.of(context).size.height * .30,
                          aspectRatio: 1.0,
                          viewportFraction: 1.0,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration: const Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                        )
                        ),
                        const Divider(),
                        SizedBox(height : height * .03),
                        Expanded(
                          child: CustomScrollView(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            slivers: [
                              SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                    (context, index) =>index % 2 == 0 
                                      ? buildPlaceItemRTL(
                                        index ,
                                        context,
                                        AppStrings.data[0]['zoneImage'] ?? 'جاري التحميل',
                                        cubit.zoneNames![index],
                                        (){
                                          cubit.getCategories(zoneName: cubit.zoneNames![index]);
                                          navigateTo(context, AllCategory(zoneIndex: index));
                                        },
                                        5
                                      )
                                      : buildPlaceItemLTR(
                                        index ,
                                        context,
                                        AppStrings.data[0]['zoneImage'] ?? 'جاري التحميل', 
                                        cubit.zoneNames![index],
                                        (){
                                          cubit.getCategories(zoneName: cubit.zoneNames![index]);
                                          navigateTo(context, AllCategory(zoneIndex: index));
                                        },
                                        5
                                    ),
                                    childCount: cubit.zoneNames?.length,
                                  )
                                )
                            ],
                          ),
                        ),
                  ]),
              ))
        );
      },
    );
  }


}
