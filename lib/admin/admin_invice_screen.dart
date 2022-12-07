import 'dart:io';
import 'dart:typed_data';

import 'package:amin/model/BuyDressOrder.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class AdminInviceScreen extends StatefulWidget {
  BuyDressOrder? buyDressOrder;
  AdminInviceScreen({Key? key, required this.buyDressOrder}) : super(key: key);

  @override
  State<AdminInviceScreen> createState() => _AdminInviceScreenState();
}

class _AdminInviceScreenState extends State<AdminInviceScreen> {
  ScreenshotController screenshotController = ScreenshotController();
  ScrollController controller = ScrollController();
  void screenshot()async {
    final image =await screenshotController.captureFromWidget(buildScreen());

    if(image == null) return;

    await saveImage(image);


  }

  Future saveImage(Uint8List bytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final time = DateTime.now().toIso8601String().replaceAll('.', '-').replaceAll(':', '-');
    final name = "screenshot_$time";
    final image = File('${directory.path}/$name.png');
    print("lucky print image path = "+image.path.toString());
    image.writeAsBytesSync(bytes);

    await Share.shareFiles([image.path]);
 /*   await [Permission.storage].request();*/

   /* final time = DateTime.now().toIso8601String().replaceAll('.', '-').replaceAll(':', '-');
    final name = "screenshot_$time";
    final result = await ImageGallerySaver.saveImage(bytes,name: name);
    return result['filePath'];*/
  }


  Widget buildScreen() {

    return Container(
      color: Colors.white,
      child: ListView(shrinkWrap:true,controller: controller,children: [
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: Row(
            children: [
              Text(
                "From :  ",
                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
              Text(
                "Amina Boutique",
                style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),
              )
            ],
          ),
        ),

        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: Row(
            children: [
              Text(
                "WhatsApp number  :  ",
                style: TextStyle(color: Colors.grey, fontSize: 11),
              ),
              Text(
                "+91 8860206392",
                style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 13),
              )
            ],
          ),
        ),

        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Address  :  ",
                style: TextStyle(color: Colors.grey, fontSize: 11),
              ),
              Expanded(
                child: Text(
                  "H.No.D-107, Mansa Ram Park, Uttam Nagar, New Delhi, West Delhi, Delhi, 110059 (India)",
                  style: TextStyle(color: Colors.black,fontSize: 13),
                ),
              )
            ],
          ),
        ),


        /*Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Website  :  ",
                style: TextStyle(color: Colors.grey, fontSize: 11),
              ),
              Expanded(
                child: Text(
                  "www.aminaboutique.in",
                  style: TextStyle(color: Colors.blue,fontSize: 13),
                ),
              )
            ],
          ),
        ),*/


        Container(margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),height: 1,width: MediaQuery.of(context).size.width,color: Colors.grey,),

        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Text(
            "Shipped to",
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                "Name : ",
                style: TextStyle(color: Colors.grey, fontSize: 11),
              ),
              Text(
                widget.buyDressOrder!.userName!,
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                "Email : ",
                style: TextStyle(color: Colors.grey, fontSize: 11),
              ),
              Text(
                widget.buyDressOrder!.userEmail!,
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                "Mobile : ",
                style: TextStyle(color: Colors.grey, fontSize: 11),
              ),
              Text(
                widget.buyDressOrder!.userMobile!,
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                "Adderss : ",
                style: TextStyle(color: Colors.grey, fontSize: 11),
              ),
              Text(
                widget.buyDressOrder!.userAddress!,
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                "Pincode : ",
                style: TextStyle(color: Colors.grey, fontSize: 11),
              ),
              Text(
                widget.buyDressOrder!.userPincode!,
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                "City : ",
                style: TextStyle(color: Colors.grey, fontSize: 11),
              ),
              Text(
                widget.buyDressOrder!.userCity!,
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                "Country : ",
                style: TextStyle(color: Colors.grey, fontSize: 11),
              ),
              Text(
                widget.buyDressOrder!.userCountry!,
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),


        Container(margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),height: 1,width: MediaQuery.of(context).size.width,color: Colors.grey,),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Text(
            "Product Info",
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                "Size :  ",
                style: TextStyle(color: Colors.grey, fontSize: 11),
              ),
              Text(
                widget.buyDressOrder!.dressSize!,
                style: TextStyle(color: Colors.black),
              )
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                "Quantity : ",
                style: TextStyle(color: Colors.grey, fontSize: 11),
              ),
              Text(
                widget.buyDressOrder!.dressQuantity!,
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                "Date & Time : ",
                style: TextStyle(color: Colors.grey, fontSize: 11),
              ),
              Text(
                widget.buyDressOrder!.date! +
                    " & " +
                    widget.buyDressOrder!.time!,
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                "Unit Price : ",
                style: TextStyle(color: Colors.grey, fontSize: 11),
              ),
              Text(
                "₹ " + widget.buyDressOrder!.dressUnitPrice!,
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                "Net Price : ",
                style: TextStyle(color: Colors.grey, fontSize: 11),
              ),
              Text(
                "₹ " + widget.buyDressOrder!.netPrice!,
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),







        SizedBox(height: 20,)
      ],),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: screenshotController,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text("Packing Slip for Order "),),
        body: ListView(
          shrinkWrap: true,
          controller: controller,
          children: [
            buildScreen(),


          Container(margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),height: 1,width: MediaQuery.of(context).size.width,color: Colors.grey,),


            SizedBox(height: 50,),

            InkWell(
              onTap: (){
                screenshot();

                // updateStatus("Completed",buyDress!);

              },
              child: Container(
                margin: const EdgeInsets.all(10),
                height: 50,
                color:  Colors.green,
                child: Center(
                  child: Text(
                    "Genrate Invoice",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
        ],),
      ),
    );
  }
}
