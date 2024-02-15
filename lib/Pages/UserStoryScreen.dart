import 'package:flutter/material.dart';
import 'UserStoryDetailScreen.dart';
import '../data.dart';

class UserStoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('용사님께 전달된 메세지'),
      ),
      body: ListView.builder(
        itemCount: UserData.userStories.length,
        itemBuilder: (context, index) {
          var userStory = UserData.userStories[index];
          var data = Data.dataItems[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserStoryDetailScreen(userStory: userStory, dataItem: data),
                ),
              );
            },
            child: Card(
              margin: EdgeInsets.all(8),//카드 밖에
              child: Padding(
                padding: EdgeInsets.all(16),//카드 안에 (글자와의 간격)
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
