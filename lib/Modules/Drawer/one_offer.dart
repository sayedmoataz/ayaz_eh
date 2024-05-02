import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:hadayek_hof/core/app_strings.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../Cubit/cubit.dart';
import '../../Cubit/states.dart';
import '../../Shared/AppBar/share_app_bar.dart';
import '../../Shared/image/cashed_images.dart';

class OneOffer extends StatelessWidget {
OneOffer({required this.index, super.key});
  late int index;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Directionality(
          textDirection:TextDirection.rtl,
          child: Scaffold(
            appBar: shareAppBar(),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    ImageSlideshow(
                      width: double.infinity,
                      height: 200,
                      initialPage: 0,
                      indicatorColor: HexColor('#081C31'),
                      indicatorBackgroundColor: Colors.grey,
                      onPageChanged: (value) { },
                      autoPlayInterval: 5000,
                      isLoop: true,
                      children: [
                        ...List.generate(
                          cubit.offerItems![this.index].offerImages.length,
                          (index) => defaultNetworkImg(
                            context,
                            double.infinity,
                            double.infinity,
                            cubit.offerItems![this.index].offerImages[index],
                            BoxFit.cover,
                            1
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        cubit.offerItems![index].title,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: HexColor('#081C31'),
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontFamily:  'HSNIbtisam',
                          height: 1,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                      child: const Divider(color: Colors.black,height: 36)
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        cubit.offerItems![index].description,
                        maxLines: 25,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: HexColor('#081C31'),
                          fontSize: 17,
                          fontWeight: FontWeight.normal,
                          fontFamily:  'HSNIbtisam',
                          height: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        );
      }
    );
  }
}
