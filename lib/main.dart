import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp/Bloc/feedback_cubit.dart';
import 'package:otp/Bloc/store_bloc.dart';
import 'package:otp/UI/Pages/first_page.dart';
import 'package:otp/UI/Pages/second_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final FeedBackCubit storeBloc = FeedBackCubit();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<StoreBloc>(
          create: (context) => StoreBloc(storeBloc),
        ),
        BlocProvider<FeedBackCubit>(
          create: (context) => storeBloc,
        ),
      ],
      child: MaterialApp(
          title: 'OTP Task',
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          home: const MyHomePage(),
        ),
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
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      context.read<FeedBackCubit>().clearWords();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;

    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: TabBar(
            controller: tabController,
            tabs: <Widget> [
              Tab(
                icon: Icon(Icons.input, color: color),
              ),
              Tab(
                icon: Icon(Icons.credit_score, color: color),
              )
            ]
        ),
      ),
      body: SafeArea(
        child: TabBarView(
          controller: tabController,
          children: const <Widget> [
            FirstPage(),
            SecondPage()
          ]
        ),
      )
    );
  }
}
