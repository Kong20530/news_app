import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/web_view.dart';
import 'package:news_app/controllers/news_controller.dart';

import 'login/login_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  NewsController newsController = Get.put(NewsController());
  NewsControllerBusiness newsControllerBusiness = Get.put(NewsControllerBusiness());
  NewsControllerEntertainment newsControllerEntertainment = Get.put(NewsControllerEntertainment());
  NewsControllerHealth newsControllerHealth = Get.put(NewsControllerHealth());
  NewsControllerScience newsControllerScience = Get.put(NewsControllerScience());
  NewsControllerSports newsControllerSports = Get.put(NewsControllerSports());
  NewsControllerTechnology newsControllerTechnology = Get.put(NewsControllerTechnology());

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 70,
          centerTitle: true,
          elevation: 1,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20)
            )
          ),
          
          title: Image.asset(
            "images/logo_login.png",
            height: 60,
            width: 60,
            fit: BoxFit.contain,
          ),

          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                logout(context);
              },
              color: Colors.lightBlue[900],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Text("本日の記事",
                  style: TextStyle(fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,),),
            ),

            GetBuilder<NewsController>(
                init: NewsController(),
                builder: (controller) {
                  return CarouselSlider(
                    options: CarouselOptions(
                        height: 200,
                        autoPlay: true,
                        enlargeCenterPage: true),
                    items: controller.breakingNews.map((instance) {
                      return controller.articleNotFound.value
                          ? const Center()
                          : controller.breakingNews.isEmpty
                          ? const Center(child: CircularProgressIndicator())
                          : Builder(builder: (BuildContext context) {
                        try {
                          return InkWell(
                            onTap: () => Get.to(() =>
                                WebViewNews(newsUrl: instance.url)),
                            child: Stack(children: [
                              ClipRRect(
                                borderRadius:
                                BorderRadius.circular(10),
                                child: Image.network(
                                  instance.urlToImage ?? " ",
                                  fit: BoxFit.fill,
                                  height: double.infinity,
                                  width: double.infinity,
                                  errorBuilder:
                                      (BuildContext context,
                                      Object exception,
                                      StackTrace? stackTrace) {
                                    return Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(
                                              10)),
                                      child: const SizedBox(
                                        height: 200,
                                        width: double.infinity,
                                        child: Icon(Icons
                                            .broken_image_outlined),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                        gradient: LinearGradient(
                                            colors: [Colors.black12.withOpacity(0),
                                              Colors.black],
                                            begin:
                                            Alignment.topCenter,
                                            end: Alignment.bottomCenter)),
                                    child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5,
                                            vertical: 10),
                                        child: Container(
                                            margin: const EdgeInsets
                                                .symmetric(
                                                horizontal: 10),
                                            child: Text(
                                              instance.title,
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ))),
                                  )),
                            ]),
                          );
                        } catch (e) {
                          return Container();
                        }
                      });
                    }).toList(),
                  );
                }),

            const SizedBox(height: 20),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Text("ビジネス",
                style: TextStyle(fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,),),
            ),

            GetBuilder<NewsControllerBusiness>(
                init: NewsControllerBusiness(),
                builder: (controller) {
                  return CarouselSlider(
                    options: CarouselOptions(
                        height: 200,
                        autoPlay: true,
                        enlargeCenterPage: true),
                    items: controller.breakingNews.map((instance) {
                      return controller.articleNotFound.value
                          ? const Center()
                          : controller.breakingNews.isEmpty
                          ? const Center(child: CircularProgressIndicator())
                          : Builder(builder: (BuildContext context) {
                        try {
                          return InkWell(
                            onTap: () => Get.to(() =>
                                WebViewNews(newsUrl: instance.url)),
                            child: Stack(children: [
                              ClipRRect(
                                borderRadius:
                                BorderRadius.circular(10),
                                child: Image.network(
                                  instance.urlToImage ?? " ",
                                  fit: BoxFit.fill,
                                  height: double.infinity,
                                  width: double.infinity,
                                  errorBuilder:
                                      (BuildContext context,
                                      Object exception,
                                      StackTrace? stackTrace) {
                                    return Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(
                                              10)),
                                      child: const SizedBox(
                                        height: 200,
                                        width: double.infinity,
                                        child: Icon(Icons
                                            .broken_image_outlined),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                        gradient: LinearGradient(
                                            colors: [Colors.black12.withOpacity(0),
                                              Colors.black],
                                            begin:
                                            Alignment.topCenter,
                                            end: Alignment.bottomCenter)),
                                    child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5,
                                            vertical: 10),
                                        child: Container(
                                            margin: const EdgeInsets
                                                .symmetric(
                                                horizontal: 10),
                                            child: Text(
                                              instance.title,
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ))),
                                  )),
                            ]),
                          );
                        } catch (e) {
                          return Container();
                        }
                      });
                    }).toList(),
                  );
                }),

            const SizedBox(height: 20),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Text("エンターテイメント",
                style: TextStyle(fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,),),
            ),

            GetBuilder<NewsControllerEntertainment>(
                init: NewsControllerEntertainment(),
                builder: (controller) {
                  return CarouselSlider(
                    options: CarouselOptions(
                        height: 200,
                        autoPlay: true,
                        enlargeCenterPage: true),
                    items: controller.breakingNews.map((instance) {
                      return controller.articleNotFound.value
                          ? const Center()
                          : controller.breakingNews.isEmpty
                          ? const Center(child: CircularProgressIndicator())
                          : Builder(builder: (BuildContext context) {
                        try {
                          return InkWell(
                            onTap: () => Get.to(() =>
                                WebViewNews(newsUrl: instance.url)),
                            child: Stack(children: [
                              ClipRRect(
                                borderRadius:
                                BorderRadius.circular(10),
                                child: Image.network(
                                  instance.urlToImage ?? " ",
                                  fit: BoxFit.fill,
                                  height: double.infinity,
                                  width: double.infinity,
                                  errorBuilder:
                                      (BuildContext context,
                                      Object exception,
                                      StackTrace? stackTrace) {
                                    return Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(
                                              10)),
                                      child: const SizedBox(
                                        height: 200,
                                        width: double.infinity,
                                        child: Icon(Icons
                                            .broken_image_outlined),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                        gradient: LinearGradient(
                                            colors: [Colors.black12.withOpacity(0),
                                              Colors.black],
                                            begin:
                                            Alignment.topCenter,
                                            end: Alignment.bottomCenter)),
                                    child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5,
                                            vertical: 10),
                                        child: Container(
                                            margin: const EdgeInsets
                                                .symmetric(
                                                horizontal: 10),
                                            child: Text(
                                              instance.title,
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ))),
                                  )),
                            ]),
                          );
                        } catch (e) {
                          return Container();
                        }
                      });
                    }).toList(),
                  );
                }),

            const SizedBox(height: 20),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Text("健康",
                style: TextStyle(fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,),),
            ),

            GetBuilder<NewsControllerHealth>(
                init: NewsControllerHealth(),
                builder: (controller) {
                  return CarouselSlider(
                    options: CarouselOptions(
                        height: 200,
                        autoPlay: true,
                        enlargeCenterPage: true),
                    items: controller.breakingNews.map((instance) {
                      return controller.articleNotFound.value
                          ? const Center()
                          : controller.breakingNews.isEmpty
                          ? const Center(child: CircularProgressIndicator())
                          : Builder(builder: (BuildContext context) {
                        try {
                          return InkWell(
                            onTap: () => Get.to(() =>
                                WebViewNews(newsUrl: instance.url)),
                            child: Stack(children: [
                              ClipRRect(
                                borderRadius:
                                BorderRadius.circular(10),
                                child: Image.network(
                                  instance.urlToImage ?? " ",
                                  fit: BoxFit.fill,
                                  height: double.infinity,
                                  width: double.infinity,
                                  errorBuilder:
                                      (BuildContext context,
                                      Object exception,
                                      StackTrace? stackTrace) {
                                    return Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(
                                              10)),
                                      child: const SizedBox(
                                        height: 200,
                                        width: double.infinity,
                                        child: Icon(Icons
                                            .broken_image_outlined),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                        gradient: LinearGradient(
                                            colors: [Colors.black12.withOpacity(0),
                                              Colors.black],
                                            begin:
                                            Alignment.topCenter,
                                            end: Alignment.bottomCenter)),
                                    child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5,
                                            vertical: 10),
                                        child: Container(
                                            margin: const EdgeInsets
                                                .symmetric(
                                                horizontal: 10),
                                            child: Text(
                                              instance.title,
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ))),
                                  )),
                            ]),
                          );
                        } catch (e) {
                          return Container();
                        }
                      });
                    }).toList(),
                  );
                }),

            const SizedBox(height: 20),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Text("科学",
                style: TextStyle(fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,),),
            ),

            GetBuilder<NewsControllerScience>(
                init: NewsControllerScience(),
                builder: (controller) {
                  return CarouselSlider(
                    options: CarouselOptions(
                        height: 200,
                        autoPlay: true,
                        enlargeCenterPage: true),
                    items: controller.breakingNews.map((instance) {
                      return controller.articleNotFound.value
                          ? const Center()
                          : controller.breakingNews.isEmpty
                          ? const Center(child: CircularProgressIndicator())
                          : Builder(builder: (BuildContext context) {
                        try {
                          return InkWell(
                            onTap: () => Get.to(() =>
                                WebViewNews(newsUrl: instance.url)),
                            child: Stack(children: [
                              ClipRRect(
                                borderRadius:
                                BorderRadius.circular(10),
                                child: Image.network(
                                  instance.urlToImage ?? " ",
                                  fit: BoxFit.fill,
                                  height: double.infinity,
                                  width: double.infinity,
                                  errorBuilder:
                                      (BuildContext context,
                                      Object exception,
                                      StackTrace? stackTrace) {
                                    return Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(
                                              10)),
                                      child: const SizedBox(
                                        height: 200,
                                        width: double.infinity,
                                        child: Icon(Icons
                                            .broken_image_outlined),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                        gradient: LinearGradient(
                                            colors: [Colors.black12.withOpacity(0),
                                              Colors.black],
                                            begin:
                                            Alignment.topCenter,
                                            end: Alignment.bottomCenter)),
                                    child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5,
                                            vertical: 10),
                                        child: Container(
                                            margin: const EdgeInsets
                                                .symmetric(
                                                horizontal: 10),
                                            child: Text(
                                              instance.title,
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ))),
                                  )),
                            ]),
                          );
                        } catch (e) {
                          return Container();
                        }
                      });
                    }).toList(),
                  );
                }),

            const SizedBox(height: 20),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Text("スポーツ",
                style: TextStyle(fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,),),
            ),

            GetBuilder<NewsControllerSports>(
                init: NewsControllerSports(),
                builder: (controller) {
                  return CarouselSlider(
                    options: CarouselOptions(
                        height: 200,
                        autoPlay: true,
                        enlargeCenterPage: true),
                    items: controller.breakingNews.map((instance) {
                      return controller.articleNotFound.value
                          ? const Center()
                          : controller.breakingNews.isEmpty
                          ? const Center(child: CircularProgressIndicator())
                          : Builder(builder: (BuildContext context) {
                        try {
                          return InkWell(
                            onTap: () => Get.to(() =>
                                WebViewNews(newsUrl: instance.url)),
                            child: Stack(children: [
                              ClipRRect(
                                borderRadius:
                                BorderRadius.circular(10),
                                child: Image.network(
                                  instance.urlToImage ?? " ",
                                  fit: BoxFit.fill,
                                  height: double.infinity,
                                  width: double.infinity,
                                  errorBuilder:
                                      (BuildContext context,
                                      Object exception,
                                      StackTrace? stackTrace) {
                                    return Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(
                                              10)),
                                      child: const SizedBox(
                                        height: 200,
                                        width: double.infinity,
                                        child: Icon(Icons
                                            .broken_image_outlined),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                        gradient: LinearGradient(
                                            colors: [Colors.black12.withOpacity(0),
                                              Colors.black],
                                            begin:
                                            Alignment.topCenter,
                                            end: Alignment.bottomCenter)),
                                    child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5,
                                            vertical: 10),
                                        child: Container(
                                            margin: const EdgeInsets
                                                .symmetric(
                                                horizontal: 10),
                                            child: Text(
                                              instance.title,
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ))),
                                  )),
                            ]),
                          );
                        } catch (e) {
                          return Container();
                        }
                      });
                    }).toList(),
                  );
                }),

            const SizedBox(height: 20),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Text("テクノロジー",
                style: TextStyle(fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,),),
            ),

            GetBuilder<NewsControllerTechnology>(
                init: NewsControllerTechnology(),
                builder: (controller) {
                  return CarouselSlider(
                    options: CarouselOptions(
                        height: 200,
                        autoPlay: true,
                        enlargeCenterPage: true),
                    items: controller.breakingNews.map((instance) {
                      return controller.articleNotFound.value
                          ? const Center()
                          : controller.breakingNews.isEmpty
                          ? const Center(child: CircularProgressIndicator())
                          : Builder(builder: (BuildContext context) {
                        try {
                          return InkWell(
                            onTap: () => Get.to(() =>
                                WebViewNews(newsUrl: instance.url)),
                            child: Stack(children: [
                              ClipRRect(
                                borderRadius:
                                BorderRadius.circular(10),
                                child: Image.network(
                                  instance.urlToImage ?? " ",
                                  fit: BoxFit.fill,
                                  height: double.infinity,
                                  width: double.infinity,
                                  errorBuilder:
                                      (BuildContext context,
                                      Object exception,
                                      StackTrace? stackTrace) {
                                    return Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(
                                              10)),
                                      child: const SizedBox(
                                        height: 200,
                                        width: double.infinity,
                                        child: Icon(Icons
                                            .broken_image_outlined),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                        gradient: LinearGradient(
                                            colors: [Colors.black12.withOpacity(0),
                                              Colors.black],
                                            begin:
                                            Alignment.topCenter,
                                            end: Alignment.bottomCenter)),
                                    child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5,
                                            vertical: 10),
                                        child: Container(
                                            margin: const EdgeInsets
                                                .symmetric(
                                                horizontal: 10),
                                            child: Text(
                                              instance.title,
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ))),
                                  )),
                            ]),
                          );
                        } catch (e) {
                          return Container();
                        }
                      });
                    }).toList(),
                  );
                }),
          ],
        ),
      ),
      backgroundColor: Colors.grey[300],

    );
  }

  Future<void> logout(BuildContext context) async{
    await FirebaseAuth.instance.signOut();

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) =>
            LoginScreen(),
      ),
    );
  }
}
