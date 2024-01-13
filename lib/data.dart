// data.dart

class Data {
  static List<DataItem> dataItems = [
    DataItem(
      imageAssetPath: 'images/1.png',
      text: '맛있는 햄버거를 즐기며 가게를 나선 주인공은 길가에 떠도는 따스한 도시의 불빛을 따라 걷기 시작했다. 그런데 갑자기 어릴 적의 추억이 마음을 울렸다. 옛 친구 중 한 명이 나타날 것 같은 예감이 들었다.햄버거의 향기는 주인공을 어린 시절의 소중한 기억으로 이끌어가고 있었다. 작은 골목길을 따라 걸으며, 그가 그립던 동네 친구 중 한 명이 코너를 돌아 나타났다. "안녕하세요!" 라는 친숙한 목소리가 주인공의 귀에 울려 퍼졌다.',
    ),
    DataItem(
      imageAssetPath: 'images/image2.jpg',
      text: '두 번째 긴 글',
    ),
    // 추가적인 데이터 아이템들...
  ];
}

class DataItem {
  final String imageAssetPath;
  final String text;

  DataItem({required this.imageAssetPath, required this.text});
}
