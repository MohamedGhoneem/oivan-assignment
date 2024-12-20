import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user_model.dart';

// class UsersLocalDataSource {
//   final SharedPreferences _prefs;
//   static const String _bookmarkedUsersKey = 'bookmarked_users';
//
//   UsersLocalDataSource(this._prefs);
//
//   Future<List<int>> getBookmarkedUserIds() async {
//     final jsonString = _prefs.getString(_bookmarkedUsersKey);
//     if (jsonString == null) return [];
//
//     final List<dynamic> jsonList = json.decode(jsonString);
//     return jsonList.map((id) => id as int).toList();
//   }
//
//   Future<List<UserModel>> getBookmarkedUsers() async {
//     final jsonString = _prefs.getString(_bookmarkedUsersKey);
//     if (jsonString == null) return [];
//
//     final List<dynamic> jsonList = json.decode(jsonString);
//     return jsonList.map((json) => UserModel.fromJson(json)).toList();
//   }
//
//   Future<void> toggleBookmark(UserModel user) async {
//     final bookmarkedUsers = await getBookmarkedUsers();
//     final userIndex =
//         bookmarkedUsers.indexWhere((u) => u.userId == user.userId);
//
//     if (userIndex >= 0) {
//       bookmarkedUsers.removeAt(userIndex);
//     } else {
//       bookmarkedUsers.add(user);
//     }
//
//     await _saveBookmarkedUsers(bookmarkedUsers);
//   }
//
//   Future<void> _saveBookmarkedUsers(List<UserModel> users) async {
//     final jsonString = json.encode(users.map((user) => user.toJson()).toList());
//     await _prefs.setString(_bookmarkedUsersKey, jsonString);
//   }
//
//   Future<void> clearBookmarks() async {
//     await _prefs.remove(_bookmarkedUsersKey);
//   }
// }

class UsersLocalDataSource {
  final SharedPreferences _prefs;
  static const String _bookmarkedUsersKey = 'bookmarked_users';

  UsersLocalDataSource(this._prefs);

  Future<List<int>> getBookmarkedUserIds() async {
    final jsonString = _prefs.getString(_bookmarkedUsersKey);
    if (jsonString == null) return [];

    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((id) => id as int).toList();
  }

  Future<List<UserModel>> getBookmarkedUsers() async {
    final jsonString = _prefs.getString(_bookmarkedUsersKey);
    if (jsonString == null) return [];

    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => UserModel.fromJson(json)).toList();
  }

  Future<void> toggleBookmark(UserModel user) async {
    final bookmarkedUsers = await getBookmarkedUsers();
    final userIndex =
    bookmarkedUsers.indexWhere((u) => u.userId == user.userId);

    if (userIndex >= 0) {
      bookmarkedUsers.removeAt(userIndex);
    } else {
      bookmarkedUsers.add(user);
    }

    await _saveBookmarkedUsers(bookmarkedUsers);
  }

  Future<void> _saveBookmarkedUsers(List<UserModel> users) async {
    final jsonString = json.encode(users.map((user) => user.toJson()).toList());
    await _prefs.setString(_bookmarkedUsersKey, jsonString);
  }

  Future<void> clearBookmarks() async {
    await _prefs.remove(_bookmarkedUsersKey);
  }
}
