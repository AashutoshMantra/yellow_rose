import 'dart:convert';

class Airport {
  String? name;
  String? city;
  String? country;
  String? state;
  String? status;
  String? iataCode;
  String? icaoCode;
  String? latitude;
  String? longitude;
  String? elevation;
  String? timeZoneOffset;
  String? timeZone;
  String? creationTime;
  int? id;

  Airport(
      {this.name,
      this.city,
      this.country,
      this.state,
      this.status,
      this.iataCode,
      this.icaoCode,
      this.latitude,
      this.longitude,
      this.elevation,
      this.timeZoneOffset,
      this.timeZone,
      this.creationTime,
      this.id});

  

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(name != null){
      result.addAll({'name': name});
    }
    if(city != null){
      result.addAll({'city': city});
    }
    if(country != null){
      result.addAll({'country': country});
    }
    if(state != null){
      result.addAll({'state': state});
    }
    if(status != null){
      result.addAll({'status': status});
    }
    if(iataCode != null){
      result.addAll({'iataCode': iataCode});
    }
    if(icaoCode != null){
      result.addAll({'icaoCode': icaoCode});
    }
    if(latitude != null){
      result.addAll({'latitude': latitude});
    }
    if(longitude != null){
      result.addAll({'longitude': longitude});
    }
    if(elevation != null){
      result.addAll({'elevation': elevation});
    }
    if(timeZoneOffset != null){
      result.addAll({'timeZoneOffset': timeZoneOffset});
    }
    if(timeZone != null){
      result.addAll({'timeZone': timeZone});
    }
    if(creationTime != null){
      result.addAll({'creationTime': creationTime});
    }
    if(id != null){
      result.addAll({'id': id});
    }
  
    return result;
  }

  factory Airport.fromMap(Map<dynamic, dynamic> map) {
    return Airport(
     name: map['name'],
    city: map['city'],
    country:  map['country'],
     state: map['state'],
    status:  map['status'],
    iataCode:  map['iataCode'],
    icaoCode:  map['icaoCode'],
    latitude:  map['latitude'],
    longitude:  map['longitude'],
    elevation:  map['elevation'],
    timeZoneOffset: map['timeZoneOffset'],
    timeZone:  map['timeZone'],
    creationTime:  map['creationTime'],
     id: map['id']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Airport.fromJson(String source) => Airport.fromMap(json.decode(source));
}
