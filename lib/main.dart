import 'dart:io';

import 'package:customer_management_system/login/login.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(const MyHomePage());
  configLoading();
  HttpOverrides.global = MyHttpOverrides();

}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();

  static _MyHomePageState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyHomePageState>();
}

class _MyHomePageState extends State<MyHomePage> {
  ThemeMode? _themeMode;

  @override
  void initState() {
    getTheme();
    super.initState();
    DesktopWindow.setMinWindowSize(Size(1000, 600));
  }

  void getTheme() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool? flag = preferences.getBool('theme');
    setState(() {
      _themeMode = flag == true ? ThemeMode.dark : ThemeMode.light;
    });
  }

  void changeTheme(ThemeMode themeMode,bool flag) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('theme', flag);
    setState(() {
      _themeMode = themeMode;
    });
  }


  @override
  Widget build(BuildContext context) {
    return FluentApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
          scaffoldBackgroundColor: Colors.grey[210],
          brightness: Brightness.dark,
          accentColor: Colors.orange),
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.grey[20],
          brightness: Brightness.light,
          accentColor: Colors.orange),
      themeMode: _themeMode,
      home: Login(),
      builder: EasyLoading.init(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}