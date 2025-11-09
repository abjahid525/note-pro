import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_pro/style/app_style.dart';

Widget noteCard(Function()? onTap, QueryDocumentSnapshot doc){
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: AppStyle.cardsColor[doc['color_id']],
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(51),
            spreadRadius: 1,
            blurRadius: 6,
            offset: Offset(3, 4)
          )
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(doc["note_title"],style: AppStyle.mainTitle,),
          SizedBox(height: 4.0,),
          Text(
            DateFormat('dd MMM yyyy, hh:mm a')
                .format((doc["creation_date"] as Timestamp).toDate()),
            style: AppStyle.dateTitle,
          ),
          SizedBox(height: 8.0,),
          Text(doc["note_content"],style: AppStyle.mainContent, overflow: TextOverflow.ellipsis,)
        ],
      ),
    ),
  );
}