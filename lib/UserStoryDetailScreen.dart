import 'data.dart';
import 'package:flutter/material.dart';

class UserStoryDetailScreen extends StatelessWidget {
  final UserStory userStory;

  UserStoryDetailScreen({required this.userStory});

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
              'images/blurred_image.jpg', // 블러 처리된 이미지 경로
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            Text('스토리 내용: ${userStory.storyPart}'),
            SizedBox(height: 16),
            Text('선택: ${userStory.selectedBy}'),
          ],
        ),
      ),
    );
  }
}
