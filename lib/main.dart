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

  @override
  void initState() {
    super.initState();
    dataItems = Data.dataItems;
    _showNextState();
  }

  void _showNextState() {
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

  void _nextItem() {
    // 다음 데이터로 이동하고 상태 초기화
    setState(() {
      currentIndex = (currentIndex + 1) % dataItems.length;
      showImage = true;
      showText = false;
      showButton = false;
      _showNextState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Image and Text Carousel'),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // 배경 이미지
            AnimatedOpacity(
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
            // 글
            AnimatedOpacity(
              opacity: showText ? 1.0 : 0.0,
              duration: Duration(seconds: 1),
              child: Positioned(
                top: 16,
                left: 16,
                right: 16,
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    dataItems[currentIndex].text,
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
                  onPressed: () {
                    _nextItem();
                  },
                  child: Text('다음으로'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
