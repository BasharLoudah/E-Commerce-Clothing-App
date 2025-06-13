class UserModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final dynamic gender;
  final int active;
  final String image;
  final String type;
  final int userableId;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.gender,
    required this.active,
    required this.image,
    required this.type,
    required this.userableId,
  });

  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    dynamic gender,
    int? active,
    String? image,
    String? type,
    int? userableId,
    DateTime? createdAt,
  }) =>
      UserModel(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        gender: gender ?? this.gender,
        active: active ?? this.active,
        image: image ?? this.image,
        type: type ?? this.type,
        userableId: userableId ?? this.userableId,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        gender: json["gender"] ?? 'male',
        active: json["active"],
        image: json["image"] ?? '',
        type: json["type"] ?? '',
        userableId: json["userable_id"],
   );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "gender": gender,
        "active": active,
        "image": image,
        "type": type,
        "userable_id": userableId,

      };
}
