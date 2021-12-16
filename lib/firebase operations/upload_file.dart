import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class UploadFile{
   Future uploadToFirebaseStorage(
      File filePath
    ) async{
       if(filePath==null)
       return;

       final destination = 'files/$filePath';
       try{
         final ref = FirebaseStorage.instance.ref(destination);
       return ref.putFile(filePath);
       }
       on FirebaseException catch(e){
          print(e.toString());
       }
    }
}