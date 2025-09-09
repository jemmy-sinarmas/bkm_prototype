class User {
  final String username;
  final String password;
  final UserType userType;

  User({
    required this.username,
    required this.password,
    required this.userType,
  });
}

enum UserType {
  mandor,
  operator,
  asistenDivisi,
}

extension UserTypeExtension on UserType {
  String get displayName {
    switch (this) {
      case UserType.mandor:
        return 'Mandor';
      case UserType.operator:
        return 'Operator';
      case UserType.asistenDivisi:
        return 'Asisten Divisi';
    }
  }
}