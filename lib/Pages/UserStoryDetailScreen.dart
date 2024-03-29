import '../data.dart';
import 'package:flutter/material.dart';

class UserStoryDetailScreen extends StatelessWidget {
  final UserStory userStory;
  final DataItem dataItem;

  UserStoryDetailScreen({
    required this.userStory,
    required this.dataItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${userStory.adventureStyle} ${userStory.name} 님의 이야기'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'images/1.png', // 블러 처리된 이미지 경로
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            Text('스토리 내용: ${dataItem.text}'),
            SizedBox(height: 16),
            Text('${userStory.selectedBy}님께서 이 이야기에 참가하게 되었습니다'),
          ],
        ),
      ),
    );
  }
}
