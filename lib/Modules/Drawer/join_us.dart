import 'dart:developer';
import 'dart:io';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadayek_hof/Shared/AppBar/my_app_bar.dart';
import 'package:hadayek_hof/Shared/Text%20Form/text_form.dart';
import 'package:hadayek_hof/core/app_strings.dart';
import 'package:hadayek_hof/models/firestore/news_model.dart';
import 'package:hadayek_hof/models/firestore/offer_model.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../Cubit/cubit.dart';
import '../../Cubit/states.dart';
import '../../Shared/drawer/my_drawer.dart';
import '../../models/firestore/new_dataModel.dart';

class JoinUs extends StatefulWidget {
  JoinUs({super.key});

  @override
  State<JoinUs> createState() => _JoinUsState();
}

class _JoinUsState extends State<JoinUs> {
  @override
  void initState() {
    HomeCubit.get(context).clickCounter = 0;
    super.initState();
  }
  final formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController storeNameController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController descropationController = TextEditingController();

  TextEditingController addressController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController whatsappController = TextEditingController();

  TextEditingController locationController = TextEditingController();

  TextEditingController facebookController = TextEditingController();

  TextEditingController instagramController = TextEditingController();

  TextEditingController websiteController = TextEditingController();

  SingleValueDropDownController zoneController = SingleValueDropDownController();

  SingleValueDropDownController categoryController = SingleValueDropDownController(data: DropDownValueModel(name: AppStrings.allCategoriesnames.keys.toList().first.toString(), value: 0));

  SingleValueDropDownController subCategoryController = SingleValueDropDownController();

  SingleValueDropDownController subSubCategoryController = SingleValueDropDownController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
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
                    InkWell(
                      onTap: () {
                        setState(() {
                          cubit.clickCounter++;
                          log(cubit.clickCounter.toString());
                        });
                      },
                      child: const Text(
                        "اعلن عن خدمتك معنا",
                        style: TextStyle(
                          fontSize:  24,
                          fontFamily: 'HSNIbtisam',
                          fontWeight:  FontWeight.normal,
                          height: 1,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    cubit.clickCounter >= 10 
                      ? Column(
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () => setState(() => cubit.isOffer = true),
                                icon: Icon(
                                  cubit.isOffer
                                  ? Icons.radio_button_on
                                  : Icons.radio_button_off,
                                  color: HexColor('#074763')
                                )
                              ),
                              const Text(
                                "عرض",
                                style: TextStyle(
                                  fontSize:  24,
                                  fontFamily: 'HSNIbtisam',
                                  fontWeight:  FontWeight.normal,
                                  height: 1,
                                ),    
                              ),
                              const SizedBox(width: 16),
                              IconButton(
                                onPressed: () => setState(() => cubit.isOffer = false),
                                icon: Icon(
                                  cubit.isOffer
                                  ? Icons.radio_button_off
                                  : Icons.radio_button_on,
                                  color: HexColor('#074763')
                                ),
                              ),
                              const Text(
                                "خبر",
                                style: TextStyle(
                                  fontSize:  24,
                                  fontFamily: 'HSNIbtisam',
                                  fontWeight:  FontWeight.normal,
                                  height: 1,
                                ),    
                              ),
                            ],
                          ),
                          defaultTextFormFiel(
                            context, 
                            titleController, 
                            TextInputType.text,
                            'عنوان العرض / الخبر', 
                            1
                          ),
                          if(cubit.isOffer == true) ...{
                            const SizedBox(height: 15),
                            defaultTextFormFiel(
                              context, 
                              storeNameController, 
                              TextInputType.text,
                              'المحل', 
                              1
                            ),
                          },
                          const SizedBox(height: 15),
                          defaultTextFormFiel(
                            context, 
                            descController, 
                            TextInputType.text,
                            'الوصف', 
                            5
                          ),
                          const SizedBox(height: 15),
                          cubit.isOffer == false
                          ? InkWell(
                            onTap: cubit.pickSingleImage,
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: HexColor('#081C31'),
                                borderRadius: BorderRadius.circular(5)
                              ),
                              child: const Padding(
                                padding:  EdgeInsets.symmetric(vertical: 5),
                                child:Center(
                                  child: Text(
                                    'إلتقاط صورة واحدة للخبر',
                                    style: TextStyle(
                                      fontSize:  24,
                                      fontFamily: 'HSNIbtisam',
                                      fontWeight:  FontWeight.normal,
                                      height: 1,
                                    ),
                                  ),
                                ),
                          ),
                            ),
                          )
                          : InkWell(
                            onTap: cubit.pickMultipleImages,
                            child:  Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: HexColor('#081C31'),
                                borderRadius: BorderRadius.circular(5)
                              ),
                              child: const Padding(
                                padding:  EdgeInsets.symmetric(vertical: 5),
                                child:Center(
                                  child: Text(
                                    'إلتقاط عدة صور للعرض',
                                    style: TextStyle(
                                      fontSize:  24,
                                      fontFamily: 'HSNIbtisam',
                                      fontWeight:  FontWeight.normal,
                                      height: 1,
                                    ),
                                  ),
                                ),
                          ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 10,
                            children: cubit.images.map((file) => Image.file(file, width: 100, height: 100)).toList(),
                          ),
                          const SizedBox(height: 25),
                          InkWell(
                            onTap: () async {
                              if (formKey.currentState!.validate()) {
                                setState(() {
                                  cubit.isLoadding = true;
                                });
                                for (var imageFile in cubit.images) {
                                  await cubit.uploadImageToFirebase(imageFile);
                                }
                                if (cubit.isOffer) {
                                  OfferItem offerItem = OfferItem(
                                    title: titleController.text,
                                    offerImages: cubit.downloadableImage,
                                    description: descController.text,
                                    storeName: storeNameController.text,
                                    date: DateTime.now().toString(),
                                    type: cubit.isOffer
                                  );
                                  await cubit.addOfferItem(offerItem).then((value) => setState(() {cubit.isLoadding = false;}));
                                } else {
                                  NewsItem newsItem = NewsItem(
                                    title: titleController.text,
                                    newsImage: cubit.downloadableImage.isNotEmpty ? cubit.downloadableImage.last : AppStrings.image,
                                    description: descController.text,
                                    date: DateTime.now().toString(),
                                  );
                                  await cubit.addNewsItem(newsItem).then((value) => setState(() {cubit.isLoadding = false;}));
                                }
                                Navigator.pop(context);
                              } else {
                                setState(() {
                                  cubit.isLoadding = false;
                                }); 
                                print('Form validation failed');
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
                                child: cubit.isLoadding == true
                                ? const Center(child: CircularProgressIndicator()) 
                                : const Text(
                                  "نشر",
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
                        ],
                      )
                      : Column(
                        children: [
                          DropDownTextField(
                        textFieldDecoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(right: 20, left: 10, bottom: 10),
                          hintText: 'المنطقة',
                          alignLabelWithHint: true,
                          labelStyle: TextStyle(
                            color: HexColor('#ECB365'),
                            fontSize: 24,
                            fontWeight: FontWeight.normal,
                            fontFamily:'HSNIbtisam'
                          ),
                        ),
                        controller: zoneController,
                        autovalidateMode: AutovalidateMode.always,
                        clearOption: true,
                        validator: (value) {
                          if (value == null) {
                            return "Required field";
                          } else {
                            return null;
                          }
                        },
                        dropDownItemCount: 4,
                        dropDownList: List.generate(AppStrings.zones.length, (index) => DropDownValueModel(name: AppStrings.zones[index].toString(), value: index)),
                        onChanged: (val) {},
                      ),
                          const SizedBox(height: 10),
                          DropDownTextField(
                            textFieldDecoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(right: 20, left: 10, bottom: 10),
                              hintText: 'التصنيف -1',
                              alignLabelWithHint: true,
                              labelStyle: TextStyle(
                                color: HexColor('#ECB365'),
                                fontSize: 24,
                                fontWeight: FontWeight.normal,
                                fontFamily:'HSNIbtisam'
                              ),
                            ),
                            controller: categoryController,
                            autovalidateMode: AutovalidateMode.always,
                            clearOption: true,
                            validator: (value) {
                              if (value == null) {
                                return "Required field";
                              } else {
                                return null;
                              }
                            },
                            dropDownItemCount: 3,
                            dropDownList:  List.generate(
                              AppStrings.allCategoriesnames.keys.toList().length, 
                              (index) => DropDownValueModel(
                                name: AppStrings.allCategoriesnames.keys.toList()[index].toString(), value: index)),
                            onChanged: (val) {
                              setState(() {
                                // log(categoryController.dropDownValue.toString());
                                // log(AppStrings.allCategoriesnames.entries.elementAt(categoryController.dropDownValue!.value).toString());
                                // log(AppStrings.allCategoriesnames.keys.elementAt(categoryController.dropDownValue!.value).toString());
                                // log(AppStrings.allCategoriesnames.entries.elementAt(categoryController.dropDownValue!.value).value.toString());
                                // log(AppStrings.allCategoriesnames.entries.elementAt(categoryController.dropDownValue!.value).value[1].toString());
                              });
                            },
                          ),
                          const SizedBox(height: 10),                    
                          DropDownTextField(
                            textFieldDecoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(right: 20, left: 10, bottom: 10),
                              hintText: 'التصنيف -2',
                              alignLabelWithHint: true,
                              labelStyle: TextStyle(
                                color: HexColor('#ECB365'),
                                fontSize: 24,
                                fontWeight: FontWeight.normal,
                                fontFamily:'HSNIbtisam'
                              ),
                            ),
                            controller: subCategoryController,
                            autovalidateMode: AutovalidateMode.always,
                            clearOption: true,
                            validator: (value) {
                              if (value == null) {
                                return "Required field";
                              } else {
                                return null;
                              }
                            },
                            dropDownItemCount: 3,
                            dropDownList: categoryController.dropDownValue == null ? [const DropDownValueModel(name: '', value: 0)]
                            : List.generate( 
                              AppStrings.allCategoriesnames.entries.elementAt(categoryController.dropDownValue!.value).value.length, 
                              (index) => DropDownValueModel(
                                name: AppStrings.allCategoriesnames.entries.elementAt(categoryController.dropDownValue!.value).value[index].toString(),
                                value: index
                              )
                            ),
                            onChanged: (val) {
                              setState(() {
                              log(AppStrings.subSubCategoriesNames[categoryController.dropDownValue!.value].toString());
                              log(AppStrings.subSubCategoriesNames[categoryController.dropDownValue!.value][subCategoryController.dropDownValue!.value].toString());
                              log(AppStrings.subSubCategoriesNames[categoryController.dropDownValue!.value][subCategoryController.dropDownValue!.value][0].toString());
                              });
                            },
                          ),
                          const SizedBox(height: 10),
                          DropDownTextField(
                            dropDownList: (subCategoryController.dropDownValue == null) || (categoryController.dropDownValue == null) ? [const DropDownValueModel(name: '', value: 0)]
                              : List.generate(
                                AppStrings.subSubCategoriesNames[categoryController.dropDownValue!.value][subCategoryController.dropDownValue!.value].length,
                                (index) => DropDownValueModel(
                                  name: AppStrings.subSubCategoriesNames[categoryController.dropDownValue!.value][subCategoryController.dropDownValue!.value][index].toString(), 
                                  value: index
                                )
                              ),
                            textFieldDecoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(right: 20, left: 10, bottom: 10),
                              hintText: 'التصنيف-3',
                              alignLabelWithHint: true,
                              labelStyle: TextStyle(
                                color: HexColor('#ECB365'),
                                fontSize: 24,
                                fontWeight: FontWeight.normal,
                                fontFamily:'HSNIbtisam'
                              ),
                            ),
                            controller: subSubCategoryController,
                            autovalidateMode: AutovalidateMode.always,
                            clearOption: true,
                            validator: (value) {
                              if (value == null) {
                                return "Required field";
                              } else {
                                return null;
                              }
                            },
                            dropDownItemCount: 3,
                            onChanged: (val) => setState((){}),
                          ),
                          const SizedBox(height: 10),
                          defaultTextFormFiel(
                              context,
                              nameController,
                              TextInputType.text,
                              'اسم المحل',
                              1
                          ),
                          const SizedBox(height: 10),
                          defaultTextFormFiel(
                              context,
                              descropationController,
                              TextInputType.text,
                              'وصف المحل',
                              1
                          ),
                          const SizedBox(height: 10),
                          defaultTextFormFiel(
                              context,
                              addressController,
                              TextInputType.streetAddress,
                              'عنوان المحل',
                              1
                          ),
                          const SizedBox(height: 10),
                          defaultTextFormFiel(
                              context,
                              phoneController,
                              TextInputType.number,
                              'رقم التواصل',
                              1
                          ),
                          const SizedBox(height: 10),
                          defaultTextFormFiel(
                              context,
                              whatsappController,
                              TextInputType.number,
                              'رقم واتس',
                              1
                          ),
                          const SizedBox(height: 10),
                          defaultTextFormFiel(
                              context,
                              locationController,
                              TextInputType.url,
                              'الموقع علي الخريطة',
                              1
                          ),
                          const SizedBox(height: 10),
                          defaultTextFormFiel(
                              context,
                              facebookController,
                              TextInputType.url,
                              'الفيسبوك',
                              1
                          ),
                          const SizedBox(height: 10),
                          defaultTextFormFiel(
                              context,
                              instagramController,
                              TextInputType.url,
                              'انستاجرام',
                              1
                          ),
                          const SizedBox(height: 10),
                          defaultTextFormFiel(
                              context,
                              websiteController,
                              TextInputType.url,
                              'الموقع الإلكتروني',
                              1
                          ),
                          const SizedBox(height: 25),
                          InkWell(
                            onTap: ()async{
                              if(
                                (formKey.currentState!.validate()) && 
                                (categoryController.dropDownValue!.name.isNotEmpty) &&
                                (subCategoryController.dropDownValue!.name.isNotEmpty) &&
                                (subSubCategoryController.dropDownValue!.name.isNotEmpty)
                              )
                              {
                                Store newStore = Store(
                                  name: nameController.text.toString(),
                                  address: addressController.text.toString(),
                                  description: descropationController.text.toString(),
                                  phone: phoneController.text.toString(),
                                  whatsapp: whatsappController.text.toString(), 
                                  facebook: facebookController.text.toString(),
                                  instagram: instagramController.text.toString(),
                                  website: websiteController.text.toString(),
                                  location:locationController.text.toString(),
                                );
                                await cubit.addToFireStore(
                                  newStore,
                                  zoneController.dropDownValue!.name.toString(),
                                  categoryController.dropDownValue!.name.toString(),
                                  subCategoryController.dropDownValue!.name.toString(), 
                                  subSubCategoryController.dropDownValue!.name.toString(),
                                  context
                                );
                                Navigator.pop(context);
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
                                    "إنضمام",
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
                        ],
                      )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
  });
  }
}
