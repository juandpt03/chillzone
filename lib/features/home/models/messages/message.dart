class Message {
  final Role role;
  final String message;

  Message({
    required this.role,
    required this.message,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        role: RoleConverter.fromString(json["role"]),
        message: json["content"],
      );

  factory Message.empty() => Message(role: Role.system, message: '');

  Map<String, dynamic> toJson() => {
        "role": role.name,
        "content": message,
      };
}

enum Role { user, system, assistant }

extension RoleConverter on Role {
  static Role fromString(String role) {
    try {
      return Role.values
          .firstWhere((r) => r.toString().split('.').last == role);
    } catch (e) {
      throw Exception('Unknown role: $role');
    }
  }
}
