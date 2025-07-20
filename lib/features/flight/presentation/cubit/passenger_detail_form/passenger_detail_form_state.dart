part of 'passenger_detail_form_cubit.dart';

class PassengerDetailFormState extends Equatable {
  final PassengerType passengerType;
  final PassengerTitle title;
  final Gender gender;
  final String? email;
  final String? phoneNumber;
  final ProfileType? profileType;
  final DateTime? dob;
  final String? name;
  final String? lastName;
  final String id;

  PassengerDetailFormState(
      {this.passengerType = PassengerType.ADT,
      this.title = PassengerTitle.Mr,
      this.gender = Gender.Male,
      this.email,
      this.phoneNumber,
      this.profileType,
      this.dob,
      this.name,
      this.lastName,
      String? id})
      : id = id ?? const Uuid().v4();

  factory PassengerDetailFormState.initial(
      {PassengerDetailsEntity? passengerDetailsEntity,
      required PassengerType passengerType}) {
    return PassengerDetailFormState(
        dob: passengerDetailsEntity?.dob,
        id: passengerDetailsEntity?.id,
        title: passengerDetailsEntity?.title ?? PassengerTitle.Mr,
        profileType: passengerDetailsEntity?.profileType,
        email: passengerDetailsEntity?.email,
        phoneNumber: passengerDetailsEntity?.phoneNumber,
        gender: passengerDetailsEntity?.gender ?? Gender.Male,
        passengerType: passengerDetailsEntity?.passengerType ?? passengerType,
        lastName: passengerDetailsEntity?.lastName,
        name: passengerDetailsEntity?.name);
  }

  PassengerDetailFormState copyWith({
    PassengerType? passengerType,
    PassengerTitle? title,
    Gender? gender,
    String? email,
    String? phoneNumber,
    ProfileType? profileType,
    DateTime? dob,
    String? name,
    String? lastName,
  }) {
    return PassengerDetailFormState(
        passengerType: passengerType ?? this.passengerType,
        title: title ?? this.title,
        gender: gender ?? this.gender,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        profileType: profileType ?? this.profileType,
        dob: dob ?? this.dob,
        name: name ?? this.name,
        lastName: lastName ?? this.lastName,
        id: id);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        passengerType,
        title,
        gender,
        email,
        phoneNumber,
        profileType,
        dob,
        name,
        lastName
      ];
}
