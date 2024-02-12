import 'package:flutter/material.dart';
import 'userStoryScreen.dart';
import 'MyHomePage.dart';

import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions
        .currentPlatform, //DefaultFirebaseOptions 객체를 사용하여 Firebase를 초기화fl
  );


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.blue, // This replaces accentColor
        ),
        textTheme: TextTheme(
          headline1: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent),
          bodyText1: TextStyle(fontSize: 14.0, color: Colors.black87),
          // Define other text styles as needed
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore', style: Theme.of(context).textTheme.headline1),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          MyHomePage(),
          UserStoryScreen(),
        ],
      ),
      bottomNavigationBar: TabBar(
        controller: _tabController,
        tabs: [
          Tab(icon: Icon(Icons.home), text: '스토리 선택지'),
          Tab(icon: Icon(Icons.book), text: '받은 메세지'),
        ],
      ),
    );
  }
}
