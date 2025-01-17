// validation.dart

class Validation {
  static String? makeValidation(String? value) {
    if (value == null || value.isEmpty) {
      return "Required Field";
    }
    return null;
  }
}
