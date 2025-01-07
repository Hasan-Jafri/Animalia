// ignore: constant_identifier_names

class User {
  late String username;
  late String email;
  late bool loggedIn;
  late String userID;
  late String token;

  User({this.username = "", this.email = "", this.loggedIn = false});
  bool isAuth() {
    if (loggedIn) {
      return true;
    }
    return false;
  }

  void setlogin(bool val) {
    loggedIn = val;
  }

  void setUser(String name, String email) {
    username = name;
    email = email;
  }
}

// Single object for user to be utilized in the whole app flow.
User user = User();
