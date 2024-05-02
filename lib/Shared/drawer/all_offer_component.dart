import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../image/cashed_images.dart';

Widget cardHorizontalOffers(
    VoidCallback  callback,
    int index,
    BuildContext context,
    /*Widget myClass,*/
    String img,
    String title,
    String storeName,
    String date
    ) =>InkWell(
    onTap: callback,
    child: Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Card(
        elevation: 1,
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),
          width: double.infinity,
          child: Row(
            children: <Widget>[
              SizedBox(
                height: 125,
                width: MediaQuery.of(context).size.width * .5,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(bottomRight: Radius.circular(10),topRight: Radius.circular(10)),
                  child: defaultNetworkImg(
                    context,
                    double.infinity,
                    double.infinity,
                    img,
                    BoxFit.cover,
                    0,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, height: 1),
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        storeName,
                        style:TextStyle(fontSize: 14, color: HexColor("#484848"), height: 1),
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          date,                          
                          style: TextStyle(fontSize: 14, color: HexColor("#484848"), height: 1),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );