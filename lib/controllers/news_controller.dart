import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/model/article_model.dart';
import 'package:news_app/model/news_model.dart';

class NewsController extends GetxController {

  List<ArticleModel> breakingNews = <ArticleModel>[];
  ScrollController scrollController = ScrollController();
  RxBool articleNotFound = false.obs;
  RxBool isLoading = false.obs;
  RxString cName = ''.obs;
  RxString country = ''.obs;
  RxString category = ''.obs;
  RxString channel = ''.obs;
  RxString searchNews = ''.obs;
  RxInt pageNum = 1.obs;
  RxInt pageSize = 10.obs;
  String baseUrl = "https://newsapi.org/v2/top-headlines?";

  @override
  void onInit() {
    scrollController = ScrollController()..addListener(_scrollListener);
    getBreakingNews();
    super.onInit();
  }

  _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      isLoading.value = true;
      getBreakingNews();
    }
  }

  getBreakingNews({reload = false}) async {
    articleNotFound.value = false;

    if (!reload && isLoading.value == false) {
    } else {
      country.value = '';
    }
    if (isLoading.value == true) {
      pageNum++;
    } else {
      breakingNews = [];

      pageNum.value = 2;
    }

    baseUrl = "https://newsapi.org/v2/top-headlines?pageSize=10&page=$pageNum&languages=en&country=jp&apiKey=ca73d228d19749d885e8a2195b5bfb3b";
    print([baseUrl]);
    getBreakingNewsFromApi(baseUrl);
  }

  getBreakingNewsFromApi(url) async {
    http.Response res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      NewsModel newsData = NewsModel.fromJson(jsonDecode(res.body));

      if (newsData.articles.isEmpty && newsData.totalResults == 0) {
        articleNotFound.value = isLoading.value == true ? false : true;
        isLoading.value = false;
        update();
      } else {
        if (isLoading.value == true) {
          breakingNews = [...breakingNews, ...newsData.articles];
          update();
        } else {
          if (newsData.articles.isNotEmpty) {
            breakingNews = newsData.articles;
            if (scrollController.hasClients) scrollController.jumpTo(0.0);
            update();
          }
        }
        articleNotFound.value = false;
        isLoading.value = false;
        update();
      }
    } else {
      articleNotFound.value = true;
      update();
    }
  }
}

class NewsControllerBusiness extends NewsController {
  @override
  getBreakingNews({reload = false}) async {
    articleNotFound.value = false;

    if (!reload && isLoading.value == false) {} else {
      country.value = '';
    }
    if (isLoading.value == true) {
      pageNum++;
    } else {
      breakingNews = [];

      pageNum.value = 2;
    }

    baseUrl = "https://newsapi.org/v2/top-headlines?pageSize=10&page=$pageNum&languages=en&country=jp&category=business&apiKey=ca73d228d19749d885e8a2195b5bfb3b";
    print([baseUrl]);
    getBreakingNewsFromApi(baseUrl);
  }
}

class NewsControllerEntertainment extends NewsController {
  @override
  getBreakingNews({reload = false}) async {
    articleNotFound.value = false;

    if (!reload && isLoading.value == false) {} else {
      country.value = '';
    }
    if (isLoading.value == true) {
      pageNum++;
    } else {
      breakingNews = [];

      pageNum.value = 2;
    }

    baseUrl = "https://newsapi.org/v2/top-headlines?pageSize=10&page=$pageNum&languages=en&country=jp&category=entertainment&apiKey=ca73d228d19749d885e8a2195b5bfb3b";
    print([baseUrl]);
    getBreakingNewsFromApi(baseUrl);
  }
}

class NewsControllerHealth extends NewsController {
  @override
  getBreakingNews({reload = false}) async {
    articleNotFound.value = false;

    if (!reload && isLoading.value == false) {} else {
      country.value = '';
    }
    if (isLoading.value == true) {
      pageNum++;
    } else {
      breakingNews = [];

      pageNum.value = 2;
    }

    baseUrl = "https://newsapi.org/v2/top-headlines?pageSize=10&page=$pageNum&languages=en&country=jp&category=health&apiKey=ca73d228d19749d885e8a2195b5bfb3b";
    print([baseUrl]);
    getBreakingNewsFromApi(baseUrl);
  }
}

class NewsControllerScience extends NewsController {
  @override
  getBreakingNews({reload = false}) async {
    articleNotFound.value = false;

    if (!reload && isLoading.value == false) {} else {
      country.value = '';
    }
    if (isLoading.value == true) {
      pageNum++;
    } else {
      breakingNews = [];

      pageNum.value = 2;
    }

    baseUrl = "https://newsapi.org/v2/top-headlines?pageSize=10&page=$pageNum&languages=en&country=jp&category=science&apiKey=ca73d228d19749d885e8a2195b5bfb3b";
    print([baseUrl]);
    getBreakingNewsFromApi(baseUrl);
  }
}

class NewsControllerSports extends NewsController {
  @override
  getBreakingNews({reload = false}) async {
    articleNotFound.value = false;

    if (!reload && isLoading.value == false) {} else {
      country.value = '';
    }
    if (isLoading.value == true) {
      pageNum++;
    } else {
      breakingNews = [];

      pageNum.value = 2;
    }

    baseUrl = "https://newsapi.org/v2/top-headlines?pageSize=10&page=$pageNum&languages=en&country=jp&category=sports&apiKey=ca73d228d19749d885e8a2195b5bfb3b";
    print([baseUrl]);
    getBreakingNewsFromApi(baseUrl);
  }
}

class NewsControllerTechnology extends NewsController {
  @override
  getBreakingNews({reload = false}) async {
    articleNotFound.value = false;

    if (!reload && isLoading.value == false) {} else {
      country.value = '';
    }
    if (isLoading.value == true) {
      pageNum++;
    } else {
      breakingNews = [];

      pageNum.value = 2;
    }

    baseUrl = "https://newsapi.org/v2/top-headlines?pageSize=10&page=$pageNum&languages=en&country=jp&category=technology&apiKey=ca73d228d19749d885e8a2195b5bfb3b";
    print([baseUrl]);
    getBreakingNewsFromApi(baseUrl);
  }
}