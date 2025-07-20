import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';
import 'package:yellow_rose/core/utils/extensions.dart';
import 'package:yellow_rose/features/flight/domain/entities/gender.dart';
import 'package:yellow_rose/features/flight/domain/entities/passenger_department_details.dart';
import 'package:yellow_rose/features/flight/domain/entities/passenger_details_entity.dart';
import 'package:yellow_rose/features/flight/domain/entities/passenger_title.dart';
import 'package:yellow_rose/features/flight/domain/entities/passenger_type.dart';
import 'package:yellow_rose/features/flight/domain/entities/profile_type.dart';

part 'passenger_detail_form_state.dart';

class PassengerDetailFormCubit extends Cubit<PassengerDetailFormState> {
  PassengerDetailFormCubit(
      {PassengerDetailsEntity? passengerDetailsEntity,
      required PassengerType passengerType})
      : super(PassengerDetailFormState.initial(
            passengerDetailsEntity: passengerDetailsEntity,
            passengerType: passengerType));

  void onGenderChange(Gender? gender) {
    var title = state.title;
    if (gender == Gender.Female) {
      title = PassengerTitle.Ms;
    } else {
      title = PassengerTitle.Mr;
    }
    emit(state.copyWith(gender: gender, title: title));
  }

  void onNameChange(String? name) {
    emit(state.copyWith(name: name));
  }

  void onLastNameChange(String? lastName) {
    emit(state.copyWith(lastName: lastName));
  }

  void onTitleChange(String? title) {
    var value = stringToEnum(title, PassengerTitle.values);
    emit(state.copyWith(title: value));
  }

  void onEmailChange(String? email) {
    emit(state.copyWith(email: email));
  }

  void onPhoneNumberChange(String? number) {
    emit(state.copyWith(phoneNumber: number));
  }

  void onDobChange(String? number) {
    emit(state.copyWith(dob: DateTime.tryParse(number ?? '')));
  }

  PassengerDetailsEntity getPassengerDetails() {
    return PassengerDetailsEntity(
        passengerType: state.passengerType,
        title: state.title,
        gender: state.gender,
        email: state.email!.trim(),
        name: state.name!.trim().toTitleCase(),
        dob: state.dob,
        lastName: state.lastName!.trim().toTitleCase(),
        phoneNumber: state.phoneNumber!,
        id: state.id);
  }
}
