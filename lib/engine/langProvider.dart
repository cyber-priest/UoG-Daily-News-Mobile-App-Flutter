import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uog_daily/engine/dataProvider.dart';

class LangModel {
  //Drawer
  String drawerHeader;
  String setting;
  String contactUs;
  String about;
  String services;
  //Settings
  String changeTheme;
  String changeLang;
  String changeRole;
  String changeCampuse;
  String lightMode;
  String darkMode;
  String amharic;
  String english;
  String yourPosts;
  String personalize;
  String status;
  //AppBar
  String searchPlace;
  //bottomNav
  String home;
  String post;
  String schedule;
  String profile;
  String news;
  //Home
  String breakingNews;
  String recent;
  //Schedule
  String openFile;
  String downloadFile;
  String downloading;
  //Profile
  String edit;
  String logOut;
  String delete;
  String cancel;
  String email;
  String emailError;
  String passwordError;
  String password;
  String login;
  String loginError;
  String deleteTitle;
  String deleteWarning;
  String deleteSuccess;
  String deleteFail;
  String authUser;
  //CreatePost
  String createPost;
  String title;
  String body;
  String addImage;
  String addFile;
  String addChangeImage;
  String postData;
  String bodyError;
  String titleError;
  String postSuccess;
  String invalidImage;
  String invalidFile;
  String postError;
  String uploadEror;
  String all;
  String student;
  String teacher;
  String staff;
  String tewodros;
  String fasile;
  String maraki;
  String gc;
  String teda;
  //Edit
  String editSuccess;
  String update;
  //Search
  String searchFail;
  String searchResult;
  //About
  String version;
  String dev;
  String devName;
  String copyRight;
  String aboutDev;
  //Contact us
  String telegram;
  //Update Profile
  String updateProfile;
  String askLogout;
  String logOutEffect;
  String leaveItBlank;
  String changeUserName;
  String changeEmail;
  String changePassword;
  String usernameSuc;
  String usernameErr;
  String emailSuc;
  String emailErr;
  String passwordSuc;
  String newPassword;
  String confirmPassword;
  String passwordErr;
  //Services
  String onlineReg;
  String studentInfo;
  String web;
  String eLearning;
  String library;

  //ForgotPass
  String resetPass;
  String restText;
  String forgotPass;

  LangModel({
    this.about,
    this.addImage,
    this.addChangeImage,
    this.all,
    this.body,
    this.bodyError,
    this.breakingNews,
    this.changeCampuse,
    this.changeLang,
    this.changeRole,
    this.changeTheme,
    this.contactUs,
    this.createPost,
    this.delete,
    this.downloadFile,
    this.downloading,
    this.drawerHeader,
    this.edit,
    this.email,
    this.fasile,
    this.gc,
    this.home,
    this.logOut,
    this.login,
    this.loginError,
    this.maraki,
    this.openFile,
    this.password,
    this.post,
    this.postData,
    this.postError,
    this.postSuccess,
    this.profile,
    this.recent,
    this.schedule,
    this.searchPlace,
    this.setting,
    this.staff,
    this.student,
    this.teacher,
    this.teda,
    this.tewodros,
    this.title,
    this.titleError,
    this.uploadEror,
    this.emailError,
    this.passwordError,
    this.invalidFile,
    this.invalidImage,
    this.news,
    this.addFile,
    this.searchFail,
    this.lightMode,
    this.darkMode,
    this.amharic,
    this.english,
    this.deleteTitle,
    this.deleteWarning,
    this.deleteSuccess,
    this.deleteFail,
    this.cancel,
    this.version,
    this.aboutDev,
    this.copyRight,
    this.devName,
    this.dev,
    this.telegram,
    this.editSuccess,
    this.update,
    this.searchResult,
    this.services,
    this.yourPosts,
    this.personalize,
    this.status,
    this.authUser,
    this.askLogout,
    this.changeEmail,
    this.changePassword,
    this.changeUserName,
    this.confirmPassword,
    this.emailErr,
    this.emailSuc,
    this.leaveItBlank,
    this.logOutEffect,
    this.newPassword,
    this.passwordErr,
    this.passwordSuc,
    this.updateProfile,
    this.usernameErr,
    this.usernameSuc,
    this.eLearning,
    this.library,
    this.onlineReg,
    this.studentInfo,
    this.web,
    this.forgotPass,
    this.resetPass,
    this.restText,
  });
}

class LangProvider extends ChangeNotifier {
  LangModel _lang;
  SharedPreferences pref = UsePreferences.pref;

  LangModel english = LangModel(
    //Drawer
    drawerHeader: "Fast, Modern and Easy",
    setting: "Settings",
    about: "About",
    contactUs: "Contact us",
    services: "Services",
    //settings
    changeCampuse: "Campuse",
    changeLang: "Language",
    changeTheme: "Dark Mode",
    changeRole: "Role",
    lightMode: "Light Mode",
    darkMode: "Dark Mode",
    amharic: "Amharic",
    english: "English",
    yourPosts: "Your Posts",
    personalize: "Personalize",
    status: "Status",
    //AppBar
    searchPlace: "Search....",

    //bottomNav
    home: "Home",
    post: "Post",
    schedule: "Schedule",
    profile: "Profile",
    news: "News",
    //Home
    breakingNews: "Breaking News",
    recent: "Recent",
    //Schedule
    openFile: "Open File",
    downloadFile: "Download File",
    downloading: "Downloading...",
    //Profile
    edit: "Edit",
    logOut: "Log out",
    delete: "Delete",
    cancel: "Cancel",
    email: "Email",
    password: "Password",
    login: "Log in",
    emailError: "Invalid, Please enter correct email address",
    passwordError: "Password must be greater than or equal to 6",
    loginError: "Somthing went wrong, please try again",
    deleteWarning: "Once the post deleted, it is gone permanently",
    deleteTitle: "Are you sure?",
    deleteSuccess: "Deleted Successfully!",
    deleteFail:
        "Unable to delete the content, please check your connection and try again",
    authUser:
        "You can log in and create content if your are an authorized user.",
    //Createpost
    createPost: "Create new post",
    title: "Title",
    body: "Body",
    addImage: "Add image",
    addFile: "Add file",
    addChangeImage: "Change or add image",
    postData: "POST",
    bodyError: "The body should not be empty!",
    titleError: "The title should not be empty!",
    postSuccess: "Posted successfuly!",
    postError: "Unable to post the data, please try again",
    uploadEror: "Unable to upload the file please try again",
    invalidImage: "Invalid file type, please choose only images",
    invalidFile: "Invalid file type, please choose only images or documents",
    all: "All",
    student: "Student",
    teacher: "Teacher",
    staff: "Staff",
    tewodros: "Atse Tewodros",
    fasile: "Atse Fasil",
    maraki: "Maraki",
    gc: "CMHS",
    teda: "Tseda",
    //Edit
    editSuccess: "Edited Successfully!",
    update: "Update",
    //Search
    searchFail: "Sorry, no result found for your search term.",
    searchResult: "Search result for ",
    //About
    version: "Version U1.0.0",
    copyRight: "Copyright 2022 UoG-Daily, Powered by University of Gondar.",
    aboutDev:
        "Hi, my name is Michael, i develop android and web apps, also interested in Machine learning and AI. You can contact me for any business related purposes.",
    devName: "Mikael Alehegn",
    dev: "Developer",
    //ContactUs
    telegram: "Telegram",
    //UpdateProfile
    updateProfile: "Update Profile",
    askLogout: "Do you want to log out?",
    logOutEffect: "You need to log out and log in again to see the change.",
    leaveItBlank:
        "Please leave it blank if you don't want to change any of the fields",
    changeUserName: "Change Username",
    usernameSuc: "Username Successfully Updated!",
    usernameErr: "Username should contain at least 4 character",
    changeEmail: "Change Email",
    emailSuc: "Email Successfully Updated!",
    changePassword: "Change Password",
    newPassword: "New Password",
    confirmPassword: "Confirm password",
    passwordSuc: "Password Successfully Updated!",
    passwordErr: "Passwords do not match, please try again",
    //Services
    onlineReg: "Online Registration",
    studentInfo: "Student Information System",
    library: "UoG Digital Library",
    eLearning: "UoG E-Learning",
    web: "Official University of Gondar Website",
    //forgotPassword
    forgotPass: "Forgot Password?",
    resetPass: "Reset Password",
    restText:
        "Please check your email, You will receive a password reset email",
  );

  LangModel amharic = LangModel(
    //Drawer
    drawerHeader: "ፈጣን ፣ ዘመናዊ እና ቀላል",
    setting: "ቅንብሮች",
    about: "ስለ",
    contactUs: "አግኙን",
    services: "አገልግሎቶች",

    //Settings
    changeCampuse: "ግቢ",
    changeLang: "ቋንቋ",
    changeTheme: "የምሽት ገጽታ",
    changeRole: "ሚና",
    lightMode: "ብርሃን ገጽታ",
    darkMode: "የምሽት ገጽታ",
    amharic: "አማርኛ",
    english: "እንግሊዝኛ",
    yourPosts: "የእርስዎ ልጥፎች",
    personalize: "ግላዊ ማስተካከያዎች",
    //AppBar
    searchPlace: "ፈልግ....",

    //bottomNav
    home: "ዜና",
    post: "ማስታወቂያ",
    schedule: "መርሐግብር",
    profile: "መገለጫ",
    news: "ዜና",
    //Home
    breakingNews: "ሰበር ዜና",
    recent: "የቅርብ",
    //Schedule
    openFile: "ክፍት ፋይል",
    downloadFile: "ሰነድ አውርድ",
    downloading: "በማውረድ ላይ...",
    //Profile
    edit: "አርም",
    logOut: "ውጣ",
    delete: "አጥፋ",
    cancel: "ሰረዝ",
    email: "ኢሜይል",
    password: "የይለፍ ቃል",
    login: "ግባ",
    emailError: "ልክ ያልሆነ ኢሜይል፣ እባክዎ ትክክለኛውን የኢሜይል አድራሻ ያስገቡ",
    passwordError: "የይለፍ ቃል ከ 6 በላይ ወይም እኩል መሆን አለበት",
    loginError: "የሆነ ችግር ተፈጥሯል፣ እባክዎ እንደገና ይሞክሩ",
    deleteTitle: "እርግጠኛ ነህ?",
    deleteWarning: "አንዴ ልጥፉ ከተሰረዘ እስከመጨረሻው ጠፍቷል",
    deleteSuccess: "በተሳካ ሁኔታ ተሰርዟል!",
    deleteFail: "ይዘቱን መሰረዝ አልተቻለም፣ እባክዎ ግንኙነትዎን ያረጋግጡ እና እንደገና ይሞክሩ",
    authUser: "የተፈቀደለት ተጠቃሚ ከሆንክ ገብተህ ይዘት መፍጠር ትችላለህ።",

    //Createpost
    createPost: "አዲስ ማስታወቂያ ይፍጠሩ",
    title: "ርዕስ",
    body: "የአንቀጽ አካል",
    addImage: "ምስል ያክሉ",
    addFile: "ፋይል ያክሉ",
    addChangeImage: "ምስል ይቀይሩ ወይም ያክሉ",
    postData: "ለጥፍ",
    bodyError: "የአንቀጽ አካል ባዶ መሆን የለበትም!",
    titleError: "ርዕሱ ባዶ መሆን የለበትም!",
    postSuccess: "በተሳካ ሁኔታ ተለጠፍ!",
    postError: "ውሂቡን መለጠፍ አልተቻለም፣ እባክዎ እንደገና ይሞክሩ",
    uploadEror: "ፋይሉን መስቀል አልተቻለም፣ እባክዎ እንደገና ይሞክሩ",
    invalidImage: "ልክ ያልሆነ የፋይል አይነት፣ እባክዎ ምስሎችን ብቻ ይምረጡ",
    invalidFile: "ልክ ያልሆነ የፋይል አይነት፣ እባክዎ ምስሎችን ወይም ሰነዶችን ብቻ ይምረጡ",
    all: "ሁሉም",
    student: "ተማሪ",
    teacher: "መምህር",
    staff: "ሰራተኞች",
    tewodros: "አጼ ቴዎድሮስ",
    fasile: "አጼ ፋሲል",
    maraki: "ማራኪ",
    gc: "ጤና",
    teda: "ፀዳ",
    //Edit
    editSuccess: "በተሳካ ሁኔታ ተስተካክሏል!",
    update: "ለውጥ",

    //search
    searchFail: "ይቅርታ፣ ለፍለጋ ቃልህ ምንም ውጤት አልተገኘም።",
    searchResult: "የፍለጋዎ ውጤት ለ ",
    //about
    version: "ስሪት U1.0.0",
    copyRight: "የቅጂ መብት 2022 UoG-Daily፣ በጎንደር ዩኒቨርሲቲ የተጎላበተ።",
    aboutDev:
        "ሰላም፣ ስሜ ሚካኤል ነው፣ አንድሮይድ እና የድር መተግበሪያዎችን አዘጋጃለሁ፣ እንዲሁም ML እና AI ላይ ፍላጎት አለኝ። ለማንኛውም ከንግድ ስራ ጋር ለተያያዙ አላማዎች ልታገኙኝ ትችላላችሁ።",
    devName: "ሚካኤል አለኸኝ",
    dev: "ገንቢ",
    //Telegram
    telegram: "ቴሌግራም",
    //Update Profile
    updateProfile: "መገለጫ አዘምን",
    askLogout: "ዘግተህ መውጣት ትፈልጋለህ?",
    logOutEffect: "ለውጡን ለማየት ዘግተው መውጣት እና እንደገና መግባት አለብዎት።",
    leaveItBlank: "ማናቸውንም መስኮች መቀየር ካልፈለጉ እባክዎ ባዶውን ይተዉት።",
    changeUserName: "የተጠቃሚ ስም ቀይር",
    usernameSuc: "የተጠቃሚ ስም በተሳካ ሁኔታ ዘምኗል!",
    usernameErr: "የተጠቃሚ ስም ቢያንስ 4 ሆሄዎችን መያዝ አለበት።",
    changeEmail: "ኢሜል ቀይር",
    emailSuc: "ኢሜል በተሳካ ሁኔታ ዘምኗል!",
    changePassword: "የሚስጥር ቁልፍ ይቀይሩ",
    newPassword: "አዲስ የይለፍ ቃል",
    confirmPassword: "የይለፍ ቃል አረጋግጥ",
    passwordSuc: "የይለፍ ቃል በተሳካ ሁኔታ ዘምኗል!",
    passwordErr: "የይለፍ ቃሎች አይዛመዱም፣ እባክዎ እንደገና ይሞክሩ",
    //Services
    onlineReg: "የመስመር ላይ ምዝገባ",
    studentInfo: "የተማሪ መረጃ ስርዓት",
    library: "UoG ዲጂታል ላይብረሪ",
    eLearning: "UoG ኢ-ትምህርት",
    web: "የጎንደር ዩኒቨርሲቲ ኦፊሴላዊ ድረ-ገጽ",
    //forgotPass
    forgotPass: "መክፈቻ ቁልፉን ረሳኽው?",
    resetPass: "የይለፍ ቃል ዳግም አስጀምር",
    restText: "እባክዎ ኢሜልዎን ያረጋግጡ፣ የይለፍ ቃል ዳግም ማስጀመሪያ ኢሜይል ይደርስዎታል",

  );
  LangProvider() {
    bool isEnglish = pref.getBool("isEnglish") ?? true;
    if (isEnglish == true) {
      _lang = english;
    } else {
      _lang = amharic;
    }
  }
  changeLang(bool val) {
    if (val == true) {
      _lang = english;
      pref.setBool("isEnglish", true);
    } else {
      _lang = amharic;
      pref.setBool("isEnglish", false);
    }
    notifyListeners();
  }

  LangModel get lang => _lang;
}
