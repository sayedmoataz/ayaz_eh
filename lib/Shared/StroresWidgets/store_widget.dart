
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hadayek_hof/Cubit/cubit.dart';
import 'package:hadayek_hof/Shared/image/cashed_images.dart';
import 'package:hexcolor/hexcolor.dart';

class SubCategoryDetails extends StatelessWidget {
  SubCategoryDetails({
    super.key,
    required this.cubit,
    required this.callback,
    required this.image,
    required this.padding,
    required this.titleTxt,
    required this.subTxt,
    required this.storeID,
    this.rate,
    required this.reviews,
  });
  HomeCubit cubit;
  final VoidCallback callback;
  final String image;
  final double padding;
  final String titleTxt;
  String storeID;
  final String subTxt;
  double? rate;
  final int reviews;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 16),
      child: InkWell(
        splashColor: Colors.transparent,
        onTap: callback,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey.withOpacity(0.6),
                offset: const Offset(4, 4),
                blurRadius: 16,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 2,
                      child: defaultNetworkImg(context,
                        double.infinity,
                        double.infinity,
                        image,
                        BoxFit.cover,
                        padding,
                      ),
                    ),
                    Container(
                      color: const Color(0xFFFFFFFF),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      titleTxt,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 22,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      subTxt,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey
                                              .withOpacity(0.8)),
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  Center(
                                    child: Text(
                                      storeID,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
               /*Positioned(
                  top: 8,
                  right: 8,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(32.0),
                      ),
                      onTap: () { },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.favorite_border,
                          color: HexColor('#081C31'),
                        ),
                      ),
                    ),
                  ),
                )*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
