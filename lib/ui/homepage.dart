import 'package:alemeno/ui/scancamera.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      alignment: Alignment.center,
      height: height,
      width: width,
      child: Column(
        children: [
          const Spacer(),
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.0),
                  color: Theme.of(context).primaryColor),
              height: height * 0.1,
              width: width * 0.7,
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  ScanCameraPage()),
                  );
                },
                child: const Text(
                  "Share your meal",
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              )),
          const SizedBox(
            height: 100.0,
          )
        ],
      ),
    );
  }
}
