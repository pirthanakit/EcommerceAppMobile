class RegisterRequestModel {
  RegisterRequestModel({
    this.username,
    this.password,
    this.firstname,
    this.lastname,
    this.email,
    this.phone,
  });
  late final String? username;
  late final String? password;
  late final String? email;
  late final String? firstname;
  late final String? lastname;
  late final String? phone;

  RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    email = json['email'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['username'] = username;
    _data['password'] = password;
    _data['email'] = email;
    _data['firstname'] = firstname;
    _data['lastname'] = lastname;
    _data['phone'] = phone;
    return _data;
  }
}