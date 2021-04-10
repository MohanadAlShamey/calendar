import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
class NewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: Get.width,
      height: Get.height,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/imgs/bg.png'),
            fit: BoxFit.cover,
            alignment: Alignment.bottomCenter),
      ),
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').orderBy('createdAt',descending: true).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                width: Get.width,
                child: ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      QueryDocumentSnapshot post =
                      snapshot.data.docs[index];
                      print(post);
                      var width = Get.width - 20;
                      var height = 400.0;
                      return Stack(
                        children: [
                          Transform.translate(
                            offset: Offset(-40, 5),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Color.fromARGB(255, 7, 57, 68)
                                    .withOpacity(0.5),
                              ),
                              width: width - 30,
                              height: height - 50,
                            ),
                          ),
                          Center(
                            child: Container(
                              width: width - 20,
                              height: height,
                              margin: EdgeInsets.symmetric(vertical: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Card(
                                elevation: 6,
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: Get.width,
                                      height: 150,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image:
                                          NetworkImage(post.get('img')),
                                          fit: BoxFit.cover,
                                        ),
                                        color:
                                        Color.fromARGB(255, 22, 77, 89),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(4),
                                            topRight: Radius.circular(4)),
                                      ),
                                    ),
                                    Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(post.get('title') ?? '',
                                              style: GoogleFonts.cairo(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold)),
                                        )),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Expanded(
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            post.get('body') ?? '',
                                            softWrap: true,
                                            style: GoogleFonts.cairo(),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        await canLaunch(post.get('url'))
                                            ? await launch(
                                          post.get('url') ?? '',
                                          enableJavaScript: true,
                                        )
                                            : throw 'Could not launch ${post.get('url')}';
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 242, 134, 95),
                                            borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                Radius.circular(4),
                                                bottomRight:
                                                Radius.circular(4))),
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.all(15.0),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Text(' ' + 'pay'.tr,
                                                  style: GoogleFonts.cairo(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight:
                                                      FontWeight.bold)),
                                              Text(
                                                '\$' +
                                                    post
                                                        .get('balance')
                                                        .toString(),
                                                style: GoogleFonts.cairo(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
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
