


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moms_care/core/data/entities/author.dart';
import 'package:moms_care/core/widget/card/card_author_widget.dart';


class HeaderWidget  extends StatelessWidget {

  const HeaderWidget({super.key,
   required this.author,
    this.onClickMoreOptions});

  final Author author;
  // final DateTime? createdAt;
  final Function()? onClickMoreOptions;

  @override
  Widget build(BuildContext context) {


    return  Container(
      padding:const EdgeInsets.all(10),
      margin: const EdgeInsets.only(left: 2,right: 2, top: 5),
      decoration: BoxDecoration(
        color:Colors.white,
          borderRadius: BorderRadius.circular(0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Expanded(
              child: CardAuthorWidget(author: author!,)
          ),
          const SizedBox(width: 10),
          (FirebaseAuth.instance!.currentUser !=null && FirebaseAuth.instance.currentUser!.uid== author!.id!)?
              IconButton(onPressed: onClickMoreOptions, icon: const Icon(Icons.more_vert_sharp))
              :const SizedBox(),

        ],

      ),
    );
  }

}
