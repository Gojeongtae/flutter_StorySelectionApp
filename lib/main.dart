import 'dart:async';
import 'package:flutter/material.dart';
import 'data.dart';
import 'userStoryScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
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
        title: Text('스토리'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(icon: Icon(Icons.home), text: '선택지'),
            Tab(icon: Icon(Icons.book), text: '메세지'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          MyHomePage(),
          UserStoryScreen(),
        ],
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with AutomaticKeepAliveClientMixin {
  late List<DataItem> dataItems;
  int currentIndex = 0;
  bool showInit = true; //true 일 때, 시작하기 버튼이 보임
  bool showText = false;
  bool showButton = false;
  bool showImage = false; //true일 때, 이미지가 1.0으로 보임
  bool showChoices = false;
  String selectedPerson = '';

  @override
  bool get wantKeepAlive => true;

  void initState() {
    super.initState();
    dataItems = Data.dataItems;

  }

  void _initNextState() {
    // 3초 뒤에 이미지가 반투명해지고 글이 나타남
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        showImage = false;
        showText = true;
      });
      _showButton();
    });
  }

  void _showButton() {
    // 3초 뒤에 버튼이 나타남
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        showButton = true;
      });
    });
  }

  void _showChoices() {
    // 선택지를 보여주도록 설정
    setState(() {
      showButton = false;
      showChoices = true;
    });
  }

  void _selectChoice(String choice) {
    // 선택한 정보를 반영하여 2번째 데이터의 텍스트를 출력
    setState(() {
      selectedPerson = choice;
      _showNewStory();
      _updateUserStory(); // 새로운 정보를 등록
    });
  }

  void _showNewStory() {
    // 선택된 정보를 반영하여 2번째 데이터의 텍스트를 출력
    setState(() {
      currentIndex = 1; // 2번째 데이터로 이동
      showImage = false;
      showText = false;
      showButton = false;
      showChoices = false; // 선택지를 다시 숨김
      _showNextState();
    });
  }

  void _showNextState() {
    // 0초 뒤에 이미지가 반투명해지고 글이 나타남
    Future.delayed(Duration(seconds: 0), () {
      setState(() {
        showImage = false;
        showText = true;
      });
      _showButton();
    });
  }

  void _updateUserStory() {
    // 새로운 정보를 UserData에 추가
    if (UserData.DatauserStories.isNotEmpty) {
      UserData.userStories.add(UserStory(
        name: UserData.DatauserStories[0].name,
        age: UserData.DatauserStories[0].age,
        gender: UserData.DatauserStories[0].gender,
        adventureStyle: UserData.DatauserStories[0].adventureStyle,
        selectedBy: UserData.DatauserStories[1].name, // 선택한 사람
        storyPart: Data.dataItems[0].shortText, // 스토리 일부
      ));
    }
  }

  void _showUserStories() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserStoryScreen(),
      ),
    );
  }

  // 새로운 버튼을 누를 때 이미지를 보이도록 하는 함수
  void _showImage() {
    setState(() {
      showImage = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('스토리'),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedOpacity(
              opacity: (showInit && !showImage) ? 0.0 : (!showInit && showImage ? 1.0 : 0.5),  //처음에 버튼 누르기 전에 init :t ,image:f이고 버튼만 보이고 이미지는 0.0, 버튼 누르면 init : f, image : t이고 이미지만 1.0으로 보임 , 3초 뒤에 init:f, image :f이고 이미지 반투명이랑 버튼 안보임.
              duration: Duration(seconds: 1),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(dataItems[currentIndex].imageAssetPath),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            AnimatedOpacity(
              opacity: (showText || showChoices) ? 1.0 : 0.0,
              duration: Duration(seconds: 0),
              child: Positioned(
                top: 16,
                left: 16,
                right: 16,
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: showChoices
                      ? _buildChoicesWidget()
                      : Text(
                    currentIndex == 1
                        ? dataItems[currentIndex].text.replaceAll('{personName}', selectedPerson)
                        : dataItems[currentIndex].text,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            if (showButton)
              Positioned( //다음으로 버튼
                bottom: 16,
                right: 16,
                child: ElevatedButton(
                  onPressed: () {
                    _showChoices();
                  },
                  child: Text('다음으로'),
                ),
              ),
            if(showInit)
            Positioned( //처음 시작할 때 버튼
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    showImage = true;
                    showInit = false;
                  });
                  _initNextState();
                },
                child: Text('새로운 스토리 시작하기'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChoicesWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: Data.nameItems.map((nameItem) {
        return ElevatedButton(
          onPressed: () {
            _selectChoice(nameItem.text);
          },
          child: Text(nameItem.text),
        );
      }).toList(),
    );
  }
}
