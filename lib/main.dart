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
  bool showInit = true;
  bool showText = false;
  bool showButton = false;
  bool showImage = false;
  bool showChoices = false;
  String selectedPerson = '';

  @override
  bool get wantKeepAlive => true;

  void initState() {
    super.initState();
    dataItems = Data.dataItems;
  }

  void _initNextState() {
    _delayedExecution(() {
      setState(() {
        showImage = false;
        showText = true;
      });
      _showButton();
    }, 3);
  }

  void _showButton() {
    _delayedExecution(() {
      setState(() {
        showButton = true;
      });
    }, 3);
  }

  void _showChoices() {
    setState(() {
      showButton = false;
      showChoices = true;
    });
  }

  void _selectChoice(String choice) {
    setState(() {
      selectedPerson = choice;
      _showNewStory();
      _updateUserStory();
    });
  }

  void _showNewStory() {
    setState(() {
      currentIndex = 1;
      showImage = false;
      showText = false;
      showButton = false;
      showChoices = false;
      _showNextState();
    });
  }

  void _showNextState() {
    _delayedExecution(() {
      setState(() {
        showImage = false;
        showText = true;
      });
      _showButton();
    }, 0);
  }

  void _updateUserStory() {
    if (UserData.DatauserStories.isNotEmpty) {
      UserData.userStories.add(UserStory(
        name: UserData.DatauserStories[0].name,
        age: UserData.DatauserStories[0].age,
        gender: UserData.DatauserStories[0].gender,
        adventureStyle: UserData.DatauserStories[0].adventureStyle,
        selectedBy: UserData.DatauserStories[1].name,
        storyPart: Data.dataItems[0].shortText,
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
              opacity: (showInit && !showImage) ? 0.0 : (!showInit && showImage ? 1.0 : 0.5),
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
              Positioned(
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
              Positioned(
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

  Future<void> _delayedExecution(Function action, int seconds) async {
    await Future.delayed(Duration(seconds: seconds));
    action();
  }

}
