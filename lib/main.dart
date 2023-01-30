import 'package:flutter/material.dart';
import 'package:otp/UI/Pages/first_page.dart';
import 'package:otp/UI/Pages/second_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OTP Task',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget  {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  
  late TabController tabController;
  
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    final _pcolor = Theme.of(context).primaryColor;

    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: TabBar(
            controller: tabController,
            tabs: <Widget> [
              Tab(
                icon: Icon(Icons.input, color: _pcolor),
              ),
              Tab(
                icon: Icon(Icons.credit_score, color: _pcolor),
              )
            ]
        ),
      ),
      body: SafeArea(
        child: TabBarView(
          controller: tabController,
          children: <Widget> [
            FirstPage(),
            SecondPage()
          ]
        ),
      )
    );
  }
}
