// Customer Model
class Member {
  String memberID;
  String membername;
  String memberEmail;
  String memberTel;

  Member({
    required this.memberID,
    required this.membername,
    required this.memberEmail,
    required this.memberTel,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      memberID: json['mb_id'] ?? '',
      membername: json['mb_name'] ?? '',
      memberEmail: json['mb_email'] ?? '',
      memberTel: json['mb_tel'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mb_id': memberID,
      'mb_name': membername,
      'mb_email': memberEmail,
      'mb_tel': memberTel,
    };
  }

}