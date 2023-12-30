class User {
  String name;
  String? email;
  String? profileImagePath;
  User({required this.name, this.email, this.profileImagePath});

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        email = json['email'] != null ? json['email'] as String : null,
        profileImagePath = json['profile_image_path'] != null
            ? json['profile_image_path'] as String
            : null;

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'profile_image_path': profileImagePath,
      };
}
