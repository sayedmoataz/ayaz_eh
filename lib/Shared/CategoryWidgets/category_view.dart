import 'package:flutter/material.dart';
import 'package:hadayek_hof/Shared/image/cashed_images.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../Cubit/cubit.dart';

class CategoryView extends StatelessWidget {
  CategoryView({super.key,
    required this.cubit,
    this.callback,
    required this.index});

  final VoidCallback? callback;
  HomeCubit cubit;
  int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
                splashColor: Colors.transparent,
                onTap: callback,
                child: SizedBox(
                  height: 280,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: <Widget>[
                      Container(
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: HexColor('#F8FAFB'),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(16.0)),
                                  border: Border.all(color: const Color(0xFFEDF0F2)),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        child: Column(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                                              child: Text(
                                                cubit.responseBodyCategories[index]['ar_name'],
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16,
                                                    letterSpacing: 0.27,

                                                    color: Color(0xFF17262A)
                                                ),
                                              ),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.only(top: 4, left: 8, right: 8),
                                              child: Align(
                                                alignment: Alignment.centerRight,
                                                child: Text(
                                                  '       ',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight
                                                        .w200,
                                                    fontSize: 12,
                                                    letterSpacing: 0.27,
                                                    color: Color(0xFF3A5160),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 48),
                          ],
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding:
                          const EdgeInsets.only(top: 24, right: 16, left: 16),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(16.0)),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: const Color(0xFF3A5160).withOpacity(0.5),
                                    offset: const Offset(0.0, 0.0),
                                    blurRadius: 6.0),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius:
                              const BorderRadius.all(Radius.circular(16.0)),
                              child: AspectRatio(
                                aspectRatio: 1.28,
                                child: defaultNetworkImg(
                                    context,
                                    50,
                                    50,
                                    cubit.responseBodyCategories[index]['img'].toString(),
                                    BoxFit.contain,
                                    0)
                                /*CachedNetworkImage(
                                  width: 50,
                                  height: double.infinity,
                                  imageUrl: cubit.responseBodyCategories[index]['img'].toString(),
                                  fit: BoxFit.contain,
                                  //placeholder: (context, url) =>CircularProgressIndicator(color: HexColor('#ECB365')),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error, size: 50,
                                          color: HexColor('#ECB365')),
                                )*/,),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
  }
}
