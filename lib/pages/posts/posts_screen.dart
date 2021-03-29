import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';



class PostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Page')),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                width: Get.width *0.75,
                child: ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      var post = snapshot.data.docs[index];
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Card(
                          elevation: 6,
                          child: Column(
                            children: [
                              Center(child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(post.get('title'),style:TextStyle(fontSize: 23,fontWeight: FontWeight.bold)),
                              )),
                              Container(
                                width: 200,
                                height: 150,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(post.get('img')),
                                      fit: BoxFit.cover,
                                    ),
                                    color: Colors.red,
                                borderRadius: BorderRadius.circular(8)),
                              ),
                              SizedBox(height: 5,),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(post.get('body'),softWrap: true,),
                              ),
                              SizedBox(height: 5,),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(child:  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: RaisedButton(onPressed: ()async{
                                      await canLaunch(post.get('url')) ? await launch(post.get('url'),enableJavaScript: true,) : throw 'Could not launch ${post.get('url')}';

                                    },child: Text('pay'.tr),color: Colors.blue.shade700,),
                                  ),width: Get.width/2,),
                                  Container(padding: EdgeInsets.all(7.5),child: Text('\$'+post.get('balance').toString(),style: TextStyle(fontSize: 15),),color: Colors.blue.shade700,)
                                ],
                              ),
                            )
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            );
          } else {
            return Text('loading');
          }
        },
      ),
    );
  }


}
