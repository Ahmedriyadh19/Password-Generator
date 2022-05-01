import 'dart:convert';

class PasswordDetails {
  String url = 'N/A';
  String email = 'N/A';
  String remark = 'N/A';
  String password = 'N/A';

  PasswordDetails({
    required this.url,
    required this.email,
    required this.remark,
    required this.password,
  });

  PasswordDetails copyWith({
    String? url,
    String? email,
    String? remark,
    String? password,
  }) {
    return PasswordDetails(
      url: url ?? this.url,
      email: email ?? this.email,
      remark: remark ?? this.remark,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'email': email,
      'remark': remark,
      'password': password,
    };
  }

  factory PasswordDetails.fromMap(Map<String, dynamic> map) {
    return PasswordDetails(
      url: map['url'] ?? '',
      email: map['email'] ?? '',
      remark: map['remark'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PasswordDetails.fromJson(String source) =>
      PasswordDetails.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PasswordDetails(url: $url, email: $email, remark: $remark, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PasswordDetails &&
        other.url == url &&
        other.email == email &&
        other.remark == remark &&
        other.password == password;
  }

  @override
  int get hashCode {
    return url.hashCode ^ email.hashCode ^ remark.hashCode ^ password.hashCode;
  }
}
