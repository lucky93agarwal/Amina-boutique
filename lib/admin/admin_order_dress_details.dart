import 'package:amin/admin/admin_invice_screen.dart';
import 'package:amin/model/BuyDressOrder.dart';
import 'package:amin/utils/next_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AdminOrderDressDetailsScreen extends StatefulWidget {
  BuyDressOrder? buyDressOrder;

  String? refId;
  AdminOrderDressDetailsScreen({Key? key, required this.buyDressOrder,required this.refId})
      : super(key: key);

  @override
  State<AdminOrderDressDetailsScreen> createState() =>
      _AdminOrderDressDetailsScreenState();
}

class _AdminOrderDressDetailsScreenState
    extends State<AdminOrderDressDetailsScreen> {
  BuyDressOrder? buyDress;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buyDress = widget.buyDressOrder;
  }


  void updateStatus(String orderStatus,BuyDressOrder model)async{
    print("Lucky check visible orderStatus =  "+orderStatus);
    print("Lucky check visible widget.refId =  "+widget.refId!);
    model.setdeliveryStatus = orderStatus;
    FirebaseFirestore.instance.collection('BuyDress').doc(widget.refId).update(model.toJson());

    Navigator.pop(context);
  }
  String emailURL = "";
  String mainURl = "";

  sendEmailShipping()async {
    mainURl = "https://androcoders.com/api/aminaboutique/ordershipped.php?email="+ widget.buyDressOrder!.userEmail!;
    sendMaile();
  }
  sendEmailCompleted()async {
    mainURl = "https://androcoders.com/api/aminaboutique/ordercompleted.php?email="+ widget.buyDressOrder!.userEmail!;
    sendMaile();
  }
  var requestEmail;
  sendMaile()async {
    print("emailURL full Complete =   "+mainURl);
    requestEmail = http.Request('POST', Uri.parse(mainURl));


    http.StreamedResponse response = await requestEmail.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      mainURl = "";
    }
    else {
      print(response.reasonPhrase);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Details"),
      ),
      body: ListView(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 300,
            margin: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5.0,
                  ),
                ],
                image: DecorationImage(
                    image: NetworkImage(widget.buyDressOrder!.dressImg!),
                    fit: BoxFit.fill)),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              widget.buyDressOrder!.dressTitle!,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                  style: TextStyle(color: Colors.white),
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
                  style: TextStyle(color: Colors.white),
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
                  style: TextStyle(color: Colors.white),
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
                  style: TextStyle(color: Colors.white),
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
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),



          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              "User Info",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: 100,
            height: 130,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5.0,
                  ),
                ],
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                image: DecorationImage(
                    image: NetworkImage(
                      widget.buyDressOrder!.userImg!,
                    ),
                    fit: BoxFit.fill)),
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
                  style: TextStyle(color: Colors.white),
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
                  style: TextStyle(color: Colors.white),
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
                  style: TextStyle(color: Colors.white),
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
                  style: TextStyle(color: Colors.white),
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
                  style: TextStyle(color: Colors.white),
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
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          height: 50,
                          color: widget.buyDressOrder!.deliveryStatus == "Ordered"? Colors.green : Colors.red,
                          child: Center(
                            child: Text(
                              "Ordered",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )),
                    Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: (){

                          },
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            height: 50,
                            color:  widget.buyDressOrder!.deliveryStatus == "Processing"? Colors.green : Colors.red,
                            child: Center(
                              child: Text(
                                "Processing",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        )),
                  ],
                ),


                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: (){

                            if(widget.buyDressOrder!.deliveryStatus == "Completed"){

                            }else {
                              mainURl ="";
                              sendEmailShipping();
                              updateStatus("Shipped",buyDress!);

                            }


                          },
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            height: 50,
                            color:  widget.buyDressOrder!.deliveryStatus == "Shipped"? Colors.green : Colors.red,
                            child: Center(
                              child: Text(
                                "Shipped",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        )),
                    Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: (){
                            mainURl ="";
                            sendEmailCompleted();
                              updateStatus("Completed",buyDress!);

                          },
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            height: 50,
                            color:  widget.buyDressOrder!.deliveryStatus == "Completed"? Colors.green : Colors.red,
                            child: Center(
                              child: Text(
                                "Completed",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
                InkWell(
                  onTap: (){
                    nextScreenReplace(context, AdminInviceScreen(buyDressOrder:widget.buyDressOrder!));

                    // updateStatus("Completed",buyDress!);

                  },
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    height: 50,
                    color:  Colors.green,
                    child: Center(
                      child: Text(
                        "Invoice",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
