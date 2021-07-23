// import 'package:equatable/equatable.dart';

class User {
  final String? className;
  final int? userId;
  final int? id;
  final String? title;
  final String? body;
  final bool? isold;

  const User({
    this.className,
    this.userId,
    this.id,
    this.title,
    this.body,
    this.isold,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        className: json['__className'] as String?,
        userId: json['userId'] as int?,
        id: json['id'] as int?,
        title: json['title'] as String?,
        body: json['body'] as String?,
        isold: json['isold'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        '__className': className,
        'userId': userId,
        'id': id,
        'title': title,
        'body': body,
        'isold': isold,
      };

  User copyWith({
    String? className,
    int? userId,
    int? id,
    String? title,
    String? body,
    bool? isold,
  }) {
    return User(
      className: className ?? this.className,
      userId: userId ?? this.userId,
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      isold: isold ?? this.isold,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [className, userId, id, title, body, isold];
}
