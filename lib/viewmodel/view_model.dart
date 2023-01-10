import 'package:flutter/material.dart';

abstract class ViewModel {
  void dispose();
}

// Base BLoC provider
class BlocProvider<T extends ViewModel> extends StatefulWidget {
  BlocProvider({
    Key key,
    @required this.bloc,
    @required this.child,
  }) : super(key: key);

  final T bloc;
  final Widget child;

  @override
  _BlocProviderState<T> createState() => _BlocProviderState<T>();

  static T of<T extends ViewModel>(BuildContext context) {
    final type = _typeOf<BlocProvider<T>>();
    BlocProvider<T> provider = context.ancestorWidgetOfExactType(type);
    return provider.bloc;
  }

  static _typeOf<T>() => T;
}

class _BlocProviderState<T> extends State<BlocProvider<ViewModel>> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }
}
