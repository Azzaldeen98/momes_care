import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';


import '../entities/author.dart';



class DateTimeViewModel extends Equatable{

   String?  get date =>  _date;
   String?  get time => _time;
   late String _date="",_time="";

  DateTimeViewModel({required DateTime dateTime}){
    if(dateTime!=null) {
      _date = ("${dateTime.day}/${dateTime.month}/${dateTime.year}");
      _time = "${dateTime.hour}:${dateTime.minute}";
    }
  }

  @override
  List<Object?> get props =>[date,time];

}
