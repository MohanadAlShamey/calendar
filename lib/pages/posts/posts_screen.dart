import 'dart:ui';

import 'package:calendar/constants.dart';
import 'package:calendar/pages/home/home_controller.dart';
import 'package:calendar/route/route_app.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

class PostScreen extends GetWidget<HomeController> {
  var box = GetStorage(APPNAME);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        items: [
          BottomNavigationBarItem(
            title: Text('news'.tr, style: TextStyle(color: Colors.white)),
            icon: IconButton(
                icon: Icon(
                  Icons.notification_important,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  Get.toNamed(RoutesApp.NEWSPAGE);
                }),
          ),
          BottomNavigationBarItem(
            title: Text(
              'home'.tr,
              style: TextStyle(color: Colors.white),
            ),
            icon: IconButton(
                icon: Icon(
                  Icons.home,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  Get.toNamed(RoutesApp.HOMEPAGE);
                }),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            width: Get.width,
            height: Get.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/imgs/bg.jpg'), fit: BoxFit.cover),
            ),
            child: new BackdropFilter(
              filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: new Container(
                decoration:
                    new BoxDecoration(color: Colors.white.withOpacity(0.0)),
              ),
            ),
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection('posts').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    width: Get.width * 0.85,
                    child: ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          QueryDocumentSnapshot post = snapshot.data.docs[index];

                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Card(
                              elevation: 6,
                              child: Column(
                                children: [
                                  Center(
                                      child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(post.get('title')??'',
                                        style: TextStyle(
                                            fontSize: 23,
                                            fontWeight: FontWeight.bold)),
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
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      post.get('body')??'',
                                      softWrap: true,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        SizedBox(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: RaisedButton(
                                              onPressed: () async {
                                                await canLaunch(post.get('url'))
                                                    ? await launch(
                                                        post.get('url')??'',
                                                        enableJavaScript: true,
                                                      )
                                                    : throw 'Could not launch ${post.get('url')}';
                                              },
                                              child: Row(
                                                children: [
                                                  Icon(
                                                      Icons
                                                          .monetization_on_outlined,
                                                      color: Colors.white),
                                                  SizedBox(width: 10,),
                                                  RichText(
                                                    text: TextSpan(
                                                      text: '\$' +
                                                          post
                                                              .get('balance')
                                                              .toString(),
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.red),
                                                      children: [
                                                        TextSpan(
                                                          text: ' '+'pay'.tr,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              color: Colors.blue.shade700,
                                            ),
                                          ),
                                          width: Get.width / 2,
                                        ),
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
        ],
      ),
    );
  }
}
