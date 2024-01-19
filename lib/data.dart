class UserStory {
  final String name;
  final int age;
  final String gender;
  final String adventureStyle;
  String selectedBy;
  String storyPart;

  UserStory({
    required this.name,
    required this.age,
    required this.gender,
    required this.adventureStyle,
    this.selectedBy = '',
    this.storyPart = '',
  });
}

class UserData {
  static List<UserStory> userStories = [];
  static List<UserStory> DatauserStories = [
    UserStory(name: "고정태", age: 22, gender: "남", adventureStyle: "정의로운"),
    UserStory(name: "박준서", age: 24, gender: "남", adventureStyle: "용감한")
  ];
}

class DataItem {
  final String imageAssetPath;
  final String text;
  final String shortText;

  DataItem({
    this.imageAssetPath = 'images/1.png',
    required this.text,
    this.shortText = '짧은 스토리',
  });
}

class Data {
  static List<DataItem> dataItems = [
    DataItem(
      imageAssetPath: 'images/1.png',
      text: '맛있는 햄버거를 즐기며 가게를 나선 주인공은 길가에 떠도는 따스한 도시의 불빛을 따라 걷기 시작했다. 그런데 갑자기 어릴 적의 추억이 마음을 울렸다. 옛 친구 중 한 명이 나타날 것 같은 예감이 들었다. 햄버거의 향기는 주인공을 어린 시절의 소중한 기억으로 이끌어가고 있었다. 작은 골목길을 따라 걸으며, 그가 그립던 동네 친구 중 한 명이 코너를 돌아 나타났다. "안녕하세요!" 라는 친숙한 목소리가 주인공의 귀에 울려 퍼졌다.',
      shortText: '맛있는 햄버거를 즐기며 가게를 나서며 따스한 도시의 불빛을 따라 걷는데..'
    ),
    DataItem(
      imageAssetPath: 'images/2.png',
      text: '그 목소리의 정체는. {personName}이였다. {personName}은 이 곳을 보며 달려온다.',
    ),
    // Add more DataItem objects as needed
  ];

  static List<DataItem> nameItems = [
    DataItem(text: '구현준'),
    DataItem(text: '김수찬'),
    DataItem(text: '이승원'),
    DataItem(text: '오해람'),
  ];
}
