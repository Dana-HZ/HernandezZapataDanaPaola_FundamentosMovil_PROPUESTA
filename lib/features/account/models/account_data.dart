class AccountData {
  String name;
  String lastName;
  String email;

  AccountData({required this.name, required this.lastName, required this.email});

  String get fullName => '$name $lastName'.trim();
}
