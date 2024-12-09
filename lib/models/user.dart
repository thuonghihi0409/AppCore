class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String avatarUrl; // URL của hình đại diện (nếu có)

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    this.avatarUrl = '',
  });

  // Phương thức để chuyển đối tượng User thành Map (để lưu trữ hoặc gửi API)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'avatarUrl': avatarUrl,
    };
  }

  // Phương thức để tạo đối tượng User từ Map (khi nhận dữ liệu từ API)
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      avatarUrl: map['avatarUrl'] ?? '',
    );
  }
}
