/// This model is used for constructing position.
class Area {
  const Area(this._x, this._y, this._w, this._h);

  double get x => _x;
  final double _x;

  double get y => _y;
  final double _y;

  double get w => _w;
  final double _w;

  double get h => _h;
  final double _h;
}

/// This model contains base attributes for common widget.
class WidgetModel {
  const WidgetModel(this._id, this._upId, this._downId, this._leftId,
      this._rightId, this._area);

  /// The ID of widget.
  int get id => _id;
  final int _id;

  /// The neighbours' ID of widget.
  int get upId => _upId;
  final int _upId;

  int get downId => _downId;
  final int _downId;

  int get leftId => _leftId;
  final int _leftId;

  int get rightId => _rightId;
  final int _rightId;

  /// The position of widget.
  Area get area => _area;
  final Area _area;
}

/// This model is used for constructing poster widget.
class PosterWidgetModel extends WidgetModel {
  const PosterWidgetModel(int id, int upId, int downId, int leftId, int rightId,
      Area area, this._url, this._text)
      : super(id, upId, downId, leftId, rightId, area);

  /// The url of poster.
  String get url => _url;
  final String _url;

  /// The text of poster.
  String get text => _text;
  final String _text;
}

/// This model is used for constructing title widget.
class TitleWidgetModel extends WidgetModel {
  const TitleWidgetModel(int id, int upId, int downId, int leftId, int rightId,
      Area area, this._text, this._fontSize)
      : super(id, upId, downId, leftId, rightId, area);

  /// The text of title.
  String get text => _text;
  final String _text;

  /// The font size of title.
  double get fontSize => _fontSize;
  final double _fontSize;
}

/// This model is used for constructing flow widget.
class FlowWidgetModel extends WidgetModel {
  FlowWidgetModel(int id, int upId, int downId, int leftId, int rightId,
      Area area, this.onFocus)
      : super(id, upId, downId, leftId, rightId, area);

  /// Whether flow widget has focus or not.
  bool onFocus;
}
