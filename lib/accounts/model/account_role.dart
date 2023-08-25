enum AccountRole {
  USER("USER"),
  ADMIN("ADMIN");

  final String value;

  const AccountRole(this.value);

  static AccountRole fromString(String str) {
    for (final type in AccountRole.values) {
      if (type.value == str) {
        return type;
      }
    }
    return AccountRole.USER;
  }

  static String asString(AccountRole type) {
    return type.value;
  }
}
