
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadayek_hof/core/app_strings.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../Cubit/cubit.dart';
import '../../Cubit/states.dart';
import '../../Shared/AppBar/my_app_bar.dart';
import '../../Shared/NavigationFunction/navigate_to.dart';
import '../../Shared/drawer/all_offer_component.dart';
import '../../Shared/drawer/my_drawer.dart';
import 'one_offer.dart';


class AllOffers extends StatelessWidget {
  const AllOffers({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return Directionality(
            textDirection:TextDirection.rtl,
            child: Scaffold(
              backgroundColor: Colors.grey[200],
              appBar: myAppBar(),
              drawer: const MyDrawer(),
              body: cubit.offerItems == null ? const Center(child: CircularProgressIndicator())
              : Container(
                child:
                  cubit.offerItems!.isEmpty 
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FittedBox(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'لا يوجد عروض حاليا',
                                    style: TextStyle(fontSize: 40, color: HexColor('#081C31')),
                                  ),
                                )
                            )
                          ],
                        )
                      )
                      : ListView.builder(
                          itemCount: cubit.offerItems!.length,
                          itemBuilder: (context, index) => cardHorizontalOffers(
                            () => navigateTo(context, OneOffer(index: index)),
                            index,
                            context,
                            cubit.offerItems![index].offerImages.first,
                            cubit.offerItems![index].title,
                            cubit.offerItems![index].storeName,
                            cubit.offerItems![index].date
                          ),
                  )
              ),
            ),
          );
        }
    );
  }
}
