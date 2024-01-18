import 'package:flutter/material.dart';
import 'UserStoryDetailScreen.dart';
import 'data.dart';

class UserStoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Stories'),
      ),
      body: ListView.builder(
        itemCount: UserData.userStories.length,
        itemBuilder: (context, index) {
          var userStory = UserData.userStories[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserStoryDetailScreen(userStory: userStory),
                ),
              );
            },
            child: Card(
              margin: EdgeInsets.all(8),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${userStory.adventureStyle} ${userStory.name} 님이 당신을 선택하였습니다'),
                    SizedBox(height: 8),
                    Text('스토리: ${userStory.storyPart}'),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
