class Employee {
  final int id;
  late final String firstName;
  late final String lastName;
  late final String email;
  final String avatar;

  Employee({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.avatar,
  });

  // Convert Employee to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'avatar': avatar,
    };
  }

  // Create Employee from Map
  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      id: map['id'],
      firstName: map['first_name'],
      lastName: map['last_name'],
      email: map['email'],
      avatar: map['avatar'],
    );
  }

  // Define the copyWith method
  Employee copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? email,
    String? avatar,
  }) {
    return Employee(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
    );
  }
}

