import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStateProvider with ChangeNotifier {
  void hasOnboarded() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoardCount', 1);
    notifyListeners();
  }
}
