import 'package:nfc_mobile_prototype/core/services/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  late final SharedPreferences _preferences;

  static const _appThemeField = 'isCustomTheme';
  static const _userRoleField = 'isUserAdmin';

  Future<void> init() async {
    logDebug('LocalStorageService -> init()');
    _preferences = await SharedPreferences.getInstance();
  }

  bool getAppTheme() {
    logDebug('LocalStorageService -> getAppTheme()');
    return _preferences.getBool(_appThemeField) ?? false;
  }

  bool getUserRole() {
    logDebug('LocalStorageService -> getUserRole()');
    return _preferences.getBool(_userRoleField) ?? false;
  }

  void updateAppTheme(bool isCustomTheme) {
    logDebug('LocalStorageService -> updateAppTheme($isCustomTheme)');
    _preferences.setBool(_appThemeField, isCustomTheme);
  }

  void updateUserRole(bool isUserAdmin) {
    logDebug('LocalStorageService -> updateUserRole($isUserAdmin)');
    _preferences.setBool(_userRoleField, isUserAdmin);
  }
}