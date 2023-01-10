import 'dart:async';

import '../models/top_post_model.dart';

class TopPostViewModel {
  var _topPostController = StreamController<TopPostModel>.broadcast();

  Sink get inTopPostController => _topPostController;

  Stream<TopPostModel> get outTopPost => _topPostController.stream;

  void dispose() => _topPostController.close();
}
