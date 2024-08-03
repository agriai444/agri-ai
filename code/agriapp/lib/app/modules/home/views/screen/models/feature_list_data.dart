class FeatureListData {
  FeatureListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.startColor = '',
    this.endColor = '',
    this.description,
  });

  String imagePath;
  String titleTxt;
  String startColor;
  String endColor;
  String? description;

  static List<FeatureListData> tabIconsList = <FeatureListData>[
    FeatureListData(
      imagePath: 'assets/fitness_app/chat_ai.png',
      titleTxt: 'Chat AI Agricultural Expert',
      description: 'Get instant advice from our AI expert.',
      startColor: '#FA7D82',
      endColor: '#FFB295',
    ),
    FeatureListData(
      imagePath: 'assets/fitness_app/chat_human.png',
      titleTxt: 'Chat Human Agricultural Expert',
      description: 'Talk to a human expert for personalized advice.',
      startColor: '#738AE6',
      endColor: '#5C5EDD',
    ),
  ];
}