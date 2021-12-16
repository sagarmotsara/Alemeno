import 'dart:io';

import 'package:alemeno/firebase%20operations/upload_file.dart';
import 'package:alemeno/functionality/notificationapi.dart';
import 'package:alemeno/ui/message.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ScanCameraPage extends StatefulWidget {
   const ScanCameraPage({ Key? key }) : super(key: key);
  

  @override
  _ScanCameraPageState createState() => _ScanCameraPageState();
}

class _ScanCameraPageState extends State<ScanCameraPage> {
 
 @override
 void initState() {
   super.initState();
   NotificationApi.init();
 }
 File ?imageFile;
 void pickImage() async{
   final image = await ImagePicker().pickImage(source: ImageSource.camera);
   if(image?.path!=null){
      setState(() {
        imageFile = File(image!.path);
      });
   }
   else{

   }
 }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
         children: [
           const SizedBox(
             height: 50.0,
           ),
           Row(children: [
             const SizedBox(width: 20.0,
             ),
             GestureDetector(
               onTap: (){
                Navigator.pop(context);
               },
               child: const CircleAvatar(
                 radius: 20.0,
                 child: Icon(Icons.arrow_back),
               ),
             )
           ],),
           const SizedBox(height: 50.0,),
           const Image( 
             fit: BoxFit.cover,
             image: AssetImage("assets/alemeno.jpeg")),
           const SizedBox(height: 50.0,),
         imageFile!=null?
          Container(
           width: 190.0,
      height: 190.0,
      decoration:  BoxDecoration(
          shape: BoxShape.circle,
          image:  DecorationImage(
          fit: BoxFit.fill,
          image:  FileImage(imageFile!)
          )
          
          )
            
          ): 
           CustomPaint(
              foregroundPainter: BorderPainter(),
             child: Container(
             width: 190.0,
                 height: 190.0,
                 decoration:  const BoxDecoration(
                     shape: BoxShape.circle,
                     color: Colors.black87
                     
                     )
              
                     ),
           ),
          const SizedBox(height: 50.0,),
           Text(imageFile==null? "Click your meal": "Will you eat this?", style: TextStyle(fontSize: 25.0, color: Colors.black87),),
          const SizedBox(height: 50.0,),
          GestureDetector(
            onTap: () async{
              if(imageFile==null){
                 pickImage();
              }
              else {
                  await UploadFile().uploadToFirebaseStorage(imageFile!);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  const MessagePage()));
                  NotificationApi.showNotification( title: "Hurrey!", body: "Your image has been uploded succesfully", payload: 'sarah.abs');
                   

              }
            },
            child:  CircleAvatar(
              radius: 30.0,
              child: Icon(imageFile==null?Icons.photo_camera: Icons.done_outlined),
            ),
          )
         ],
      ),
    );
  }
  
}

class BorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double sh = size.height; // for convenient shortage
    double sw = size.width; // for convenient shortage
    double cornerSide = sh * 0.1; // desirable value for corners side

    Paint paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Path path = Path()
      ..moveTo(cornerSide, 0)
      ..quadraticBezierTo(0, 0, 0, cornerSide)
      ..moveTo(0, sh - cornerSide)
      ..quadraticBezierTo(0, sh, cornerSide, sh)
      ..moveTo(sw - cornerSide, sh)
      ..quadraticBezierTo(sw, sh, sw, sh - cornerSide)
      ..moveTo(sw, cornerSide)
      ..quadraticBezierTo(sw, 0, sw - cornerSide, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(BorderPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(BorderPainter oldDelegate) => false;
}