import 'package:flutter/material.dart';

class NewsModel {
  String posterName;
  String postTitle;
  String postType;
  AssetImage postImage;
  String post;
  String date;
  AssetImage image;
  int views;

  NewsModel({
    this.posterName,
    this.postTitle,
    this.postType,
    this.postImage,
    this.post,
    this.date,
    this.views,
  });
}

///?News Data
newGenerator() {
  List<NewsModel> news = [
    NewsModel(
      posterName: "Dr. Asrat the legend",
      postImage: AssetImage('assets/images/fasil.jpg'),
      postTitle:
          "As above so below! shall though be take upt theme dau lent me thy sword As above so below! shall though be take upt theme dau lent me thy sword",
      post:
          """The Lord answered and said, "What is your merit if you do the will of the Father and it is not given to you from him as a gift while you are tempted by Satan? But if you are oppressed by Satan, and persecuted, and you do his (i.e., the Father's) will, I say that he will love you, and make you equal with me, and reckon you to have become beloved through his providence by your own choice. So will you not cease loving the flesh and being afraid of sufferings? Or do you not know that you have yet to be abused and to be accused unjustly; and have yet to be shut up in prison, and condemned unlawfully, and crucified <without> reason, and buried as I myself, by the evil one? Do you dare to spare the flesh, you for whom the Spirit is an encircling wall? If you consider how long the world existed <before> you, and how long it will exist after you, you will find that your life is one single day, and your sufferings one single hour. For the good will not enter into the world. Scorn death, therefore, and take thought for life! Remember my cross and my death, and you will live!, \n
      ,The Lord answered and said, "What is your merit if you do the will of the Father and it is not given to you from him as a gift while you are tempted by Satan? But if you are oppressed by Satan, and persecuted, and you do his (i.e., the Father's) will, I say that he will love you, and make you equal with me, and reckon you to have become beloved through his providence by your own choice. So will you not cease loving the flesh and being afraid of sufferings? Or do you not know that you have yet to be abused and to be accused unjustly; and have yet to be shut up in prison, and condemned unlawfully, and crucified <without> reason, and buried as I myself, by the evil one? Do you dare to spare the flesh, you for whom the Spirit is an encircling wall? If you consider how long the world existed <before> you, and how long it will exist after you, you will find that your life is one single day, and your sufferings one single hour. For the good will not enter into the world. Scorn death, therefore, and take thought for life! Remember my cross and my death, and you will live!""",
      postType: "News",
      views: 4,
      date: "June 25, 2021",
    ),
    NewsModel(
      posterName: "Mr. Mikeal",
      postImage: AssetImage('assets/images/pic6.jpg'),
      postTitle:
          "As above so below! shall though be take upt theme dau lent me thy sword As above so below! shall though be take upt theme dau lent me thy sword",
      post:
          """The Lord answered and said, "What is your merit if you do the will of the Father and it is not given to you from him as a gift while you are tempted by Satan? But if you are oppressed by Satan, and persecuted, and you do his (i.e., the Father's) will, I say that he will love you, and make you equal with me, and reckon you to have become beloved through his providence by your own choice. So will you not cease loving the flesh and being afraid of sufferings? Or do you not know that you have yet to be abused and to be accused unjustly; and have yet to be shut up in prison, and condemned unlawfully, and crucified <without> reason, and buried as I myself, by the evil one? Do you dare to spare the flesh, you for whom the Spirit is an encircling wall? If you consider how long the world existed <before> you, and how long it will exist after you, you will find that your life is one single day, and your sufferings one single hour. For the good will not enter into the world. Scorn death, therefore, and take thought for life! Remember my cross and my death, and you will live!, \n
      ,The Lord answered and said, "What is your merit if you do the will of the Father and it is not given to you from him as a gift while you are tempted by Satan? But if you are oppressed by Satan, and persecuted, and you do his (i.e., the Father's) will, I say that he will love you, and make you equal with me, and reckon you to have become beloved through his providence by your own choice. So will you not cease loving the flesh and being afraid of sufferings? Or do you not know that you have yet to be abused and to be accused unjustly; and have yet to be shut up in prison, and condemned unlawfully, and crucified <without> reason, and buried as I myself, by the evil one? Do you dare to spare the flesh, you for whom the Spirit is an encircling wall? If you consider how long the world existed <before> you, and how long it will exist after you, you will find that your life is one single day, and your sufferings one single hour. For the good will not enter into the world. Scorn death, therefore, and take thought for life! Remember my cross and my death, and you will live!""",
      postType: "News",
      views: 10,
      date: "June 25, 2021",
    ),
    NewsModel(
      posterName: "Dr. Tewodros",
      postImage: AssetImage('assets/images/Gondar-University.jpg'),
      postTitle:
          "As above so below! shall though be take upt theme dau lent me thy sword As above so below! shall though be take upt theme dau lent me thy sword",
      post:
          """The Lord answered and said, "What is your merit if you do the will of the Father and it is not given to you from him as a gift while you are tempted by Satan? But if you are oppressed by Satan, and persecuted, and you do his (i.e., the Father's) will, I say that he will love you, and make you equal with me, and reckon you to have become beloved through his providence by your own choice. So will you not cease loving the flesh and being afraid of sufferings? Or do you not know that you have yet to be abused and to be accused unjustly; and have yet to be shut up in prison, and condemned unlawfully, and crucified <without> reason, and buried as I myself, by the evil one? Do you dare to spare the flesh, you for whom the Spirit is an encircling wall? If you consider how long the world existed <before> you, and how long it will exist after you, you will find that your life is one single day, and your sufferings one single hour. For the good will not enter into the world. Scorn death, therefore, and take thought for life! Remember my cross and my death, and you will live!, \n
      ,The Lord answered and said, "What is your merit if you do the will of the Father and it is not given to you from him as a gift while you are tempted by Satan? But if you are oppressed by Satan, and persecuted, and you do his (i.e., the Father's) will, I say that he will love you, and make you equal with me, and reckon you to have become beloved through his providence by your own choice. So will you not cease loving the flesh and being afraid of sufferings? Or do you not know that you have yet to be abused and to be accused unjustly; and have yet to be shut up in prison, and condemned unlawfully, and crucified <without> reason, and buried as I myself, by the evil one? Do you dare to spare the flesh, you for whom the Spirit is an encircling wall? If you consider how long the world existed <before> you, and how long it will exist after you, you will find that your life is one single day, and your sufferings one single hour. For the good will not enter into the world. Scorn death, therefore, and take thought for life! Remember my cross and my death, and you will live!""",
      postType: "News",
      views: 10,
      date: "June 25, 2021",
    ),
    NewsModel(
      posterName: "Mr. Nobody",
      postImage: AssetImage('assets/images/new_image.jpg'),
      postTitle:
          "As above so below! shall though be take upt theme dau lent me thy sword As above so below! shall though be take upt theme dau lent me thy sword",
      post:
          """The Lord answered and said, "What is your merit if you do the will of the Father and it is not given to you from him as a gift while you are tempted by Satan? But if you are oppressed by Satan, and persecuted, and you do his (i.e., the Father's) will, I say that he will love you, and make you equal with me, and reckon you to have become beloved through his providence by your own choice. So will you not cease loving the flesh and being afraid of sufferings? Or do you not know that you have yet to be abused and to be accused unjustly; and have yet to be shut up in prison, and condemned unlawfully, and crucified <without> reason, and buried as I myself, by the evil one? Do you dare to spare the flesh, you for whom the Spirit is an encircling wall? If you consider how long the world existed <before> you, and how long it will exist after you, you will find that your life is one single day, and your sufferings one single hour. For the good will not enter into the world. Scorn death, therefore, and take thought for life! Remember my cross and my death, and you will live!, \n
      ,The Lord answered and said, "What is your merit if you do the will of the Father and it is not given to you from him as a gift while you are tempted by Satan? But if you are oppressed by Satan, and persecuted, and you do his (i.e., the Father's) will, I say that he will love you, and make you equal with me, and reckon you to have become beloved through his providence by your own choice. So will you not cease loving the flesh and being afraid of sufferings? Or do you not know that you have yet to be abused and to be accused unjustly; and have yet to be shut up in prison, and condemned unlawfully, and crucified <without> reason, and buried as I myself, by the evil one? Do you dare to spare the flesh, you for whom the Spirit is an encircling wall? If you consider how long the world existed <before> you, and how long it will exist after you, you will find that your life is one single day, and your sufferings one single hour. For the good will not enter into the world. Scorn death, therefore, and take thought for life! Remember my cross and my death, and you will live!""",
      postType: "News",
      views: 2,
      date: "June 25, 2021",
    ),
    NewsModel(
      posterName: "UoG Students Hibret",
      postImage: AssetImage('assets/images/new_image2.jpg'),
      postTitle:
          "As above so below! shall though be take upt theme dau lent me thy sword As above so below! shall though be take upt theme dau lent me thy sword",
      post:
          """The Lord answered and said, "What is your merit if you do the will of the Father and it is not given to you from him as a gift while you are tempted by Satan? But if you are oppressed by Satan, and persecuted, and you do his (i.e., the Father's) will, I say that he will love you, and make you equal with me, and reckon you to have become beloved through his providence by your own choice. So will you not cease loving the flesh and being afraid of sufferings? Or do you not know that you have yet to be abused and to be accused unjustly; and have yet to be shut up in prison, and condemned unlawfully, and crucified <without> reason, and buried as I myself, by the evil one? Do you dare to spare the flesh, you for whom the Spirit is an encircling wall? If you consider how long the world existed <before> you, and how long it will exist after you, you will find that your life is one single day, and your sufferings one single hour. For the good will not enter into the world. Scorn death, therefore, and take thought for life! Remember my cross and my death, and you will live!, \n
      ,The Lord answered and said, "What is your merit if you do the will of the Father and it is not given to you from him as a gift while you are tempted by Satan? But if you are oppressed by Satan, and persecuted, and you do his (i.e., the Father's) will, I say that he will love you, and make you equal with me, and reckon you to have become beloved through his providence by your own choice. So will you not cease loving the flesh and being afraid of sufferings? Or do you not know that you have yet to be abused and to be accused unjustly; and have yet to be shut up in prison, and condemned unlawfully, and crucified <without> reason, and buried as I myself, by the evil one? Do you dare to spare the flesh, you for whom the Spirit is an encircling wall? If you consider how long the world existed <before> you, and how long it will exist after you, you will find that your life is one single day, and your sufferings one single hour. For the good will not enter into the world. Scorn death, therefore, and take thought for life! Remember my cross and my death, and you will live!""",
      postType: "News",
      views: 2,
      date: "June 25, 2021",
    ),
  ];

  return news;
}
