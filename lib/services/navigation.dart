import 'package:flutter/cupertino.dart';

class Navigation {
  static GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();
  static NavigatorState get state => key.currentState!;
}