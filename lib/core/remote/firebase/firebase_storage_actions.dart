

import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:moms_care/core/constants/api_servers.dart';
import 'package:moms_care/core/error/extination_valid.dart';
import 'package:path/path.dart' as Path;
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageActions {


  static  Reference _getReference(File file, String? folder){

    FirebaseStorage storage = FirebaseStorage.instance;
    var extension=Path.extension(file.path) ?? "";
    print("extension:${extension}");
    String userId = FirebaseAuth.instance.currentUser?.uid ?? "";
    String fileName ="$ID_APP${userId}_${DateTime.now().toIso8601String()}_${extension!}";
    Reference ref = storage.ref(folder).child(fileName);
    return ref;
  }
  static  Future<void> deleteFile({required String fileUrl}) async {

    try{
        if (fileUrl.isNotEmpty && fileUrl!.isValidFirebaseStorageURL) {
          FirebaseStorage storage = FirebaseStorage.instance;
          final ref = storage.refFromURL(fileUrl);
          await ref.delete();
        }
      } on FirebaseException catch (e) {
      throw FirebaseException(message: e.message,plugin: e.plugin);
    }
  }
  static  Future<String> uploadFile({
    required File file,
    String? folder=""
  }) async {
    try{
        Reference ref =  _getReference(file,folder);
        await ref.putFile(file);
        String downloadURL = await ref.getDownloadURL();
        return downloadURL;

  } on FirebaseException catch (e) {
      print('Error occurred: $e');
      throw FirebaseException(plugin: e.plugin);
  }
  }



 static  Future<void> uploadFileAsync({
     required File file,
     required Function(String) onUploadCompleted,
     String? folder=""
   }) async {
    try {

      // FirebaseStorage storage = FirebaseStorage.instance;
      // String userId = FirebaseAuth.instance.currentUser?.uid ?? "";
      // String fileName = '$ID_APP${userId}_${DateTime.now().toIso8601String()}';
      // Reference ref = storage.ref(folder).child(fileName);

      Reference ref =  _getReference(file,folder);
      UploadTask uploadTask = ref.putFile(file);
      await uploadTask.whenComplete(() async {
        String downloadURL = await ref.getDownloadURL();
        onUploadCompleted(downloadURL);
        print('File uploaded. Download URL: $downloadURL');
      });
    } on FirebaseException catch (e) {
      print('Error occurred: $e');
      throw FirebaseException(plugin: e.plugin);
    }
  }
}