

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadayek_hof/Modules/AllZones/zones_screen.dart';
import 'package:hadayek_hof/Modules/Drawer/all_news.dart';
import 'package:hadayek_hof/Shared/NavigationFunction/navigate_to.dart';
import 'package:hadayek_hof/core/app_strings.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../Cubit/cubit.dart';
import '../../Cubit/states.dart';
import '../../Modules/Drawer/all_offers.dart';
import '../../Modules/Drawer/join_us.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return SafeArea(
            child: Drawer(
              child: Container(
                // gradient
                decoration:  BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      HexColor('#081C31'),
                      HexColor('#074763')
                    ],
                  ),
                ),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    // header
                    DrawerHeader(
                      decoration: BoxDecoration(color: HexColor('#081C31')),
                      child: Image.network(
                          // 'assets/logo/hadek-7of-2.png',
                        AppStrings.image,
                          fit: BoxFit.cover
                      ),
                    ),
                    // home page
                    ListTile(
                      iconColor: HexColor('#ECB365'),
                      textColor: HexColor('#ECB365'),
                      leading: const Icon(Icons.home),
                      title:const  Text(
                        'الصفحة الرئيسية',
                        style: TextStyle(
                          fontSize:  24,
                          fontFamily:'HSNIbtisam',
                          fontWeight:  FontWeight.normal,
                          height: 1,
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ZonesScreen()),
                        );
                      },
                    ),
                    // hot offers
                    ListTile(
                      iconColor: HexColor('#ECB365'),
                      textColor: HexColor('#ECB365'),
                      leading: const Icon(Icons.local_offer),
                      title:const Text(
                        "عروض و خصومات",
                        style: TextStyle(
                          fontSize:  24,
                          fontFamily: 'HSNIbtisam',
                          fontWeight:  FontWeight.normal,
                          height: 1,
                        ),
                      ),
                      onTap: () async {
                        await cubit.fetchOfferItems();
                        navigateTo(context, const AllOffers());
                      },
                    ),
                    // city news
                    ListTile(
                      iconColor: HexColor('#ECB365'),
                      textColor: HexColor('#ECB365'),
                      leading: const Icon(Icons.maps_home_work),
                      title: const Text(
                        "اخر الاخبار",
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'HSNIbtisam',
                          fontWeight:  FontWeight.normal,
                          height: 1,
                        ),
                      ),
                      onTap: () async{
                        await cubit.fetchNewsItems();
                        navigateTo(context, const AllNews());
                      },
                    ),
                    // search
                    // ListTile(
                    //   iconColor: HexColor('#ECB365'),
                    //   textColor: HexColor('#ECB365'),
                    //   leading: const Icon(Icons.search),
                    //   title: const Text(
                    //     'ابحث عن اسم المتجر',
                    //     style: TextStyle(
                    //       fontSize: 24,
                    //       fontFamily: 'HSNIbtisam',
                    //       fontWeight:  FontWeight.normal,
                    //       height: 1,
                    //     ),
                    //   ),
                    //   onTap: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute( builder: (context) => SearchScreen()),
                    //     );
                    //   },
                    // ),
                    const Divider(thickness: 3, indent: 15, endIndent: 15),
                    // join us
                    ListTile(
                      iconColor: HexColor('#ECB365'),
                      textColor: HexColor('#ECB365'),
                      leading: const Icon(Icons.local_offer_outlined),
                      title: const Text(
                        "اعلن عن خدمتك معنا",
                        style: TextStyle(
                          fontSize:  24,
                          fontFamily: 'HSNIbtisam',
                          fontWeight:  FontWeight.normal,
                          height: 1,
                        ),
                      ),
                      onTap: () {
                        // launchUrl(Uri.parse("https://hadayekhof.com/"));
                        navigateTo(context, JoinUs());
                      },
                    ),
                    // رأيك يهمنك
                    // about us
                    ListTile(
                        iconColor: HexColor('#ECB365'),
                        textColor: HexColor('#ECB365'),
                        leading: const Icon(Icons.info),
                        title: const Text(
                          "معلومات عنا",
                          style: TextStyle(
                            fontSize:24,
                            fontFamily:'HSNIbtisam',
                            fontWeight:  FontWeight.normal,
                            height: 1,
                          ),
                        ),
                        onTap: () {
                          Alert(
                            style: const AlertStyle(
                              titleStyle: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  height: 1,
                                  fontFamily:'HSNIbtisam'
                              ),
                              descStyle: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'HSNIbtisam',
                                height: 1.5
                              ),
                            ),
                            context: context,
                            type: AlertType.info,
                            padding: const EdgeInsets.all(20) ,
                            closeIcon: Padding(padding: const EdgeInsets.all(10), child: Icon(Icons.cancel , color: HexColor('#074763'))),
                            title: "معلومات عنا",
                            desc: AppStrings.aboutUs,
                            // cubit.responseBodyAboutUs == null
                            //     ? 'error while getting data'
                            //     : cubit.responseBodyAboutUs['ar_body'],
                            buttons: [
                              DialogButton(
                                color: HexColor('#081C31'),
                                onPressed: () => Navigator.pop(context),
                                width: 120,
                                child: const Text(
                                  "إلغاء",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontFamily:'MYRIADPRO',
                                    fontWeight:FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ).show();
                        }
                    ),
                    // share app
                    ListTile(
                      iconColor: HexColor('#ECB365'),
                      textColor: HexColor('#ECB365'),
                      leading: const Icon(Icons.share),
                      title: const Text(
                        "مشاركة التطبيق",
                        style: TextStyle(
                          fontSize:  24,
                          fontFamily: 'HSNIbtisam',
                          fontWeight:  FontWeight.normal,
                          height: 1,
                        ),
                      ),
                      onTap: () {
                        cubit.shareApp();
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}
