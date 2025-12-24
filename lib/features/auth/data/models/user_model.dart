class UserModel {
  final String id;
  final String username;
  final String email;
  final bool isEmailVerified;
  final String? phone;
  final bool isPhoneVerified;
  final String? profilePicture;
  final String role;
  final String userType;
  final String? platformId;
  final String signupMethod;
  final bool isActive;
  final bool isDeleted;
  final DateTime? deletedAt;
  final String? stripeCustomerId;
  final bool isSubscribed;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.isEmailVerified,
    this.phone,
    required this.isPhoneVerified,
    this.profilePicture,
    required this.role,
    required this.userType,
    this.platformId,
    required this.signupMethod,
    required this.isActive,
    required this.isDeleted,
    this.deletedAt,
    this.stripeCustomerId,
    required this.isSubscribed,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      isEmailVerified: json['isEmailVerified'] as bool? ?? false,
      phone: json['phone'] as String?,
      isPhoneVerified: json['isPhoneVerified'] as bool? ?? false,
      profilePicture: json['profilePicture'] as String?,
      role: json['role'] as String? ?? 'USER',
      userType: json['userType'] as String? ?? 'REGISTERED',
      platformId: json['platformId'] as String?,
      signupMethod: json['signupMethod'] as String? ?? 'EMAIL',
      isActive: json['isActive'] as bool? ?? true,
      isDeleted: json['isDeleted'] as bool? ?? false,
      deletedAt: json['deletedAt'] != null
          ? DateTime.parse(json['deletedAt'] as String)
          : null,
      stripeCustomerId: json['stripeCustomerId'] as String?,
      isSubscribed: json['isSubscribed'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'isEmailVerified': isEmailVerified,
      'phone': phone,
      'isPhoneVerified': isPhoneVerified,
      'profilePicture': profilePicture,
      'role': role,
      'userType': userType,
      'platformId': platformId,
      'signupMethod': signupMethod,
      'isActive': isActive,
      'isDeleted': isDeleted,
      'deletedAt': deletedAt?.toIso8601String(),
      'stripeCustomerId': stripeCustomerId,
      'isSubscribed': isSubscribed,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
