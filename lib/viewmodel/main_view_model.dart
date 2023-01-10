import 'dart:async';

import '../viewmodel/view_model.dart';

class MainViewModel implements ViewModel {
  Stream<int> get focusStream => _focusController.stream;

  Sink<int> get focusSink => _focusController.sink;

  /// StreamController for transport focused widget id.
  StreamController<int> _focusController = StreamController<int>();

  Stream<int> get tabIndexStream => _tabIndexController.stream;

  Sink<int> get tabIndexSink => _tabIndexController.sink;

  /// StreamController for transport tab index.
  StreamController<int> _tabIndexController = StreamController<int>();

  @override
  void dispose() {
    _focusController.close();
    _tabIndexController.close();
  }
}
