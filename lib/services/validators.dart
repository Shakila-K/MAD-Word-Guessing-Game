class Validators {
  String? validateString(String? value) {
    const pattern = r'^[a-zA-Z\s]+$';
    final regex = RegExp(pattern);
    if (value == null || value.isEmpty) {
      return 'This field is required';
    } else if (!regex.hasMatch(value)) {
      return 'Invalid characters';
    }
    return null;
  }

   String? validateCharacter(String? value) {
    const pattern = r'^[a-zA-Z]$';
    final regex = RegExp(pattern);

    if (value == null || value.isEmpty) {
      return 'This field is required';
    } else if (!regex.hasMatch(value)) {
      return 'Please enter a single letter';
    }
    return null;
  }

}