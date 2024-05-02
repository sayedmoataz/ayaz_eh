import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadayek_hof/Shared/Text%20Form/text_form.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../Cubit/cubit.dart';
import '../../Cubit/states.dart';
import '../../Shared/AppBar/my_app_bar.dart';
import '../../Shared/drawer/my_drawer.dart';
import '../../Shared/drawer/search_widget.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  TextEditingController searchController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white,
              appBar: myAppBar(),
              drawer: const MyDrawer(),
              body: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 25),
                        const Text(
                            "ابحث عن مدينتك",
                            style: TextStyle(
                              fontSize:  24,
                              fontFamily: 'HSNIbtisam',
                              fontWeight:  FontWeight.normal,
                              height: 1,
                            ),
                          ),
                        const SizedBox(height: 25),
                        defaultTextFormFiel(
                          context, 
                          searchController, 
                          TextInputType.text, 
                          'اسم المدينة', 
                          1
                        ),
                        const SizedBox(height: 25),
                        InkWell(
                          onTap: () {
                            if(formKey.currentState!.validate()) {
                              cubit.containsZone(searchController.text.trim());
                              if (cubit.isExist) {
                                String searchQuery = searchController.text.trim().toLowerCase();
                                cubit.zoneSearchIndex = cubit.zoneNames!.indexWhere((zone) => zone.toLowerCase() == searchQuery);
                                log(cubit.zoneSearchIndex.toString());
                              } else {
                                cubit.zoneSearchIndex = -1;
                              }
                            }
                          },
                          child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: HexColor('#081C31'),
                                borderRadius: BorderRadius.circular(5)
                              ),
                              child: Padding(
                                padding:  const EdgeInsets.symmetric(vertical: 5),
                                child: cubit.isLoadding == true? const Center(child: CircularProgressIndicator()) : const Text(
                                  "بحث",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontFamily:'MYRIADPRO',
                                    fontWeight:FontWeight.bold,
                                  ),
                                ),
                              ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        cubit.zoneSearchIndex != -1 
                        ? buildSearchItem(cubit,context,cubit.zoneSearchIndex)
                        : const Text(
                            "غير موجودة، تأكد من كتابة الأحرف بشكل صحيح",
                            style: TextStyle(
                              fontSize:  24,
                              fontFamily: 'HSNIbtisam',
                              fontWeight:  FontWeight.normal,
                              height: 1,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
    )
        );
  }
    );
}
}