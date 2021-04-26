class UserDetails {
  String _uId;
  String _uName;
  String _uType;
  String _uEmail;
  String _uPassword;
  String _uProfilePic;

  UserDetails(
      [this._uId,
      this._uName,
      this._uEmail,
      this._uPassword,
      this._uType,
      this._uProfilePic]);

  String get uId => _uId;

  String get uName => _uName;

  String get uType => _uType;

  String get uPassword => _uPassword;

  String get uEmail => _uEmail;

  String get uProfilePic => _uProfilePic;

  set uId(String newuId) {
    if (newuId.length <= 255) {
      this._uId = newuId;
    }
  }

  set uName(String newuName) {
    if (newuName.length <= 255) {
      this._uName = newuName;
    }
  }

  set uType(String newuType) {
    if (newuType.length <= 255) {
      this._uType = newuType;
    }
  }

  set uPassword(String newuPassword) {
    if (newuPassword.length <= 255) {
      this._uPassword = newuPassword;
    }
  }

  set uEmail(String newuEmail) {
    this._uEmail = newuEmail;
  }

  set uProfilePic(String newuProfilePic) {
    this._uProfilePic = newuProfilePic;
  }
}
