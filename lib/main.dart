import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pracatical_demo/res/base_main_builder.dart';
import 'package:pracatical_demo/view%20model/getx_controllers/dependencies.dart';
import 'package:pracatical_demo/view/splash/splash_view.dart';


Future<void> instantiate() async{
  await init();
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  instantiate();

  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          // scaffoldBackgroundColor: bgColor,
          useMaterial3: true,
          // textTheme: GoogleFonts.openSansTextTheme(Theme.of(context).textTheme)
          //     .apply(
          //       bodyColor: Colors.white,
          //     )
          //     .copyWith(
          //         // bodyText1: const TextStyle(color: bodyTextColor),
          //         // bodyText2: const TextStyle(color: bodyTextColor),
          //         ),
        ),
        builder: (BuildContext context, Widget? child) {
          return BaseMainBuilder(context: context, child: child);
        },
        home: const SplashView());
  }
}