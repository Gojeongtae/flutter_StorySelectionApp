import 'dart:async';
import 'package:flutter/material.dart';
import 'data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<DataItem> dataItems;
  int currentIndex = 0;
  bool showText = false;
  bool showButton = false;
  bool showImage = true;
  bool showChoices = false;
  String selectedPerson = '';

  @override
  void initState() {
    super.initState();
    dataItems = Data.dataItems;
    _initNextState();
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


  void _showNextState() {
    // 3초 뒤에 이미지가 반투명해지고 글이 나타남
    Future.delayed(Duration(seconds: 0), () {
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

  void _nextItem() {
    // 다음 데이터로 이동하고 상태 초기화
    setState(() {
      currentIndex = (currentIndex + 1) % dataItems.length;
      showImage = true;
      showText = false;
      showButton = false;
      showChoices = false; // 선택지를 다시 숨김
      _showNextState();
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
            // 배경 이미지
            AnimatedOpacity(  //showImage가 true일 때, 이미지 보이도록
              opacity: showImage ? 1.0 : 0.5,
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
            // 글 또는 선택지 표시
            AnimatedOpacity( //showText가 true일 때, 글 보이도록
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
            // 버튼
            if (showButton)
              Positioned(
                bottom: 16,
                right: 16,
                child: ElevatedButton(
                  onPressed: () { _showChoices();
                  },
                  child: Text('다음으로'),
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
      children: [
        ElevatedButton(
          onPressed: () {
            _selectChoice('구현준');
          },
          child: Text('구현준'),
        ),
        ElevatedButton(
          onPressed: () {
            _selectChoice('김수찬');
          },
          child: Text('김수찬'),
        ),
        ElevatedButton(
          onPressed: () {
            _selectChoice('이승원');
          },
          child: Text('이승원'),
        ),
        ElevatedButton(
          onPressed: () {
            _selectChoice('오해람');
          },
          child: Text('오해람'),
        ),
      ],
    );
  }
}
