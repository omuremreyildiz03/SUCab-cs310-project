import 'preferences.dart';

enum Gender {
  male,
  female,
  nonBinary,
  unanswered;

  String get label {
    switch (this) {
      case Gender.male:
        return "Male";
      case Gender.female:
        return "Female";
      case Gender.nonBinary:
        return "Non-binary";
      case Gender.unanswered:
        return "Unanswered";
    }
  }
}

class Profile{
  final int id;
  final String name;
  final Gender gender;
  final Preferences preferences;

  Profile({
    this.id = 0,
    this.name = "",
    this.gender = Gender.unanswered,
    Preferences? preferences,
  }) : preferences = preferences ?? Preferences();

}
