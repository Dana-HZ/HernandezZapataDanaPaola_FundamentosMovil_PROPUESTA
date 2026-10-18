class AuthFormData {
  final String name;
  final String lastName;
  final String email;
  final String password;
  final String confirmPassword;

  const AuthFormData({
    this.name = '',
    this.lastName = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
  });
}
