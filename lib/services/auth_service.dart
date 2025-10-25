import 'package:shared_preferences/shared_preferences.dart';

enum AppMode {
  view('view', 'VIEW_PASSWORD'),
  edit('edit', 'EDIT_PASSWORD');

  const AppMode(this.queryParam, this.password);
  
  final String queryParam;
  final String password;
  
  static AppMode fromString(String? mode) {
    switch (mode) {
      case 'edit':
        return AppMode.edit;
      case 'view':
      default:
        return AppMode.view;
    }
  }
}

class AuthService {
  static const String _viewAuthKey = 'view_authenticated';
  static const String _editAuthKey = 'edit_authenticated';
  
  static const String _viewPassword = 'view123';
  static const String _editPassword = 'edit456';

  Future<bool> isAuthenticated(AppMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    final key = mode == AppMode.view ? _viewAuthKey : _editAuthKey;
    return prefs.getBool(key) ?? false;
  }

  Future<bool> authenticate(AppMode mode, String password) async {
    final expectedPassword = mode == AppMode.view ? _viewPassword : _editPassword;
    
    if (password == expectedPassword) {
      final prefs = await SharedPreferences.getInstance();
      final key = mode == AppMode.view ? _viewAuthKey : _editAuthKey;
      await prefs.setBool(key, true);
      return true;
    }
    return false;
  }

  Future<void> logout(AppMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    final key = mode == AppMode.view ? _viewAuthKey : _editAuthKey;
    await prefs.setBool(key, false);
  }

  Future<void> logoutAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_viewAuthKey, false);
    await prefs.setBool(_editAuthKey, false);
  }

  String getPasswordHint(AppMode mode) {
    return mode == AppMode.view 
        ? '名簿閲覧用のパスワードを入力してください'
        : '名簿編集用のパスワードを入力してください';
  }
}