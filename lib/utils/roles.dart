enum AppRole {
  admin,
  user;

  String get name {
    if (this == AppRole.admin) {
      return 'admin';
    } else {
      return 'user';
    }
  }
}
