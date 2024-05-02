import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_share/flutter_share.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hadayek_hof/Shared/network/local/cache_helper.dart';
import 'package:hadayek_hof/models/firestore/news_model.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Shared/constant/api_data_upgrade.dart';
import '../Shared/store profile/comment_widget.dart';
import '../core/app_strings.dart';
import '../models/DrawerScreen/one_offer_model.dart';
import '../models/Store/one_store_model.dart';
import '../models/Zone/zones_model.dart';
import '../models/firestore/new_dataModel.dart';
import '../models/firestore/offer_model.dart';
import 'states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitState());

  static HomeCubit get(context) => BlocProvider.of(context);

  String api = 'https://hadayekhof.com/dalel/api/';

  String generateToken() {
    // Timestamp myTimeStamp = Timestamp.now();
    var token = {
      // 'iat': myTimeStamp.seconds,
      // 'exp': (myTimeStamp.seconds + 180)
    };
    var jsonToken = jsonEncode(token);
    final key = encrypt.Key.fromUtf8('r4u7x!A%D*G-KaNd');
    final iv = encrypt.IV.fromUtf8('9648903453718521');
    final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.ctr, padding: null));
    final encrypted = encrypter.encrypt(jsonToken, iv: iv);
    String myToken = encrypted.base64;
    print(myToken);
    return myToken;
  }

  ZonesModel? zonesModel;
  var responseBodyGetZones;
  List<int> zoneIds = [];
  Future<void> getZonesData() async {
    final ciphertext = generateToken();
    emit(HomeGetZonesLoadingState());
    var uri = Uri.parse('${api}main/zones');
    await http.post(
        uri,
        headers: {'Authorization': 'Bearer $ciphertext'}).then((value) async {
      responseBodyGetZones = await jsonDecode(value.body);
      responseBodyGetZones.forEach((element) {
        zoneIds.add(int.parse(element['id']));
      });
      emit(HomeGetZonesSuccessState());
    }).catchError((error) {
      print("getZonesData error is : $error");
      emit(HomeGetZonesErrorState());
    });
  }

  var responseBodyCategories;
  List<int> categoryIds = [];
  List<bool>? isVisible;
  Future getCategoriesData(String zoneId) async {
    final ciphertext = generateToken();
    emit(HomeGetCategoriesLoadingState());
    var uri = Uri.parse('${api}main/parentCategories');
    await http.post(uri,
        body: {'zone_id': zoneId},
        headers: {'Authorization': 'Bearer $ciphertext'}).then((value) async {
      responseBodyCategories = await jsonDecode(value.body);
      categoryIds.clear();
      if (jsonDecode(value.body).toString().contains('[') == false) {
        responseBodyCategories = [];
      } else {
        responseBodyCategories.forEach((element) {
          categoryIds.add(int.parse(element['id']));
          isVisible = List.generate(responseBodyCategories.length, (index) => false);
        });
      }
      emit(HomeGetCategoriesSuccessState());
    }).catchError((error) {
      print(error);
      emit(HomeGetCategoriesErrorState());
    });
  }


  Future<void> shareApp() async {
    await FlutterShare.share(
      title: 'عايز إيه ؟', // email subject
      text: 'جرب تطبيق عايز إيه و استمتع بخصومات و أخبار حصرية', // body
      linkUrl: '', // link below the body
      // chooserTitle: 'Choose program to share' // share program dialog
    );
  }

  var responseBodySubCategories;
  Future getSubCategoriesData(int zoneIndex, categIndex) async {
    responseBodySubCategories = null;//To TimeStamp
    var data = {
      'zone_id': responseBodyGetZones[zoneIndex]['id'],
      'category_id': responseBodyCategories[categIndex]['id']
    };
    final ciphertext = generateToken();

    emit(HomeGetSubCategoriesLoadingState());
    var uri = Uri.parse('${api}main/subCategories');
    await http.post(uri,
        body: data,
        headers: {'Authorization': 'Bearer $ciphertext'}).then((value) async {
      if (value.body.contains('[')) {
        responseBodySubCategories = await jsonDecode(value.body);
      } else {
        responseBodySubCategories = [];
      }

      emit(HomeGetSubCategoriesSuccessState());
    }).catchError((error) {
      print("getSubCategoriesData erros is : $error");
      emit(HomeGetSubCategoriesErrorState());
    });
  }

  var responseBodyAboutUs;
  Future aboutUs() async {
    final ciphertext = generateToken();
    emit(HomeAboutUsLoadingState());
    var uri = Uri.parse('${api}main/staticContent');
    await http.post(uri,
        body: {'content_key': 'about_us'},
        headers: {'Authorization': 'Bearer $ciphertext'}).then((value) async {
      responseBodyAboutUs = await jsonDecode(value.body);
      emit(HomeAboutUsSuccessState());
    }).catchError((error) {
      print("aboutUs error is : $error");
      emit(HomeAboutUsErrorState());
    });
  }

  var responseBodyServices;
  Future getServicesData(int zoneIndex, subCategIndex) async {
    responseBodyServices = null;
    var data = {
      'zone_id': responseBodyGetZones[zoneIndex]['id'],
      'category_id': responseBodySubCategories[subCategIndex]['id']
    };
    final ciphertext = generateToken();

    emit(HomeGetStoresLoadingState());
    var uri = Uri.parse('${api}stores/stores');
    await http.post(uri,
        body: data,
        headers: {'Authorization': 'Bearer $ciphertext'}).then((value) async {
      if (value.body.contains('[')) {
        responseBodyServices = await jsonDecode(value.body);
      } else {
        responseBodyServices = [];
      }
      emit(HomeGetStoresSuccessState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error);
      }
      emit(HomeGetStoresErrorState());
    });
  }

  var responseHomeOffers;
  Future getHomeOffers() async {
    responseHomeOffers = null;
    final ciphertext = generateToken();
    emit(HomeGetStoresLoadingState());
    var uri = Uri.parse('${api}stores/homeAdvertisement');
    await http.post(uri,headers: {'Authorization': 'Bearer $ciphertext'}).then((value) async {
      if (value.body.contains('[')) {
        responseHomeOffers = await jsonDecode(value.body);
      } else {
        responseHomeOffers = [];
      }
      emit(HomeGetStoresSuccessState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error);
      }
      emit(HomeGetStoresErrorState());
    });
  }

  OneStoreModel? oneStoreModel;
  Future getStoreProfile(String storeId) async {
    var data = {'store_id': storeId,};
    final ciphertext = generateToken();
    oneStoreModel = null;
    emit(HomeGetStoreProfileLoadingState());
    var uri = Uri.parse('${api}stores/storeProfile');
    await http.post(uri,
        body: data,
        headers: {'Authorization': 'Bearer $ciphertext'}).then((value) async {
      oneStoreModel = OneStoreModel.fromJson(jsonDecode(value.body)[0]);
        print("oneStoreModel is $oneStoreModel");
        print("value.body is ${value.body}");
        print("oneStoreModel!.arDesc.toString() is : ${oneStoreModel!.arDesc.toString()}");
        emit(HomeGetStoreProfileSuccessState());
    }).catchError((error) {
      print("error is : $error");
      emit(HomeGetStoreProfileErrorState());
    });
  }

  var responseBodyOffers;
  Future getOffersData() async {
    final ciphertext = generateToken();
    emit(HomeGetAllOffersLoadingState());
    var uri = Uri.parse('${api}stores/advertisement');
    await http.post(uri,
        headers: {'Authorization': 'Bearer $ciphertext'}).then((value) async {
      if (value.body.contains('[')) {
        responseBodyOffers = await jsonDecode(value.body);
        print("responseBodyOffers is $responseBodyOffers");
        print("value.body is ${value.body}");
      } else {
        responseBodyOffers = [];
        print("responseBodyOffers from else is $responseBodyOffers");
      }
      emit(HomeGetAllOffersSuccessState());
    }).catchError((error) {
      print("getOffersData error is $error");
      emit(HomeGetAllOffersErrorState());
    });
  }

  OneOfferProfileModel? oneOfferProfileModel;
  Future getOneOfferProfile(advId) async {
    var data = {'adv_id': advId,};
    final ciphertext = generateToken();
    oneOfferProfileModel = null;
    emit(HomeGetOneOfferProfileLoadingState());
    var uri = Uri.parse('${api}stores/singleAdv');
    await http.post(uri, body: data, headers: {'Authorization': 'Bearer $ciphertext'}).then((value) async {
      oneOfferProfileModel = OneOfferProfileModel.fromJson(jsonDecode(value.body)[0]);
      if (kDebugMode) {
        print("oneOfferProfileModel is : $oneOfferProfileModel");
      }
      if (kDebugMode) {
        print("oneOfferProfileModel value.body is : ${value.body}");
      }
      if (kDebugMode) {
        print(oneOfferProfileModel!.arTitle.toString());
      }
      emit(HomeGetOneOfferProfileSuccessState());
    }).catchError((error) {
      if (kDebugMode) {
        print("getOneOfferProfile error is : $error");
      }
      emit(HomeGetOneOfferProfileErrorState());
    });
  }

  var responseBodyOnePost;
  Future<void> getOnePost(index) async {
    final ciphertext = generateToken();
    emit(HomeGetStoresLoadingState());
    await http.post(
      Uri.parse('${api}main/singleNews'),
      body: {'news_id':postsModel!.data[index].id},
      headers: {'Authorization':'Bearer $ciphertext'}).then((value) async {
      if (value.body.contains('[')) {
        responseBodyOnePost = await jsonDecode(value.body);
        if (kDebugMode) {
          print("getOnePost is : $responseBodyOnePost");
        }
        if (kDebugMode) {
          print("getOnePost value.body is : ${value.body}");
        }
      }else {
        responseBodyOnePost = [];
        if (kDebugMode) {
          print("getOnePost is : $responseBodyOnePost");
        }
        if (kDebugMode) {
          print("getOnePost value.body is : ${value.body}");
        }
      }
        emit(HomeGetStoresSuccessState());
      }).catchError((e) {
        print("getOnePost error is $e");
        emit(HomeGetStoresErrorState());
      });
  }

  var postsModel;
  Future getAllPosts() async {
    final ciphertext = generateToken();
    emit(HomeGetStoresLoadingState());
    var uri = Uri.parse('${api}main/news');
    await http.post(uri,headers: {'Authorization':'Bearer $ciphertext'}).then((value) async {
      if(value.body.contains('[')){
        postsModel = await jsonDecode(value.body);
      }else{
        postsModel= [];
      }
      emit(HomeGetStoresSuccessState());
    }).catchError((error) {
      print("getAllPosts error is $error");
      emit(HomeGetStoresErrorState());
    });
  }

  void whatsAppOpen(String number) async {
    String url() {
      if (Platform.isIOS) {
        return "whatsapp://wa.me/+2$number/?text=${Uri.encodeFull("مرحبَا، هل يمكنك إخباري بمواعيد العمل الخاصة بك؟")}";
      } else {
        return "whatsapp://send?phone=+2$number&text=${Uri.encodeFull("مرحبَا، هل يمكنك إخباري بمواعيد العمل الخاصة بك؟")}";
      }
    }
    launchUrl(Uri.parse(url()));
  }

  void openFaceBook(String pageLink) async {
    var url = 'fb://facewebmodal/f?href=$pageLink';
    if (await canLaunch(url)) {
      await launch(
        url,
        universalLinksOnly: true,
      );
    } else {
      throw 'There was a problem to open the url: $url';
    }
  }

  Future<void> launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {throw 'Could not launch $url';}
  }

  void launchUrl2(fbUrl) async {
    String url = fbUrl;
    if (await canLaunch(url)) {
      await launch(
        url,
        universalLinksOnly: true,
      );
    }
  }

  launchMap({/*required String lat, required String lng,*/ required String link}) async {
    String url = '';
    String urlAppleMaps = '';
    if (Platform.isAndroid) {
      url = link; // 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    } else {
      urlAppleMaps = link; // 'https://maps.apple.com/?q=$lat,$lng';
      url = link; // 'comgooglemaps://?saddr=&daddr=$lat,$lng&directionsmode=driving';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    if (await canLaunch(url)) {
      await launch(url);
    } else if (await canLaunch(urlAppleMaps)) {
      await launch(urlAppleMaps);
    } else {
      throw 'Could not launch $url';
    }
  }

  launchInstagram(String? username, String profileLink) async {
    String nativeUrl = "instagram://user?username=$username";
    String webUrl = profileLink;
    if (await canLaunch(nativeUrl)) {
      await launch(nativeUrl);
    } else if (await canLaunch(webUrl)) {
      await launch(webUrl);
    } else {
      print("can't open Instagram");
    }
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  var responseBodyDeviceToken;
  // Future sendDeviceToken() async {
  //   var DeviceToken = await FirebaseMessaging.instance.getToken();
  //   var data = {'device_token': DeviceToken};
  //   final ciphertext = generateToken();
  //
  //   emit(HomeSendDeviceTokenLoadingState());
  //   var uri = Uri.parse('${api}main/saveDeviceToken');
  //   await http.post(
  //       uri,
  //       body: data,
  //       headers: {'Authorization': 'Bearer $ciphertext'}).then((value) async {
  //     if (jsonDecode(value.body).toString() == "success") {
  //       responseBodyDeviceToken = jsonDecode(value.body);
  //       print("sendDeviceToken success");
  //     }
  //     emit(HomeSendDeviceTokenSuccessState());
  //   }).catchError((error) {
  //     print("sendDeviceToken error is : $error");
  //     emit(HomeSendDeviceTokenErrorState());
  //   });
  // }


  Future addStoreRate(String userNname, String rateValue, String comment, String id, String phn ) async {
    // var DeviceToken = await FirebaseMessaging.instance.getToken();
    final ciphertext = generateToken();
    emit(HomeGetStoresLoadingState());
    var uri = Uri.parse('${api}ratings/addRate');
    await http.post(
      uri,
      headers: {'Authorization':'Bearer $ciphertext'},
      body: {
        'name' : userNname,
        'rating' : rateValue,
        'comment' : comment,
        'store_id' : id,
        'device_token' : "DeviceToken",
        'mobile' : phn ,
      }
    ).then((value) async {
      if(value.statusCode == 200){
        Fluttertoast.showToast(msg: "شكرا لتقيمك");
      }else if(value.statusCode == 403){
        Fluttertoast.showToast(msg: "عذرا، لقد قيمت هذه الخدمة من قبل");
      }else{
        Fluttertoast.showToast(msg: "برجاء المحاولة مرة أخرى");
      }
      emit(HomeGetStoresSuccessState());
    }).catchError((error) {
      print("addStoreRate error is $error");
      emit(HomeGetStoresErrorState());
    });
  }

  var responseStoreRateBody;
  Future<void> getStoreRate(String storeID) async {
    final ciphertext = generateToken();
    emit(HomeGetStoresLoadingState());
    await http.post(
        Uri.parse('${api}ratings/storeRatings'),
        body: {'store_id':storeID},
        headers: {'Authorization':'Bearer $ciphertext'}).then((value) async {
      if (value.body.contains('[')) {
        responseStoreRateBody = await jsonDecode(value.body);
        if (kDebugMode) {
          print("getStoreRate is : $responseStoreRateBody");
        }
        if (kDebugMode) {
          print("getStoreRate value.body is : ${value.body}");
        }
      }
      else {
        responseStoreRateBody = [];
        if (kDebugMode) {
          print("getStoreRate is : $responseStoreRateBody");
        }
        if (kDebugMode) {
          print("getStoreRate value.body is : ${value.body}");
        }
      }
      emit(HomeGetStoresSuccessState());
    }).catchError((e) {
      print("getStoreRate error is $e");
      emit(HomeGetStoresErrorState());
    });
  }

  void showModalSheet(BuildContext context, int zoneId, categoryId,subCategoryId,storeId){
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.60,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [...List.generate(
                AppStrings.data[zoneId]['storesUserRateName'][categoryId][subCategoryId][storeId].length,
                    (index) => buildCommentItemRTL(context,zoneId, categoryId,subCategoryId,storeId,1))]
            // [
            //   buildCommentItemRTL(context,data, "sayed" , " Good Job Good Job Good Job Good Job Good Job Good Job Good Job Good Job Good Job Good Job Good Job Good Job Good Job",1),
            //   buildCommentItemRTL(context,data "sayed" , " Good Job Good Job Good Job Good Job Good Job Good Job Good Job Good Job Good Job Good Job Good Job Good Job Good Job",1)
            // ],
          ),
        ),
      ),
    );
  }

  var responseBodyAppSettingRate;
  Future<void> getAppSetting1() async {
    final ciphertext = generateToken();
    emit(HomeGetStoresLoadingState());
    await http.post(
        Uri.parse('${api}main/getSettings'),
        body: {'key':"ratings"},
        headers: {'Authorization':'Bearer $ciphertext'}).then((value) async {
        responseBodyAppSettingRate = await jsonDecode(value.body);
        if (kDebugMode) {
          print("getAppSetting is : $responseBodyAppSettingRate");
        }
        if (kDebugMode) {
          print("getAppSetting value.body is : ${value.body}");
        }
      emit(HomeGetStoresSuccessState());
    }).catchError((e) {
      print("getAppSetting error is $e");
      emit(HomeGetStoresErrorState());
    });
  }

  var responseBodyAppSettingComments;
  Future<void> getAppSetting2() async {
    final ciphertext = generateToken();
    emit(HomeGetStoresLoadingState());
    await http.post(
        Uri.parse('${api}main/getSettings'),
        body: {'key':"rating_comments"},
        headers: {'Authorization':'Bearer $ciphertext'}).then((value) async {
      responseBodyAppSettingRate = await jsonDecode(value.body);
      if (kDebugMode) {
        print("getAppSetting2 is : $responseBodyAppSettingRate");
      }
      if (kDebugMode) {
        print("getAppSetting2 value.body is : ${value.body}");
      }
      emit(HomeGetStoresSuccessState());
    }).catchError((e) {
      print("getAppSetting2 error is $e");
      emit(HomeGetStoresErrorState());
    });
  }

  var responseUpgrade;
  Future<void> forceUpgrade() async{
    emit(HomeGetStoresLoadingState());
    await http.get(
      Uri.parse("https://appupgrade.dev/api/v1/versions/check?app_name=hadayek_hof&app_version=$appVersion&platform=android&environment=production"),
      headers: {"x-api-key" : xApiKey},
    ).then((value){
      responseUpgrade = jsonDecode(value.body);
      CacheHelper.putData(key: 'isUpdate', value: responseUpgrade['found']);
      debugPrint(value.body);
    emit(HomeGetStoresLoadingState());
    }).catchError((error){
      debugPrint("forceUpgrade error is : $error");
    emit(HomeGetStoresLoadingState());
    });  
  }

  Future<void> createFireStore() async{
    final collectionRef = FirebaseFirestore.instance.collection('TestZones');
    for (var zone in AppStrings.zones) {
      DocumentSnapshot snapshot = await collectionRef.doc(zone).get();
      if (!snapshot.exists) {
        await collectionRef.doc(zone).set({}).then((_) {
          print('Document created with ID: $zone');
          
        }).catchError((error) {
          print('Error adding document: $error');
        });
      } else {
        print('Document with ID: $zone already exists, skipping...');
      }
    }
  }

  Future<void> createNewsCollection() async {
    emit(CreateNewsCollectionLoadingState());
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference newsOffersCollection = db.collection('News and Offers');
    Map<String, dynamic> initialOffersData = {
      'offers': [{
        'title': 'Special Holiday Sale',
        'type': true,
        'offerImages': [
          'url_to_offer_image1.jpg', 
          'url_to_offer_image2.jpg'
        ],
        'description': 'Enjoy our special holiday discount on all products.',
        'storeName' : 'test Store',
        'date' : '2024-05-01',
      }]
    };
    Map<String, dynamic> initialNewsData = {
      'news': [{
        'title': 'New Store Opening',
        'type': false,
        'newsImage': 'url_to_news_image.jpg',
        'description': 'We are excited to announce the opening of our new store in downtown.',
        'date': '2024-05-01',
      }]
    };
    try {
      DocumentReference offersDocRef = newsOffersCollection.doc('offers');
      DocumentSnapshot offersDocSnapshot = await offersDocRef.get();
      if (!offersDocSnapshot.exists) {
        await offersDocRef.set(initialOffersData);
        print("Offers document created successfully");
      } else {
        print("Offers document already exists");
      }
      DocumentReference newsDocRef = newsOffersCollection.doc('news');
      DocumentSnapshot newsDocSnapshot = await newsDocRef.get();
      if (!newsDocSnapshot.exists) {
        await newsDocRef.set(initialNewsData);
        print("News document created successfully");
      } else {
        print("News document already exists");
      }
      emit(CreateNewsCollectionSuccessState());
    } catch (e) {
      print("Error creating News and Offers documents: $e");
      emit(CreateNewsCollectionErrorState());
    }
  }

  List<OfferItem>? offerItems;
  List<NewsItem>? newsItems;

  Future<List<NewsItem>> fetchNewsItems() async {
    emit(FetchNewsItemsLoadingState());
  FirebaseFirestore db = FirebaseFirestore.instance;
  try {
    DocumentSnapshot doc = await db.collection("News and Offers").doc("news").get();
    if (doc.exists) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;  // Cast to Map<String, dynamic>
      if (data.containsKey('news')) {
        var newsList = data['news'] as List;  // Safe to cast now
        newsItems = newsList.map((item) => NewsItem.fromJson(item as Map<String, dynamic>)).toList();
      }
    }
    emit(FetchNewsItemsSuccessState());
  } catch (e) {
    print('Error fetching news: $e');
    emit(FetchNewsItemsErrorState());
  }

  return newsItems ?? [];
}

  Future<List<OfferItem>> fetchOfferItems() async {
    emit(FetchOfferItemsLoadingState());
  FirebaseFirestore db = FirebaseFirestore.instance;
  try {
    DocumentSnapshot doc = await db.collection("News and Offers").doc("offers").get();
    if (doc.exists) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;  // Cast to Map<String, dynamic>
      if (data.containsKey('offers')) {
        var offersList = data['offers'] as List;
        offerItems = offersList.map((item) => OfferItem.fromJson(item as Map<String, dynamic>)).toList();
      }
    }
    emit(FetchOfferItemsSuccessState());
  } catch (e) {
    print('Error fetching offers: $e');
    // Optionally handle the error more gracefully
    emit(FetchOfferItemsErrorState());
  }

  return offerItems ?? [];
}

  bool isLoadding = false;
  Future<void> addToFireStore(Store store, String zone, String category, String subCategory,String subSubCategory, BuildContext context) async {
    emit(HomeGetStoresLoadingState());
  FirebaseFirestore db = FirebaseFirestore.instance;
  String docId = '$category-$subCategory-$subSubCategory-${store.name}';
  try {
    await db.collection("TestZones").doc(zone).collection("Stores").doc(docId)
      .set(store.toMap(), SetOptions(merge: true));
    print("Store added/updated successfully!");
    Fluttertoast.showToast(msg: "تم الإنضمام بنجاح");
    Navigator.pop(context);
    emit(HomeGetStoresSuccessState());
  } catch (e) {
    print('Error adding/updating store: $e');
    Fluttertoast.showToast(msg: "شيء ما خاطئ حدث يرجى المحاولة في وقت لاحق");
    emit(HomeGetStoresErrorState());
  }
}

Future<List<Store>> fetchStoresByZone(String zone) async {
  try {
    final querySnapshot = await FirebaseFirestore.instance
        .collection("TestZones")
        .doc(zone)
        .collection("Stores")
        .get();

    final stores = querySnapshot.docs.map((doc) {
      final storeData = doc.data() as Map<String, dynamic>;
      return Store.fromMap(storeData);
    }).toList();
    return stores;
  } catch (e) {
    print('Error fetching stores for zone $zone: $e');
    return []; // Handle errors gracefully
  }
}

List<String>? zoneNames;
Future<void> fetchAllZones() async {
    emit(HomeGetZonesLoadingState());
  FirebaseFirestore db = FirebaseFirestore.instance;
  try {
    QuerySnapshot zoneSnapshot = await db.collection("TestZones").get();
    zoneNames = zoneSnapshot.docs.map((doc) => doc.id).toList();
    print("All zone names: $zoneNames");
    emit(HomeGetZonesSuccessState());
  } catch (e) {
    print('Error fetching zones: $e');
    emit(HomeGetZonesErrorState());
  }
}

  List<String>? categoriesNames;
  Future<void> getCategories({required String zoneName}) async{
    emit(HomeGetCategoriesLoadingState());
    final db = FirebaseFirestore.instance;
    try{
      QuerySnapshot categoriesSnapShot = await db.collection("TestZones").doc(zoneName).collection("Stores").get();
      categoriesNames = categoriesSnapShot.docs.map((doc) => doc.id).toList();
      extractComponentsFromDocId(categoriesNames!);
      emit(HomeGetCategoriesSuccessState());
      print(categoriesNames);
    } catch (e) {
      print("getCategories error is : $e");
      emit(HomeGetCategoriesErrorState());
    }
  }

  Map<String, Map<String, Set<String>>> categoryStructure = {};

void extractComponentsFromDocId(List<String> list) {
  emit(HomeAboutUsLoadingState());

  // Clear the previous data
  categoryStructure.clear();

  for (var docId in list) {
    List<String> parts = docId.split('-');
    if (parts.length >= 3) {
      String category = parts[0];
      String subCategory = parts[1];
      String subSubCategory = parts.sublist(2).join('-');

      // Initialize the subcategory map if this category is new
      if (!categoryStructure.containsKey(category)) {
        categoryStructure[category] = {};
      }

      // Initialize the subsubcategory set if this subcategory is new
      if (!categoryStructure[category]!.containsKey(subCategory)) {
        categoryStructure[category]![subCategory] = Set<String>();
      }

      // Add the subsubcategory
      categoryStructure[category]![subCategory]!.add(subSubCategory);
    } else {
      print('Document ID format is incorrect');
      emit(HomeAboutUsErrorState());
      return; // Return early on error
    }
  }

  print('Categories and their structure: $categoryStructure');

  for (var category in categoryStructure.keys) {
  log('Category: $category');
  for (var subCategory in categoryStructure[category]!.keys) {
    log('  SubCategory: $subCategory');
    for (var subSubCategory in categoryStructure[category]![subCategory]!) {
      log('    SubSubCategory: $subSubCategory');
    }
  }
}

  emit(HomeAboutUsSuccessState());
}

List<String> allSubCategory = [];
void showSubCategories(String categoryName) {
  emit(HomeGetCategoriesLoadingState());
  allSubCategory.clear();
  if (categoryStructure.containsKey(categoryName)) {
    // Get the map of subcategories for the specified category
    Map<String, Set<String>> subCategories = categoryStructure[categoryName]!;
    
    // Print out or return the subcategories
    print('Subcategories for $categoryName:');
    subCategories.keys.forEach((subCategory) {
      allSubCategory.add(subCategory);
    });
    log(allSubCategory.toString());
    emit(HomeGetAllOffersSuccessState());
  } else {
    // Handle the case where the category does not exist
    print('No such category: $categoryName');
    emit(HomeGetSubCategoriesErrorState());
  }
}

List<Store> stores = [];
Map<String, dynamic> data = {};
  Future<List<Store>> fetchStores(String zoneName, String category, String subCategory) async {
    stores.clear();
    data.clear();
    emit(HomeFetchStoresLoading());
  FirebaseFirestore db = FirebaseFirestore.instance;
  
  try {
    QuerySnapshot querySnapshot = await db.collection("TestZones").doc(zoneName).collection("Stores")
    .where(FieldPath.documentId, isGreaterThanOrEqualTo: "$category-$subCategory-")
    .where(FieldPath.documentId, isLessThan: "$category-$subCategory-\uf8ff").get();

    for (var doc in querySnapshot.docs) {
      data = doc.data() as Map<String, dynamic>;
      data['id'] = doc.id;
      log('data is : $data');
      Store store = Store.fromMap(data);
      stores.add(store);
      log('stores is :$stores');
    }
      log('stores is :${stores[0].name}');
    emit(HomeFetchStoresSuccessState());
    return stores;
  } catch (e) {
    log('Error fetching stores: $e');
    emit(HomeFetchStoresErrorState());
    return [];
  }
}

  int clickCounter = 0;

  Future<void> addNewsItem(NewsItem newsItem) async {
    emit(AddNewsItemsLoadingState());
  FirebaseFirestore db = FirebaseFirestore.instance;
  DocumentReference newsRef = db.collection("News and Offers").doc("news");

  try {
    await newsRef.update({
      "news": FieldValue.arrayUnion([newsItem.toJson()])
    });
    log("News item added successfully");
    emit(AddNewsItemsSuccessState());
  } catch (e) {
    log("Error adding news item: $e");
    // Create the document if it doesn't exist
    if (e.toString().contains('not-found')) {
      await newsRef.set({"news": [newsItem.toJson()]});
    }
    emit(AddNewsItemsErrorState());
  }
}


  Future<void> addOfferItem(OfferItem offerItem) async {
    emit(AddOfferItemsLoadingState());
    FirebaseFirestore db = FirebaseFirestore.instance;
    DocumentReference offersRef = db.collection("News and Offers").doc("offers");

    try {
      await offersRef.update({
        "offers": FieldValue.arrayUnion([offerItem.toJson()])
      });
      log("Offer item added successfully");
      emit(AddOfferItemsSuccessState());
    } catch (e) {
      log("Error adding offer item: $e");
      // Create the document if it doesn't exist
      if (e.toString().contains('not-found')) {
        await offersRef.set({"offers": [offerItem.toJson()]});
      }
      emit(AddOfferItemsErrorState());
    }
  } 

 bool isOffer = false;

  Future<String> uploadImage(File imageFile, String storagePath) async {
    String fileName = 'images/${DateTime.now().millisecondsSinceEpoch}_${imageFile.uri.pathSegments.last}';
    Reference storageReference = FirebaseStorage.instance.ref().child('$storagePath/$fileName');
    UploadTask uploadTask = storageReference.putFile(imageFile);
    await uploadTask.whenComplete(() => null);
    String fileURL = await storageReference.getDownloadURL();
    return fileURL;
  }

  Future<void> createOfferItem(OfferItem offer, File imageFile) async {
  try {
    String imageUrl = await uploadImage(imageFile, 'offerImages');
    offer.offerImages = [imageUrl];
    await addOfferItem(offer);
  } catch (e) {
    print("Failed to create offer item: $e");
  }
}

  List<File> images = [];
  
  Future<void> pickSingleImage() async {
    emit(PickImageLoadingState());
    final ImagePicker _picker = ImagePicker();
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      images = [File(pickedFile.path)];
      downloadableImage.clear();
    }
      emit(PickImageSuccessState());
  }

  Future<void> pickMultipleImages() async {
    emit(PickImageLoadingState());
    final ImagePicker _picker = ImagePicker();
    final pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles != null) {
      images = pickedFiles.map((file) => File(file.path)).toList();
      downloadableImage.clear();
    }
    emit(PickImageSuccessState());
  }

  List<String> downloadableImage = [];
  Future<void> uploadImageToFirebase(File imageFile) async {
    try {
      String fileName = 'images/${DateTime.now().millisecondsSinceEpoch}_${imageFile.uri.pathSegments.last}';
      Reference ref = FirebaseStorage.instance.ref().child(fileName);

      UploadTask task = ref.putFile(imageFile);
      final snapshot = await task.whenComplete(() => {});
      final urlDownload = await snapshot.ref.getDownloadURL();
      downloadableImage.add(urlDownload);
      print('Download-Link: $urlDownload');
    } catch (e) {
      print(e); // Handle errors
    }
  }

  bool isExist = false;
  int zoneSearchIndex = -1;
  void containsZone(String zoneToCheck) {
    emit(ContainsZoneLoadingState());
    String searchQuery = zoneToCheck.trim().toLowerCase();
    bool found = zoneNames?.any((zone) => zone.toLowerCase() == searchQuery) ?? false;
    if (found) {
      isExist = true;
      emit(ContainsZoneSuccessState());
    } else {
      isExist = false;
      emit(ContainsZoneErrorState());
    }
  }


}