class ValidatorService {
  static String validateEmail(String value) {
    if (value.contains('@yopmail')) return "Please enter a valid E-mail.";
    value = value.replaceAll(new RegExp(r"\s+\b|\b\s"), "");
    Pattern pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return "validation.email";
    else
      return null;
  }

  static String samePasswordValidation(String password, String repassword) {
    if (password != repassword) {
      return "validation.password.verif";
    } else
      return null;
  }

  static String validatePassword(String value) {
    Pattern pattern = r'^.{8,}$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'validation.password';
    else
      return null;
  }

  static String validateUsername(String value) {
    Pattern pattern = r'^[(a-z)|(A-Z)|(0-9)|( )]{6,20}$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value.trim()))
      return "validation.username";
    else
      return null;
  }

  static String fullNameValidate(String fullName) {
    String patttern = r'^[a-z A-Z]+$';
    RegExp regExp = new RegExp(patttern);
    if (fullName.length == 0) {
      return 'Please enter full name';
    } else if (!regExp.hasMatch(fullName)) {
      return 'Please enter valid full name';
    }
    return null;
  }

  static String positionValidate(String position) {
    String patttern = r'^[a-z A-Z]+$';
    RegExp regExp = new RegExp(patttern);
    if (position.length == 0) {
      return 'Please enter position';
    } else if (!regExp.hasMatch(position)) {
      return 'Please enter valid position';
    }
    return null;
  }

  static String articleNameValidate(String name) {
    String patttern = r'^[a-z A-Z]+$';
    RegExp regExp = new RegExp(patttern);
    if (name.length == 0) {
      return 'Please enter article name';
    } else if (!regExp.hasMatch(name)) {
      return 'Please enter valid name';
    }
    return null;
  }
}
