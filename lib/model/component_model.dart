import '../data/constant.dart';
import '../model/widget_model.dart';

/// Component model contains several widget models.
class ComponentModelMixin {
  /// Component area.
  Area get area => _area;
  Area _area;

  /// Get widgets' models that is showed on screen.
  List<WidgetModel> getWidgetModels() {
    return null;
  }

  /// Get widgets' models that is showed on screen.
  WidgetModel getWidgetModelById(int id) {
    return null;
  }
}

/// This model is used for constructing header view.
class HeaderComponentModel with ComponentModelMixin {
  /// Header widgets' models.
  final List<WidgetModel> _headerWidgetModels = List();

  HeaderComponentModel() {
    // Header area.
    _area = Area(0, 0, GlobalData.screenWidth, GlobalData.titleAreaHeight);
    // Build header widgets' models.
    double curX = TitleData.left;
    double curY = TitleData.top;
    for (int i = 0; i < TitleData.titleIds.length; i++) {
      _headerWidgetModels.add(TitleWidgetModel(
        TitleData.titleIds[i],
        TitleData.titleNeighbourIds[i][0],
        TitleData.titleNeighbourIds[i][1],
        TitleData.titleNeighbourIds[i][2],
        TitleData.titleNeighbourIds[i][3],
        Area(curX, curY, TitleData.widthOfTitle, TitleData.heightOfTitle),
        TitleData.titles[i],
        TitleData.fontSizeOfTitle,
      ));
      curX += TitleData.widthOfTitle + TitleData.spaceBetweenTitleColumns;
    }

    // Build icon widgets' models.
    curX += TitleData.spaceBetweenTitlesAndIcons -
        TitleData.spaceBetweenTitleColumns;
    for (int i = 0; i < TitleData.iconIds.length; i++) {
      _headerWidgetModels.add(PosterWidgetModel(
        TitleData.iconIds[i],
        TitleData.iconNeighbourIds[i][0],
        TitleData.iconNeighbourIds[i][1],
        TitleData.iconNeighbourIds[i][2],
        TitleData.iconNeighbourIds[i][3],
        Area(curX, curY, TitleData.widthOfIcon, TitleData.heightOfIcon),
        GlobalData.urlHead + TitleData.iconUrls[i],
        "",
      ));
      curX += TitleData.widthOfIcon + TitleData.spaceBetweenIconColumns;
    }
  }

  @override
  List<WidgetModel> getWidgetModels() {
    return _headerWidgetModels;
  }

  @override
  WidgetModel getWidgetModelById(int id) {
    return _headerWidgetModels[id];
  }
}

/// This model is used for constructing content view.
class ContentComponentModel with ComponentModelMixin {
  /// Index of current tab.
  int tabIndex;

  /// Content widgets' models.
  final List<List<WidgetModel>> _contentWidgetModels = List();

  ContentComponentModel() {
    // Content area.
    _area = Area(0, 0, GlobalData.screenWidth, GlobalData.scrollHeight);
    // Tab index.
    tabIndex = 0;
    // Init models in content area.
    initHomeTabWidgetModels();
    initTvTabWidgetModels();
    initAppTabWidgetModels();
  }

  // Init all models in home tab.
  void initHomeTabWidgetModels() {
    List<WidgetModel> homeTabWidgetModels = List();
    // Build apps' models.
    double curX = HomeData.left;
    double curY = GlobalData.titleAreaHeight;
    for (int i = 0; i < HomeData.appIds.length; i++) {
      homeTabWidgetModels.add(PosterWidgetModel(
        HomeData.appIds[i],
        HomeData.appNeighbourIds[i][0],
        HomeData.appNeighbourIds[i][1],
        HomeData.appNeighbourIds[i][2],
        HomeData.appNeighbourIds[i][3],
        Area(curX, curY, HomeData.widthOfApp, HomeData.heightOfApp),
        GlobalData.urlHead + HomeData.appUrls[i],
        "",
      ));
      if (0 == (i + 1) % HomeData.appsInRow) {
        curX = HomeData.left;
        curY += HomeData.heightOfApp + HomeData.spaceBetweenAppRows;
      } else {
        curX += HomeData.widthOfApp + HomeData.spaceBetweenAppColumns;
      }
    }

    // Build movies' models.
    for (int i = 0; i < HomeData.movieIds.length; i++) {
      homeTabWidgetModels.add(PosterWidgetModel(
        HomeData.movieIds[i],
        HomeData.movieNeighbourIds[i][0],
        HomeData.movieNeighbourIds[i][1],
        HomeData.movieNeighbourIds[i][2],
        HomeData.movieNeighbourIds[i][3],
        Area(curX, curY, HomeData.widthOfMovie, HomeData.heightOfMovie),
        GlobalData.urlHead + HomeData.movieUrls[i],
        "",
      ));
      if (0 == (i + 1) % HomeData.moviesInRow) {
        curX = HomeData.left;
        curY += HomeData.heightOfMovie + HomeData.spaceBetweenMovieRows;
      } else {
        curX += HomeData.widthOfMovie + HomeData.spaceBetweenMovieColumns;
      }
    }
    _contentWidgetModels.add(homeTabWidgetModels);
  }

  // Init all models in tv tab.
  void initTvTabWidgetModels() {
    List<WidgetModel> tvTabWidgetModels = List();
    // Build window model.
    double curX = TvData.leftOfWindow;
    double curY = GlobalData.titleAreaHeight;
    tvTabWidgetModels.add(WidgetModel(
      TvData.windowId,
      TvData.windowNeighbourIds[0],
      TvData.windowNeighbourIds[1],
      TvData.windowNeighbourIds[2],
      TvData.windowNeighbourIds[3],
      Area(curX, curY, TvData.widthOfWindow, TvData.heightOfWindow),
    ));

    // Build sources' models.
    curX = TvData.leftOfSource;
    curY += TvData.heightOfWindow + TvData.spaceBetweenWindowAndSources;
    for (int i = 0; i < TvData.sourceIds.length; i++) {
      tvTabWidgetModels.add(PosterWidgetModel(
        TvData.sourceIds[i],
        TvData.sourceNeighbourIds[i][0],
        TvData.sourceNeighbourIds[i][1],
        TvData.sourceNeighbourIds[i][2],
        TvData.sourceNeighbourIds[i][3],
        Area(curX, curY, TvData.widthOfSource, TvData.heightOfSource),
        GlobalData.urlHead + TvData.sourceUrls[i],
        "",
      ));
      curX += TvData.widthOfSource + TvData.spaceBetweenSourceColumns;
    }
    _contentWidgetModels.add(tvTabWidgetModels);
  }

  // Init all models in app tab.
  void initAppTabWidgetModels() {
    List<WidgetModel> appTabWidgetModels = List();
    // Build apps' models.
    double curX = AppData.left;
    double curY = GlobalData.titleAreaHeight;
    for (int i = 0; i < AppData.appIds.length; i++) {
      appTabWidgetModels.add(PosterWidgetModel(
        AppData.appIds[i],
        AppData.appNeighbourIds[i][0],
        AppData.appNeighbourIds[i][1],
        AppData.appNeighbourIds[i][2],
        AppData.appNeighbourIds[i][3],
        Area(curX, curY, AppData.widthOfApp, AppData.heightOfApp),
        GlobalData.urlHead + AppData.appUrls[i],
        "",
      ));
      curX += AppData.widthOfApp + AppData.spaceBetweenAppColumns;
    }

    // Build flow model.
    curX = AppData.left;
    curY += AppData.heightOfApp + AppData.spaceBetweenAppRows;
    appTabWidgetModels.add(FlowWidgetModel(
      AppData.flowId,
      AppData.flowNeighbourIds[0],
      AppData.flowNeighbourIds[1],
      AppData.flowNeighbourIds[2],
      AppData.flowNeighbourIds[3],
      Area(curX, curY, AppData.widthOfFlow, AppData.heightOfFlow),
      false,
    ));
    _contentWidgetModels.add(appTabWidgetModels);
  }

  @override
  List<WidgetModel> getWidgetModels() {
    return _contentWidgetModels[tabIndex];
  }

  @override
  WidgetModel getWidgetModelById(int id) {
    return _contentWidgetModels[tabIndex][id - 6];
  }
}
