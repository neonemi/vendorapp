
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
  static String? validateEmail(String? email) {
    if (email==null )return "Please enter an email!";
    {
      if (email.isEmpty) return "Please enter an email!";
      String pattern =
          r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$';
      RegExp regExp = RegExp(pattern);
      if (!regExp.hasMatch(email)) {
        return "Please enter a valid email!";
      }
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value!.isEmpty) return 'Please choose a password.';
    if (value.length < 8) return 'Password must contain atleast 5 characters.';
    return null;
  }
}