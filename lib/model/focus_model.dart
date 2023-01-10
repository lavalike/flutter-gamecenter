import '../model/widget_model.dart';

class FocusModel {
  WidgetModel get preFocusWidgetModel => _preFocusWidgetModel;

  /// Previous focused widget's model.
  WidgetModel _preFocusWidgetModel;

  WidgetModel get curFocusWidgetModel => _curFocusWidgetModel;

  /// Current focused widget's model.
  WidgetModel _curFocusWidgetModel;

  FocusModel(this._preFocusWidgetModel, this._curFocusWidgetModel);

  /// Update current focused widget model.
  void updateFocusModel(WidgetModel widgetModel) {
    _preFocusWidgetModel = _curFocusWidgetModel;
    _curFocusWidgetModel = widgetModel;
  }
}
