enum Gender {
  male,
  female,
  unknown,
}

extension GenderExt on Gender {
  int get genderIndex {
    switch (this) {
      case Gender.unknown:
        return 2;
      case Gender.male:
        return 0;
      case Gender.female:
        return 1;
    }
  }

  Gender fromIndex(int index) {
    switch (index) {
      case 1:
        return Gender.female;
      case 0:
        return Gender.male;
      default:
        return Gender.unknown;
    }
  }
}