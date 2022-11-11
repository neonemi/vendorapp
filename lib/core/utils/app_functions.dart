
class AppFunctions{
  static bool isEmailValid(String email) {
    //Regex pattern for matching email
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regex = RegExp(pattern);
    if (email.isEmpty) {
      return false;
    } else {
      if (!regex.hasMatch(email)) {
        return false;
      } else {
        return true;
      }
    }
  }
}