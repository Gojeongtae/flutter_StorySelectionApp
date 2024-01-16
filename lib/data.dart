class DataItem { //DataItem이라는 함수를 만들고
  final String imageAssetPath; //매개변수를 만들었어
  final String text;

  DataItem({ //그리고 생성자 만듦.
    this.imageAssetPath = 'images/1.png', // 기본 이미지 경로 지정
    required this.text,
  });
}


class Data { //데이터 정리하는 함수를 새로 만들었어
  static List<DataItem> dataItems = [ //이  때는 리스트를 쓰고 싶은데 아까 만든 DataItem을 이용해서 함수를 만드려고 함.
    DataItem(
      imageAssetPath: 'images/1.png',
      text: '맛있는 햄버거를 즐기며 가게를 나선 주인공은 길가에 떠도는 따스한 도시의 불빛을 따라 걷기 시작했다. 그런데 갑자기 어릴 적의 추억이 마음을 울렸다. 옛 친구 중 한 명이 나타날 것 같은 예감이 들었다. 햄버거의 향기는 주인공을 어린 시절의 소중한 기억으로 이끌어가고 있었다. 작은 골목길을 따라 걸으며, 그가 그립던 동네 친구 중 한 명이 코너를 돌아 나타났다. "안녕하세요!" 라는 친숙한 목소리가 주인공의 귀에 울려 퍼졌다.',
    ),
    DataItem(
      imageAssetPath: 'images/2.png',
      text: '그 목소리의 정체는. {personName}이였다. {personName}은 이 곳을 보며 달려온다.',
    ),
    // Add more DataItem objects as needed
  ];

  static List<DataItem> nameItems = [ //여기서는 이름을 가져오고 싶은데 image는 선택 매개변수니까 text로만 가져와서 이름만 불러올 수 있게 했어.
    DataItem(text: '구현준'),
    DataItem(text: '김수찬'),
    DataItem(text: '이승원'),
    DataItem(text: '오해람'),
  ];
}
