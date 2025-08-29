import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yellow_rose/features/hotel/data/models/places/places.dart';
import 'package:yellow_rose/features/hotel/domain/entities/hotel_search.dart';

part 'hotel_search_state.dart';

class HotelSearchCubit extends Cubit<HotelSearchState> {
  HotelSearchCubit() : super(HotelSearchState.initial());
  void loadInitial({HotelSearch? hotelSearch}) {
    emit(HotelSearchState.initial(hotelSearch: hotelSearch));
  }

  void onCheckInDateChange(DateTime date) {
    var currState = state;
    emit(currState.copyWith(checkInDate: date));
  }

  void onCheckOutDateChange(DateTime date) {
    var currState = state;
    emit(currState.copyWith(checkOutDate: date));
  }

  void onRoomCountChange(int count) {
    var currState = state;
    emit(currState.copyWith(roomCount: count));
  }

  void onAdultCountChange(int count) {
    var currState = state;
    emit(currState.copyWith(adultCount: count));
  }

  void onAddChildAge(int age) {
    var currState = state;
    var childAges = List<int>.from(currState.childAges ?? []);
    childAges.add(age);
    emit(currState.copyWith(childAges: childAges));
  }

  void onUpdateChildAge(List<int?>? ages) {
    var currState = state;
    List<int>? agesN = ages?.where((age) => age != null).cast<int>().toList();
    List<int> childAges = [...(agesN ?? [])];
    emit(currState.copyWith(childAges: childAges));
  }

  void onRemoveChildAge(int age) {
    var currState = state;
    var childAges = List<int>.from(currState.childAges ?? []);
    childAges.remove(age);
    emit(currState.copyWith(childAges: childAges));
  }

  void onPlaceChange(PlaceEntity place) {
    var currState = state;
    emit(currState.copyWith(place: place));
  }

  HotelSearch getHotelSearch() {
    return HotelSearch(
      checkInDate: state.checkInDate,
      checkOutDate: state.checkOutDate,
      roomCount: state.roomCount,
      adultCount: state.adultCount,
      childAges: state.childAges,
      place: state.place,
    );
  }
}
