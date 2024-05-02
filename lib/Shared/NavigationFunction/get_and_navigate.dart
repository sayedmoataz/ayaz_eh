
import 'package:flutter/cupertino.dart';
import 'package:hadayek_hof/Modules/Drawer/one_offer.dart';
import 'package:hadayek_hof/Shared/NavigationFunction/navigate_to.dart';
import 'package:hadayek_hof/models/News/one_news_model.dart';

getAdvDataAdNavigate(BuildContext context, int advId){

  // HomeCubit.get(context).getOneOfferProfile(advId);
  navigateTo(context, OneOffer(index: advId));

}

getPostProfileAdNavigate(BuildContext context, int advId){

  // HomeCubit.get(context).getOnePost(advId);
  navigateTo(context, OneNews());

}