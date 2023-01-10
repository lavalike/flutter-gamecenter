/// Constant global data.
class GlobalData {
  /// Screen width.
  static const double screenWidth = 1920;
  /// Screen height.
  static const double screenHeight = 1080;

  /// Height of title area.
  static const double titleAreaHeight = 200;

  /// Scroll height.
  static const double scrollHeight = 3500;

  /// Delta for scrolling.
  static const double scrollDelta = 40;

  /// Prefix string for url.
  static const String urlHead = "http://192.168.88.11:80/images/";
}

/// Constant data for models in header area.
class TitleData {
  static const double top = 50;
  static const double left = 140;

  // Constant data for titles.
  static const double widthOfTitle = 250;
  static const double heightOfTitle = 93;
  static const double spaceBetweenTitleColumns = 50;
  static const List<int> titleIds = [0, 1, 2];
  static const List<List<int>> titleNeighbourIds = [
    [-1, 6, -1, 1],
    [-1, 6, 0, 2],
    [-1, 6, 1, 3],
  ];
  static const List<String> titles = [
    "Home",
    "TV",
    "App",
  ];
  static const double fontSizeOfTitle = 50;

  // Constant data for icons.
  static const double widthOfIcon = 158;
  static const double heightOfIcon = 93;
  static const double spaceBetweenIconColumns = 13;
  static const double spaceBetweenTitlesAndIcons = 290;
  static const List<int> iconIds = [3, 4, 5];
  static const List<List<int>> iconNeighbourIds = [
    [-1, 6, 2, 4],
    [-1, 6, 3, 5],
    [-1, 6, 4, -1],
  ];
  static const List<String> iconUrls = [
    "icon-usb.webp",
    "icon-source.webp",
    "icon-wifi.webp",
  ];
}

/// Constant data for models in home tab.
class HomeData {
  static const double left = 140;

  // Constant data for apps.
  static const double widthOfApp = 312;
  static const double heightOfApp = 175;
  static const double spaceBetweenAppColumns = 20;
  static const double spaceBetweenAppRows = 25;
  static const int appsInRow = 5;
  static const List<int> appIds = [6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
  static const List<List<int>> appNeighbourIds = [
    [0, 11, -1, 7],
    [0, 12, 6, 8],
    [0, 13, 7, 9],
    [0, 14, 8, 10],
    [0, 15, 9, 1],
    [6, 16, -1, 12],
    [7, 17, 11, 13],
    [8, 18, 12, 14],
    [9, 19, 13, 15],
    [10, 19, 14, 1],
  ];
  static const List<String> appUrls = [
    "home-bbc-iplay.webp",
    "home-itv.webp",
    "home-all4.webp",
    "home-demand5.webp",
    "home-freeview-play.webp",
    "home-netflix.webp",
    "home-search.webp",
    "home-alexa.webp",
    "home-youtube.webp",
    "home-rakuten-tv.webp",
  ];

  // Constant data for movies.
  static const double widthOfMovie = 398;
  static const double heightOfMovie = 557;
  static const double spaceBetweenMovieColumns = 16;
  static const double spaceBetweenMovieRows = 23;
  static const int moviesInRow = 4;
  static const List<int> movieIds = [
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    30,
    31,
    32,
    33,
    34,
    35,
  ];
  static const List<List<int>> movieNeighbourIds = [
    [11, 20, -1, 17],
    [12, 21, 16, 18],
    [13, 22, 17, 19],
    [14, 23, 18, 1],
    [16, 24, -1, 21],
    [17, 25, 20, 22],
    [18, 26, 21, 23],
    [19, 27, 22, 1],
    [20, 28, -1, 25],
    [21, 29, 24, 26],
    [22, 30, 25, 27],
    [23, 31, 26, 1],
    [24, 32, -1, 29],
    [25, 33, 28, 30],
    [26, 34, 29, 31],
    [27, 35, 30, 1],
    [28, -1, -1, 33],
    [29, -1, 32, 34],
    [30, -1, 33, 35],
    [31, -1, 34, 1],
  ];
  static const List<String> movieUrls = [
    "movie1.webp",
    "movie2.webp",
    "movie3.webp",
    "movie4.webp",
    "movie5.webp",
    "movie6.webp",
    "movie7.webp",
    "movie8.webp",
    "movie9.webp",
    "movie10.webp",
    "movie11.webp",
    "movie12.webp",
    "movie13.webp",
    "movie14.webp",
    "movie15.webp",
    "movie16.webp",
    "movie17.webp",
    "movie18.webp",
    "movie19.webp",
    "movie20.webp",
  ];
}

/// Constant data for models in tv tab.
class TvData {
  // Constant data for window.
  static const double leftOfWindow = 400;
  static const double widthOfWindow = 1120;
  static const double heightOfWindow = 630;
  static const double spaceBetweenWindowAndSources = 50;
  static const int windowId = 6;
  static const List<int> windowNeighbourIds = [1, 7, 0, 2];

  // Constant data for sources.
  static const double leftOfSource = 165;
  static const double widthOfSource = 158;
  static const double heightOfSource = 93;
  static const double spaceBetweenSourceColumns = 200;
  static const List<int> sourceIds = [7, 8, 9, 10, 11];
  static const List<List<int>> sourceNeighbourIds = [
    [6, -1, 0, 8],
    [6, -1, 7, 9],
    [6, -1, 8, 10],
    [6, -1, 9, 11],
    [6, -1, 10, 2],
  ];
  static const List<String> sourceUrls = [
    "tv-atv.webp",
    "tv-av.webp",
    "tv-hdmi.webp",
    "tv-hdmi.webp",
    "tv-hdmi.webp",
  ];
}

/// Constant data for models in app tab.
class AppData {
  static const double left = 140;

  // Constant data for apps.
  static const double widthOfApp = 540;
  static const double heightOfApp = 304;
  static const double spaceBetweenAppColumns = 10;
  static const double spaceBetweenAppRows = 46;
  static const List<int> appIds = [6, 7, 8];
  static const List<List<int>> appNeighbourIds = [
    [2, 9, 1, 7],
    [2, 9, 6, 8],
    [2, 9, 7, -1],
  ];
  static const List<String> appUrls = [
    "app-store.webp",
    "app-tbrowser.webp",
    "app-tcast.webp",
  ];

  // Constant data for flow.
  static const double widthOfFlow = 1640;
  static const double heightOfFlow = 1080;
  static const int flowId = 9;
  static const List<int> flowNeighbourIds = [6, -1, 1, -1];
}
