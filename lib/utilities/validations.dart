


mixin Validations {


  String? validateEmail(String? value) {
    if (value == null ||
        value.length < 3 ||
        value.isEmpty) {
      return 'wrong email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null ||
        value.length < 3 ||
        value.isEmpty) {
      return 'wrong password';
    }
    return null;
  }

}
