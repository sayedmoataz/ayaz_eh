import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../core/app_strings.dart';



Widget buildCommentItemRTL(BuildContext context, int zoneId, categoryId,subCategoryId,storeId, double? elevation) {
  return Padding(
    padding: const EdgeInsets.all(5),
    child: Container(
      decoration: BoxDecoration(
        color: HexColor('#081C31'),
        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
      ),
      width: double.infinity,
      height: 150,
      child: ListView.builder(
        itemCount: AppStrings.data[zoneId]['storesUserRateName'][categoryId][subCategoryId][storeId].length,
          shrinkWrap: true,
          itemBuilder: (context,index){
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.data[zoneId]['storesUserRateName'][categoryId][subCategoryId][storeId][index], // name,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                      // RatingBar(
                      //   initialRating: AppStrings.data[zoneId]['storesRate'][categoryId][subCategoryId][storeId][index]?? 2.5,
                      //   direction: Axis.horizontal,
                      //   textDirection: TextDirection.ltr,
                      //   allowHalfRating: true,
                      //   itemCount: 5,
                      //   updateOnDrag: false,
                      //   ignoreGestures: true,
                      //   itemSize: 24,
                      //   glowColor: Colors.deepOrange,
                      //   ratingWidget: RatingWidget(
                      //     full: Icon(
                      //       Icons.star_rate_rounded,
                      //       color: Colors.deepOrange,
                      //     ),
                      //     half: Icon(
                      //         Icons.star_half_rounded,
                      //         color: Colors.deepOrange,
                      //         textDirection: TextDirection.ltr
                      //     ),
                      //     empty: Icon(
                      //       Icons.star_border_rounded,
                      //       color: Colors.deepOrange,
                      //     ),
                      //   ),
                      //   itemPadding: EdgeInsets.zero,
                      //   onRatingUpdate: (rating) { },
                      // ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    AppStrings.data[zoneId]['storesUserRateComment'][categoryId][subCategoryId][storeId][index],
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

              ],
            );
          }
      )
    ),
  );
}
