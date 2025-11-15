import 'dart:convert';

class BusPassenger {
  final String? address;
  final int? age;
  final String? email;
  final String? gender;
  final String? idNumber;
  final String? idType;
  final int? mobile;
  final String? name;
  final String? primary; // could also be Boolean
  final String? title;
  final int? id;
  final String? singleLadies;
  BusPassenger({
    this.address,
    this.age,
    this.email,
    this.gender,
    this.idNumber,
    this.idType,
    this.mobile,
    this.name,
    this.primary,
    this.title,
    this.id,
    this.singleLadies,
  });

  BusPassenger copyWith({
    String? address,
    int? age,
    String? email,
    String? gender,
    String? idNumber,
    String? idType,
    int? mobile,
    String? name,
    String? primary,
    String? title,
    int? id,
    String? singleLadies,
  }) {
    return BusPassenger(
      address: address ?? this.address,
      age: age ?? this.age,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      idNumber: idNumber ?? this.idNumber,
      idType: idType ?? this.idType,
      mobile: mobile ?? this.mobile,
      name: name ?? this.name,
      primary: primary ?? this.primary,
      title: title ?? this.title,
      id: id ?? this.id,
      singleLadies: singleLadies ?? this.singleLadies,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(address != null){
      result.addAll({'address': address});
    }
    if(age != null){
      result.addAll({'age': age});
    }
    if(email != null){
      result.addAll({'email': email});
    }
    if(gender != null){
      result.addAll({'gender': gender});
    }
    if(idNumber != null){
      result.addAll({'idNumber': idNumber});
    }
    if(idType != null){
      result.addAll({'idType': idType});
    }
    if(mobile != null){
      result.addAll({'mobile': mobile});
    }
    if(name != null){
      result.addAll({'name': name});
    }
    if(primary != null){
      result.addAll({'primary': primary});
    }
    if(title != null){
      result.addAll({'title': title});
    }
    if(id != null){
      result.addAll({'id': id});
    }
    if(singleLadies != null){
      result.addAll({'singleLadies': singleLadies});
    }
  
    return result;
  }

  factory BusPassenger.fromMap(Map<String, dynamic> map) {
    return BusPassenger(
      address: map['address'],
      age: map['age']?.toInt(),
      email: map['email'],
      gender: map['gender'],
      idNumber: map['idNumber'],
      idType: map['idType'],
      mobile: map['mobile']?.toInt(),
      name: map['name'],
      primary: map['primary'],
      title: map['title'],
      id: map['id']?.toInt(),
      singleLadies: map['singleLadies'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BusPassenger.fromJson(String source) => BusPassenger.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BusPassenger(address: $address, age: $age, email: $email, gender: $gender, idNumber: $idNumber, idType: $idType, mobile: $mobile, name: $name, primary: $primary, title: $title, id: $id, singleLadies: $singleLadies)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is BusPassenger &&
      other.address == address &&
      other.age == age &&
      other.email == email &&
      other.gender == gender &&
      other.idNumber == idNumber &&
      other.idType == idType &&
      other.mobile == mobile &&
      other.name == name &&
      other.primary == primary &&
      other.title == title &&
      other.id == id &&
      other.singleLadies == singleLadies;
  }

  @override
  int get hashCode {
    return address.hashCode ^
      age.hashCode ^
      email.hashCode ^
      gender.hashCode ^
      idNumber.hashCode ^
      idType.hashCode ^
      mobile.hashCode ^
      name.hashCode ^
      primary.hashCode ^
      title.hashCode ^
      id.hashCode ^
      singleLadies.hashCode;
  }
}
