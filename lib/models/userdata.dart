class Userdata {
  final String nickname;
  final String profileimage;

  Userdata(this.nickname, this.profileimage);

  Userdata.fromJson(Map<String, dynamic> json)
      : nickname = json['username'],
        profileimage = json['Image'];

  Map<String, dynamic> toJson() => {
        'username': nickname,
        'Image': profileimage,
      };
}