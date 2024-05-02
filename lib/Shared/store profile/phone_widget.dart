import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';


Widget buildPhoneItemRTL(BuildContext context, String phnNum,  VoidCallback onTap, double? elevation) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          color: HexColor('#081C31'),
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        ),
        width: double.infinity,
        child: Row(
          children: <Widget>[
            // SizedBox(
            //   width: 100,
            //   child: ClipRRect(
            //     child: Icon(NewIconsForApp.phone,color: HexColor('#ECB365') , size: 30),
            //   ),
            // ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "إضغط للإتصال الآن",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      phnNum,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
