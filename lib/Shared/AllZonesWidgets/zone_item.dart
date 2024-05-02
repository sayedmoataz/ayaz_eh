import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../image/cashed_images.dart';



Widget buildPlaceItemRTL(int index, BuildContext context, String image,
    String title,  VoidCallback onTap, double? elevation) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        decoration: BoxDecoration(
          color: HexColor('#e8eef2'),
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          border: Border.all(color: const Color(0xFFEDF0F2)),
        ),
        width: double.infinity,
        child: Row(
          children: <Widget>[
            SizedBox(
              height: 100,
              width: 100,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    topRight: Radius.circular(10)),
                child: defaultNetworkImg(
                  context,
                  double.infinity,
                  double.infinity,
                  image,
                  BoxFit.cover,
                  2,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.w600),
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

Widget buildPlaceItemLTR(int index, BuildContext context, String image,
    String title,  VoidCallback onTap, double? elevation) {
    return InkWell(
      splashColor: Colors.transparent,
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        decoration: BoxDecoration(
          color: HexColor('#e8eef2'),
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          border: Border.all(color: const Color(0xFFEDF0F2)),
        ),
        width: double.infinity,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 100,
              width: 100,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    topRight: Radius.circular(10)),
                child: defaultNetworkImg(
                  context,
                  double.infinity,
                  double.infinity,
                  image,
                  BoxFit.cover,
                  2,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

