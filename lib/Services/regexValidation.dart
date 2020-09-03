String validatePasswordCases(String value) {
  Pattern pattern = r'^(?=.*\d).{6,}$';
  RegExp regex = new RegExp(pattern);
  if (value.isEmpty) {
    return "Password field should not be empty";
  } else if (value.length < 6) {
    return "Password should have at least 8 characters";
  } else if (value.contains(" ")) {
    return "Password should not have spaces";
  } else if (!regex.hasMatch(value)) {
    return "Use letters, numbers and the underscore ";
  } else
    return null;
}

String validateEmailCases(String value) {
  Pattern pattern = r'(?=.*?[@])';
  RegExp regex = new RegExp(pattern);
  if (value.isEmpty) {
    return "Email field should not be empty";
  } else if (!regex.hasMatch(value)) {
    return "Email should have '@' character";
  } else if (value.contains(" ")) {
    return "Email should not have spaces";
  } else
    return null;
}

String validateNameCases(String value) {
  Pattern pattern = r"^[A-Z ,a-z,.'-]+$";
  RegExp regex = new RegExp(pattern);
  if (value.isEmpty) {
    return "Name should not be empty";
  } else if (!regex.hasMatch(value)) {
    return "Use only letters";
  } else
    return null;
}

String validateNumberCases(int value) {
  Pattern pattern = r"^[0-9]*$";
  RegExp regex = new RegExp(pattern);
  if (value == 0) {
    return "Number should not be empty";
  } else if (!regex.hasMatch(value.toString())) {
    return "Use only numbers";
  } else
    return null;
}
