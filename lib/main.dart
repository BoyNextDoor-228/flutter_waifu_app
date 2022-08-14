import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:waifu_app/all_pics/all_pics_ui/all_waifus_screen.dart';
import 'package:waifu_app/one_pic/one_pic_ui/one_waifu_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Waifu App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
              toolbarHeight: 0,
              backgroundColor: Colors.transparent,
              elevation: 0,
              bottom: const TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                indicatorWeight: 4.0,
                indicatorColor: Colors.black,
                labelColor: Colors.black,
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                tabs: [
                  Tab(text: "All pics"),
                  Tab(text: "Single pic"),
                ],
              )
          ),
        body: StreamBuilder(
          stream: Connectivity().onConnectivityChanged,
          builder: (context, AsyncSnapshot<ConnectivityResult> snapshot) {
            return snapshot.data == ConnectivityResult.none
                ? const Center(
                    child: Text("No internet connection!")
            )
                :const Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: TabBarView(
                  children: [
                    AllPictures(),
                    OnePicture()
                  ]
            ),
                );
          },
        ),
      ),
    );
  }
}