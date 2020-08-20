class UserModel{
  String name, phoneNumber, userId;

  UserModel({this.name,this.phoneNumber,this.userId});

  UserModel.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    userId= map['userId'];
    phoneNumber = map['phoneNumber'];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
//      'date': this.date.toIso8601String(),

      'name': name,
      'userId': userId,
      'phoneNumber': phoneNumber,
    };
  }
}