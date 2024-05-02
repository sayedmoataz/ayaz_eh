

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hadayek_hof/Cubit/cubit.dart';
import 'package:hadayek_hof/Cubit/states.dart';
import 'package:hadayek_hof/core/app_strings.dart';
import 'package:hadayek_hof/models/firestore/new_dataModel.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../Shared/AppBar/my_app_bar.dart';
import '../../Shared/CustomIcons/custom_icons.dart';
import '../../Shared/drawer/my_drawer.dart';
import '../../Shared/image/cashed_images.dart';

class StoreProfile extends StatelessWidget {
  StoreProfile({super.key, required this.zoneId, required this.categoryId, required this.subCategoryId, required this.storeId, required this.storeData});
  int zoneId, categoryId,subCategoryId,storeId;
  Store storeData;
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var commentController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, states) {},
      builder: (context, states) {
        var cubit = HomeCubit.get(context);
        var size = MediaQuery.of(context).size;
        var height = size.height;
        var width = size.width;
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: myAppBar(),
            drawer: const MyDrawer(),
            body:
            // AppStrings.data[zoneId]['storeProfile'][categoryId][subCategoryId][storeId].isEmpty // cubit.oneStoreModel == null
            //   ? Center(child: CircularProgressIndicator(color: HexColor('#ECB365')))
            //   :
            Stack(
                children: <Widget>[
                  // store cover image
                  Column(
                    children: <Widget>[
                      AspectRatio(
                        aspectRatio: 1.8,
                        child: defaultNetworkImg(
                            context,
                            double.infinity,
                            double.infinity,
                            AppStrings.data[zoneId]['storesImage'][categoryId][subCategoryId][storeId],
                            BoxFit.cover,
                            0
                        )
                      ),
                    ],
                  ),
                  // store content
                  Positioned(
                    top: (width / 1.8) - 24.0, bottom: 0, left: 0, right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: const Color(0xFF3A5160).withOpacity(0.2),
                              offset: const Offset(1.1, 1.1),
                              blurRadius: 10.0
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: SingleChildScrollView(
                          child: Container(
                            constraints: BoxConstraints(
                                minHeight: 364.0,
                                maxHeight: height - (width / 1.8) + 24.0 > 364.0 ? height - (width / 1.8) + 24.0 : 364.0
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                // store name
                                Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.all(30.0),
                                    child: Text(
                                        storeData.name,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 22,
                                        letterSpacing: 0.27,
                                        color: Color(0xFF17262A),
                                      ),
                                    ),
                                  ),
                                ),
                                // store descripation
                                Padding(
                                  padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                                  child: Text(
                                    storeData.description,
                                    textAlign: TextAlign.justify,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontSize: 14,
                                      letterSpacing: 0.27,
                                      color: Color(0xFF3A5160),
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                // address word
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "العنوان",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 22,
                                      letterSpacing: 0.27,
                                      color: Color(0xFF17262A),
                                    ),
                                  ),
                                ),
                                // store address
                                Padding(
                                  padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                                  child: Text(
                                    storeData.address,
                                    textAlign: TextAlign.justify,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontSize: 14,
                                      letterSpacing: 0.27,
                                      color: Color(0xFF3A5160),
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                // store rate
                                // if(cubit.responseBodyAppSettingRate == "1")
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16, bottom: 16, right: 16),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Center(
                                          child: RatingBar(
                                            initialRating: AppStrings.data[zoneId]['storesRate'][categoryId][subCategoryId][storeId] ??2.5,
                                            direction: Axis.horizontal,
                                            textDirection: TextDirection.ltr,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            updateOnDrag: false,
                                            ignoreGestures: true,
                                            itemSize: 24,
                                            glowColor: HexColor('#081C31'),
                                            ratingWidget: RatingWidget(
                                              full: Icon(
                                                Icons.star_rate_rounded,
                                                color: HexColor('#081C31'),
                                              ),
                                              half: Icon(
                                                Icons.star_half_rounded,
                                                color: HexColor('#081C31'),
                                                textDirection: TextDirection.ltr
                                              ),
                                              empty: Icon(
                                                Icons.star_border_rounded,
                                                color: HexColor('#081C31'),
                                              ),
                                            ),
                                            itemPadding: EdgeInsets.zero,
                                            onRatingUpdate: (rating) { },
                                          ),
                                        ),
                                        // const SizedBox(width: 10),
                                        // Expanded(
                                        //   child: ElevatedButton(
                                        //     style: ElevatedButton.styleFrom(
                                        //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                        //       // primary: HexColor("#081C31")
                                        //         backgroundColor: HexColor("#081C31")
                                        //     ),
                                        //     onPressed: (){
                                        //       var userRate = RatingBar(
                                        //         initialRating: AppStrings.data[zoneId]['storesRate'][categoryId][subCategoryId][storeId] ??2.5,
                                        //         direction: Axis.horizontal,
                                        //         textDirection: TextDirection.ltr,
                                        //         allowHalfRating: true,
                                        //         itemCount: 5,
                                        //         updateOnDrag: false,
                                        //         itemSize: 24,
                                        //         glowColor: HexColor('#081C31'),
                                        //         ratingWidget: RatingWidget(
                                        //           full: Icon(
                                        //             Icons.star_rate_rounded,
                                        //             color: HexColor('#081C31'),
                                        //           ),
                                        //           half: Icon(
                                        //               Icons.star_half_rounded,
                                        //               color: HexColor('#081C31'),
                                        //               textDirection: TextDirection.ltr
                                        //           ),
                                        //           empty: Icon(
                                        //             Icons.star_border_rounded,
                                        //             color: HexColor('#081C31'),
                                        //           ),
                                        //         ),
                                        //         itemPadding: EdgeInsets.zero,
                                        //         onRatingUpdate: (rating) { AppStrings.data[zoneId]['storesRate'][categoryId][subCategoryId][storeId]  = rating; },
                                        //       );
                                        //       var userName = defaultTextFormFiel(
                                        //         context,
                                        //         nameController,
                                        //         TextInputType.name,
                                        //         "الأسم",
                                        //         1,
                                        //       );
                                        //       var userPhone = defaultTextFormFiel(
                                        //           context,
                                        //           phoneController,
                                        //           TextInputType.phone,
                                        //           'الهاتف',
                                        //         1
                                        //       );
                                        //       var userComment = defaultTextFormFiel(
                                        //         context,
                                        //         commentController,
                                        //         TextInputType.text,
                                        //         "التعليق",
                                        //         5,
                                        //       );
                                        //       var shareBtn = ElevatedButton(
                                        //         style: ElevatedButton.styleFrom(
                                        //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                        //             // primary: HexColor("#081C31")
                                        //             backgroundColor: HexColor("#081C31")
                                        //         ),
                                        //         child: const Text('نشر'),
                                        //         onPressed: () {
                                        //           // cubit.addStoreRate(
                                        //           //   nameController.text,
                                        //           //   usrRateValue.toString(),
                                        //           //   commentController.text,
                                        //           //   cubit.oneStoreModel!.id.toString(),
                                        //           //   phoneController.text,
                                        //           // )
                                        //           AppStrings.data[zoneId]['storesUserRateName'][categoryId][subCategoryId][storeId].add(nameController.text);
                                        //           AppStrings.data[zoneId]['storesUserRateMobile'][categoryId][subCategoryId][storeId].add(phoneController.text);
                                        //           AppStrings.data[zoneId]['storesUserRateComment'][categoryId][subCategoryId][storeId].add(commentController.text);
                                        //           AppStrings.data[zoneId]['storesRate'][categoryId][subCategoryId][storeId].add(usrRateValue)
                                        //
                                        //               .then((value) => Navigator.pop(context));
                                        //         },
                                        //       );
                                        //       showDialog(
                                        //         context: context,
                                        //         builder: (BuildContext context) =>Dialog(
                                        //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                        //           elevation: 0.0,
                                        //           backgroundColor: Colors.transparent,
                                        //           child: Stack(
                                        //             children: <Widget>[
                                        //               Container(
                                        //                 padding: const EdgeInsets.all(6),
                                        //                 decoration: BoxDecoration(
                                        //                   color: Colors.white,
                                        //                   shape: BoxShape.rectangle,
                                        //                   borderRadius: BorderRadius.circular(6),
                                        //                   boxShadow: const [
                                        //                     BoxShadow(color: Colors.black26,blurRadius: 10.0,offset: Offset(0.0,10.0)),
                                        //                   ],
                                        //                 ),
                                        //                 child: SingleChildScrollView(
                                        //                   child: Column(
                                        //                     mainAxisSize: MainAxisSize.min,
                                        //                     children: <Widget>[
                                        //                       Container(padding: const EdgeInsets.all(10), child: userRate),
                                        //                       Container(padding: const EdgeInsets.all(10), child: AppStrings.data[zoneId]['storesUserRateName'][categoryId][subCategoryId][storeId]),
                                        //                       Container(padding: const EdgeInsets.all(10),child: userPhone),
                                        //                       // if(cubit.responseBodyAppSettingComments == "1")
                                        //                         Container(padding: const EdgeInsets.all(10),child: userComment),
                                        //                       Container(padding: const EdgeInsets.all(10),child: shareBtn),
                                        //                     ],
                                        //                   ),
                                        //                 ),
                                        //               ),
                                        //             ],
                                        //           ),
                                        //         ),
                                        //       );
                                        //     },
                                        //     child: Text(
                                        //       "قيم المتجر",
                                        //       style: TextStyle(color: HexColor("#ECB365") ),
                                        //     )
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                // store comments
                                // if(cubit.responseBodyAppSettingComments == "1")
                                //   InkWell(
                                //   onTap: (){
                                //     cubit.showModalSheet(context, zoneId, categoryId,subCategoryId,storeId);
                                //   },
                                //   child: const Row(
                                //     mainAxisAlignment: MainAxisAlignment.center,
                                //     crossAxisAlignment: CrossAxisAlignment.center,
                                //     children: [
                                //       Text(
                                //         "عرض جميع التعليقات",
                                //         textAlign: TextAlign.left,
                                //         style: TextStyle(
                                //       fontWeight: FontWeight.w600,
                                //       fontSize: 22,
                                //       letterSpacing: 0.27,
                                //       color: Color(0xFF17262A),
                                //         ),
                                //       ),
                                //       SizedBox(width: 5),
                                //       Icon(Icons.arrow_forward),
                                //     ],
                                //   ),
                                // ),
                                // SizedBox(height: MediaQuery.of(context).padding.bottom)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // store social icons
                  Positioned(
                    top: (width / 1.8) - 24.0 - 20,right: width*.1,left: width*.1,
                    child: Align(
                      alignment: Alignment.center,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Wrap(
                          children: [
                            // phone
                            if(AppStrings.data[zoneId]['storesPhone'][categoryId][subCategoryId][storeId] != "")
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(50.0),color: HexColor('#081C31')),
                                width: 35,
                                height: 35,
                                child: Center(
                                  child: IconButton(
                                    onPressed: () {
                                        cubit.makePhoneCall(storeData.phone);
                                      // showDialog(
                                      //   context: context,
                                      //   builder: (BuildContext context) =>Dialog(
                                      //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                      //     elevation: 0.0,
                                      //     backgroundColor: Colors.transparent,
                                      //     child: Stack(
                                      //       children: <Widget>[
                                      //         Container(
                                      //           padding: const EdgeInsets.all(6),
                                      //           decoration: BoxDecoration(
                                      //             color: Colors.white,
                                      //             shape: BoxShape.rectangle,
                                      //             borderRadius: BorderRadius.circular(6),
                                      //             boxShadow: const [
                                      //               BoxShadow(color: Colors.black26,blurRadius: 10.0,offset: Offset(0.0,10.0)),
                                      //             ],
                                      //           ),
                                      //           child: buildPhoneItemRTL(
                                      //             context,
                                      //               AppStrings.data[zoneId]['storesPhone'][categoryId][subCategoryId][storeId].toString(), // cubit.oneStoreModel!.phone.toString(),
                                      //               (){
                                      //               cubit.makePhoneCall(AppStrings.data[zoneId]['storesPhone'][categoryId][subCategoryId][storeId].toString());
                                      //               },
                                      //             1
                                      //           ),
                                      //         ),
                                      //       ],
                                      //     ),
                                      //   ),
                                      // );
                                    },
                                    icon: Icon(NewIconsForApp.phone,color: HexColor('#ECB365') , size: 20)
                                  )
                                ),
                              ),
                            ),
                            // whats app
                            // if (cubit.oneStoreModel!.whatsapp !='')
                            if(AppStrings.data[zoneId]['storesWhatsapp'][categoryId][subCategoryId][storeId] != '')
                              Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(50.0),color: HexColor('#081C31')),
                                width: 35,
                                height: 35,
                                child: Center(
                                    child: IconButton(
                                        onPressed: () {
                                          cubit.whatsAppOpen(storeData.whatsapp);
                                        },
                                        icon:Icon(NewIconsForApp.whatsapp,color: HexColor('#ECB365'), size: 20),
                                    )
                                ),
                              ),
                            ),
                            // face book
                            // if (cubit.oneStoreModel!.facebook !='')
                            if(AppStrings.data[zoneId]['storesFacebook'][categoryId][subCategoryId][storeId]  != '')
                              Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(50.0),color: HexColor('#081C31')),
                                width: 35,
                                height: 35,
                                child: Center(
                                    child: IconButton(
                                      onPressed: () {
                                        cubit.openFaceBook(storeData.facebook);
                                      },
                                      icon:Icon(NewIconsForApp.facebook,color: HexColor('#ECB365'), size: 20),
                                    )
                                ),
                              ),
                            ),
                            // instagram
                            // if (cubit.oneStoreModel!.youtube !='')
                            if(AppStrings.data[zoneId]['storesInstagram'][categoryId][subCategoryId][storeId] != '')
                              Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(50.0),color: HexColor('#081C31')),
                                width: 35,
                                height: 35,
                                child: Center(
                                    child: IconButton(
                                      onPressed: () {
                                        cubit.launchInstagram(storeData.instagram,storeData.instagram);
                                      },
                                      icon:Icon(NewIconsForApp.instagram,color: HexColor('#ECB365'), size: 20),
                                    )
                                ),
                              ),
                            ),
                            // web site
                            // if (cubit.oneStoreModel!.website !='')
                            if(AppStrings.data[zoneId]['storesWebsite'][categoryId][subCategoryId][storeId]  != '')
                              Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(50.0),color: HexColor('#081C31')),
                                width: 35,
                                height: 35,
                                child: Center(
                                    child: IconButton(
                                      onPressed: () {
                                        cubit.launchInBrowser(Uri.parse(storeData.website));
                                      },
                                      icon:Icon(Icons.wordpress,color: HexColor('#ECB365'), size: 20),
                                    )
                                ),
                              ),
                            ),
                            // maps
                            // if (cubit.oneStoreModel!.location !='')
                            if(AppStrings.data[zoneId]['storesMapLat'][categoryId][subCategoryId][storeId]  != '' ||AppStrings.data[zoneId]['storesMapLong'][categoryId][subCategoryId][storeId] != '' )
                              Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(50.0),color: HexColor('#081C31')),
                                width: 35,
                                height: 35,
                                child: Center(
                                    child: IconButton(
                                      onPressed: () {
                                        cubit.launchMap(link:storeData.location);
                                      },
                                      icon:Icon(NewIconsForApp.google_maps,color: HexColor('#ECB365'), size: 20),
                                    )
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          )
        );
      }
    );
  }
}
