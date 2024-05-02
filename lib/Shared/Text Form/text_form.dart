import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

Widget defaultTextFormFiel(
  BuildContext context,
  TextEditingController? controller,
  TextInputType? inputType,
  String? label,
  int? lines,
) => TextFormField(
  onEditingComplete: () => FocusScope.of(context).nextFocus(),
  controller: controller,
  keyboardType: inputType,
  maxLines: lines,
  textAlign: TextAlign.right,
  textDirection: TextDirection.rtl,
  validator: (value) {
    if(value!.isEmpty){
      return 'هذا الحقل مطلوب';
    }
  },
  decoration: InputDecoration(
    contentPadding: const EdgeInsets.only(right: 20, left: 10, bottom: 10),
    hintText: label,
    alignLabelWithHint: true,
    labelStyle: TextStyle(
      color: HexColor('#ECB365'),
      fontSize: 24,
      fontWeight: FontWeight.normal,
      fontFamily:'HSNIbtisam'
    ),
    border: OutlineInputBorder(borderSide:BorderSide(color: HexColor('#ECB365'))),
    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: HexColor('#ECB365'))),
    enabledBorder: OutlineInputBorder(borderSide:BorderSide(color: HexColor('#ECB365'))),
    fillColor: HexColor('#ECB365')
  ),
);
