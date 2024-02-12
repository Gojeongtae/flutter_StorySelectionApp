import 'dart:js_util';

import 'package:example_7/firestore.dart';
import 'package:flutter/material.dart';
import '../data.dart'; // Import other dependencies as needed
import 'package:firebase_analytics/firebase_analytics.dart';
import 'dart:async';
import 'package:example_7/service.dart';
import 'userStoryScreen.dart';
import 'package:example_7/firestore.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with AutomaticKeepAliveClientMixin {
  late List<DataItem> dataItems;
  int currentIndex = 0;
  bool showInit = true;
  bool showText = false;
  bool showButton = false;
  bool showImage = false;
  bool showChoices = false;
  String selectedPerson = '';

  AddUser addUser = AddUser('고정태', '닌텐도', 23);

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
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedOpacity(
              opacity: (showInit && !showImage)
                  ? 0.0
                  : (!showInit && showImage ? 1.0 : 0.5),
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
            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: AnimatedOpacity(
                opacity: (showText || showChoices) ? 1.0 : 0.0,
                duration: Duration(seconds: 0),

                // Your FadeTransition logic here
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: showChoices
                      ? _buildChoicesWidget()
                      : Text(
                    currentIndex == 1
                        ? dataItems[currentIndex]
                        .text
                        .replaceAll('{personName}', selectedPerson)
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
                    FirebaseAnalytics.instance.logEvent(
                      name: '다음으로가 눌렸습니다',
                    );
                  },
                  child: Text('다음으로'),
                ),
              ),
            if (showInit)
              Positioned(
                child: ElevatedButton(
                  onPressed: () async {

                    addUser.addUser();

                    //final service = AuthService();
                    //await service.signIn();

                    setState(() {
                      showImage = true;
                      showInit = false;
                    });
                    _initNextState();
                  },
                  child: Text('새로운 스토리 시작하기'),
                ),
              ),
            Positioned(child: ElevatedButton(
              onPressed: () async{
                final service = AuthService();
                await service.signIn();
              },
                // ,
                child: Text('로그인'),
            ))
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
