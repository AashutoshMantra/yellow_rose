import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yellow_rose/features/auth/presentation/pages/sign_in_screen.dart';
import 'package:yellow_rose/features/bus/data/models/order/bos_block_response.dart';
import 'package:yellow_rose/features/bus/data/models/order/bus_order_itinerary.dart';
import 'package:yellow_rose/features/flight/data/models/airsearch/air_response_data.dart';
import 'package:yellow_rose/features/flight/data/models/airsearch/fare_details_with_type.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/update_order_detail_response.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order_status/air_order_iitinerary.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order_status/order_status.dart';
import 'package:yellow_rose/features/flight/domain/entities/flight_recent_search.dart';
import 'package:yellow_rose/features/flight/presentation/cubit/flight_booking/flight_booking_cubit.dart';
import 'package:yellow_rose/features/flight/presentation/cubit/flight_order_modify/flight_order_modify_cubit.dart';
import 'package:yellow_rose/features/flight/presentation/cubit/flight_search_listing_cubit/flight_search_listing_cubit.dart';
import 'package:yellow_rose/features/flight/presentation/pages/air_addond_selection_screen.dart';
import 'package:yellow_rose/features/flight/presentation/pages/booking_detailed_screen.dart';
import 'package:yellow_rose/features/flight/presentation/pages/flight_booking_screen.dart';
import 'package:yellow_rose/features/flight/presentation/pages/flight_order_modify_screen.dart';
import 'package:yellow_rose/features/flight/presentation/pages/flight_search_list.dart';
import 'package:yellow_rose/features/flight/presentation/pages/flight_search_screen.dart';
import 'package:yellow_rose/features/flight/presentation/pages/flight_ticket_screen.dart';
import 'package:yellow_rose/features/home_screen/presentation/pages/dashboard.dart';
import 'package:yellow_rose/features/hotel/data/models/details/hotel_detail_resonse.dart';
import 'package:yellow_rose/features/hotel/data/models/search/hotel_search_response.dart';
import 'package:yellow_rose/features/hotel/domain/entities/hotel_search.dart';
import 'package:yellow_rose/features/hotel/domain/entities/rooms/hotel_room.dart';
import 'package:yellow_rose/features/hotel/presentation/cubit/hotel_book_cubit/hotel_book_cubit.dart';
import 'package:yellow_rose/features/hotel/presentation/cubit/hotel_detail_cubit/hotel_detail_cubit_cubit.dart';
import 'package:yellow_rose/features/hotel/presentation/cubit/hotel_search_listing_cubit/hotel_search_listing_cubit.dart';
import 'package:yellow_rose/features/hotel/presentation/pages/hotel_book_form_screen.dart';
import 'package:yellow_rose/features/hotel/presentation/pages/hotel_detail_screen.dart';
import 'package:yellow_rose/features/hotel/presentation/pages/hotel_payment_screen.dart';
import 'package:yellow_rose/features/hotel/presentation/pages/hotel_search_list_scree.dart';
import 'package:yellow_rose/features/hotel/presentation/pages/hotel_search_screen.dart';
import 'package:yellow_rose/features/hotel/presentation/pages/hotel_booking_review_screen.dart';
import 'package:yellow_rose/features/bus/domain/entities/bus_search.dart';
import 'package:yellow_rose/features/bus/presentation/cubit/bus_search_listing/bus_search_listing_cubit.dart';
import 'package:yellow_rose/features/bus/presentation/cubit/bus_order_modify/bus_order_modify_cubit.dart';
import 'package:yellow_rose/features/bus/presentation/pages/bus_search_screen.dart';
import 'package:yellow_rose/features/bus/presentation/pages/bus_search_list_screen.dart';
import 'package:yellow_rose/features/bus/presentation/pages/bus_detail/bus_detail_screen.dart';
import 'package:yellow_rose/features/bus/presentation/pages/bus_book/bus_book_form_screen.dart';
import 'package:yellow_rose/features/bus/presentation/pages/bus_book/bus_booking_review_screen.dart';
import 'package:yellow_rose/features/bus/presentation/pages/bus_order_modify_screen.dart';
import 'package:yellow_rose/features/bus/data/models/search/bus_search_response.dart';
import 'package:yellow_rose/features/bus/data/models/bus_details/bus_detail_response.dart';
import 'package:yellow_rose/features/bus/data/models/bus_point.dart';
import 'package:yellow_rose/features/bus/presentation/cubit/bus_book/bus_book_cubit.dart';
import 'package:yellow_rose/features/bus/presentation/pages/bus_ticket_detail_screen.dart';
import 'package:yellow_rose/features/hotel/presentation/pages/hotel_booking_detail_screen.dart';
import 'package:yellow_rose/features/trip/presentation/cubit/trip_cubit.dart';
import 'package:yellow_rose/features/trip/presentation/pages/trip_home_screen.dart';
import 'package:yellow_rose/features/trip/presentation/pages/trip_detail_screen.dart';
import 'package:yellow_rose/features/trip/data/models/trip_response.dart';

String formatScreenName(String input) {
  return input.replaceAllMapped(RegExp(r'([a-z])([A-Z])'), (match) {
    return '${match.group(1)} ${match.group(2)}';
  });
}

class AppRouter {
  AppRouter._();

  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SignInScreen.routeName:
        return MaterialPageRoute(
          settings:
              RouteSettings(name: formatScreenName((SignInScreen).toString())),
          builder: (_) => SignInScreen(),
        );
      case Dashboard.routeName:
        return MaterialPageRoute(
          settings:
              RouteSettings(name: formatScreenName((Dashboard).toString())),
          builder: (_) => const Dashboard(),
        );
      case FlightSearchScreen.routeName:
        var args = settings.arguments as Map?;
        AirSearch? airSearch;
        if (args?['airSearch'] != null) {
          airSearch = args!["airSearch"] as AirSearch;
        }
        return MaterialPageRoute(
          settings: RouteSettings(
              name: formatScreenName((FlightSearchScreen).toString())),
          builder: (_) => FlightSearchScreen(
            airSearch: airSearch,
          ),
        );
      case FlightSearchListScreen.routeName:
        var args = settings.arguments as Map?;
        if (args?['airSearch'] != null) {
          var airSearch = args!["airSearch"] as AirSearch;

          return MaterialPageRoute(
            settings: RouteSettings(
                name: formatScreenName((FlightSearchListScreen).toString())),
            builder: (_) => BlocProvider(
              create: (context) =>
                  FlightSearchListingCubit(airSearch)..searchFlights(airSearch),
              child: const FlightSearchListScreen(),
            ),
          );
        }
      case FlightBookingScreen.routeName:
        var args = settings.arguments as Map?;
        if (args?['airSearch'] != null && args?['itineraries'] != null) {
          var airSearch = args!["airSearch"] as AirSearch;
          var itineraries = args["itineraries"] as List<AirResponseData>;
          var selectedfares =
              args["selectedFares"] as Map<int, FareDetailsWithType>?;
          return MaterialPageRoute(
            settings: RouteSettings(
                name: formatScreenName((FlightBookingScreen).toString())),
            builder: (_) => BlocProvider(
              create: (context) {
                var selectedTrip = context.read<TripCubit>().selectedTrip;
                return FlightBookingCubit()
                  ..repriceAndLoadData(itineraries, airSearch,
                      selectedFares: selectedfares, trip: selectedTrip);
              },
              child: FlightBookingScreen(
                airSearch: airSearch,
              ),
            ),
          );
        }
      case AirAddonSelectionScreen.routeName:
        var args = settings.arguments as Map?;
        if (args?['airSearch'] != null) {
          var airSearch = args!["airSearch"] as AirSearch;
          return MaterialPageRoute(
            settings: RouteSettings(
                name: formatScreenName((AirAddonSelectionScreen).toString())),
            builder: (ctx) => BlocProvider.value(
              value: (args["cubit"] as FlightBookingCubit)..loadSeatMapAndSsr(),
              child: AirAddonSelectionScreen(
                airSearch: airSearch,
              ),
            ),
          );
        }
      case BookingDetailedScreen.routeName:
        var args = settings.arguments as Map?;
        if (args?['bookingData'] != null &&
            args?['orderUpdateResponse'] != null) {
          var bookingData = args!["bookingData"] as FlightBookingLoaded;
          var orderUpdateResponse =
              args["orderUpdateResponse"] as UpdateOrderDetailResponse;
          return MaterialPageRoute(
            settings: RouteSettings(
                name: formatScreenName((BookingDetailedScreen).toString())),
            builder: (_) => BookingDetailedScreen(
              bookingData: bookingData,
              orderUpdateResponse: orderUpdateResponse,
            ),
          );
        }
      case FlightTicketScreen.routeName:
        var args = settings.arguments as Map?;
        if (args?['orderStatus'] != null) {
          var orderStatus = args!["orderStatus"] as OrderStatus;
          return MaterialPageRoute(
            settings: RouteSettings(
                name: formatScreenName((FlightTicketScreen).toString())),
            builder: (_) => FlightTicketScreen(orderStatus: orderStatus),
          );
        }
      case FlightOrderModifyScreen.routeName:
        var args = settings.arguments as Map?;
        if (args?['airOrderItinerary'] != null) {
          var airOrderItinerary =
              args!["airOrderItinerary"] as AirOrderItinerary;
          var orderId = args["orderId"] as String;
          var orderStatus = args["orderStatus"] as OrderStatus;
          return MaterialPageRoute(
            settings: RouteSettings(
                name: formatScreenName((FlightOrderModifyScreen).toString())),
            builder: (_) => BlocProvider(
              create: (context) => FlightOrderModifyCubit(
                  airOrderItinerary: airOrderItinerary,
                  orderStatus: orderStatus,
                  orderId: orderId),
              child: FlightOrderModifyScreen(
                airOrderItinerary: airOrderItinerary,
                orderStatus: orderStatus,
              ),
            ),
          );
        }

      case BusOrderModifyScreen.routeName:
        var args = settings.arguments as Map?;
        if (args?['busOrderItinerary'] != null) {
          var busOrderItinerary =
              args!["busOrderItinerary"] as BusOrderItinerary;
          var orderId = args["orderId"] as String;
          var orderStatus = args["orderStatus"] as OrderStatus;
          return MaterialPageRoute(
            settings: RouteSettings(
                name: formatScreenName((BusOrderModifyScreen).toString())),
            builder: (_) => BlocProvider(
              create: (context) => BusOrderModifyCubit(
                  busOrderItinerary: busOrderItinerary,
                  orderStatus: orderStatus,
                  orderId: orderId),
              child: BusOrderModifyScreen(
                busOrderItinerary: busOrderItinerary,
                orderStatus: orderStatus,
              ),
            ),
          );
        }

      // Hotels

      case HotelSearchScreen.routeName:
        var args = settings.arguments as Map?;
        HotelSearch? hotelSearch;
        if (args?['hotelSearch'] != null) {
          hotelSearch = args!["hotelSearch"] as HotelSearch;
        }
        return MaterialPageRoute(
          settings: RouteSettings(
              name: formatScreenName((FlightSearchScreen).toString())),
          builder: (_) => HotelSearchScreen(
            hotelSeatch: hotelSearch,
          ),
        );
      case HotelSearchListScreen.routeName:
        var args = settings.arguments as Map?;
        if (args?['hotelSearch'] != null) {
          var airSearch = args!["hotelSearch"] as HotelSearch;

          return MaterialPageRoute(
            settings: RouteSettings(
                name: formatScreenName((HotelSearchListScreen).toString())),
            builder: (_) => BlocProvider(
              create: (context) =>
                  HotelSearchListingCubit(airSearch)..searchHotels(airSearch),
              child: const HotelSearchListScreen(),
            ),
          );
        }
      case HotelDetailScreen.routeName:
        var args = settings.arguments as Map?;
        if (args?['hotelSearch'] != null) {
          var hotelSearch = args!["hotelSearch"] as HotelSearch;
          var hotelSearchResponse =
              args["hotelSearchResponse"] as HotelSearchResponse;

          return MaterialPageRoute(
            settings: RouteSettings(
                name: formatScreenName((HotelSearchListScreen).toString())),
            builder: (_) => BlocProvider(
              create: (context) => HotelDetailCubitCubit()
                ..loadInitial(hotelSearch, hotelSearchResponse),
              child: HotelDetailScreen(
                hotelSearch: hotelSearch,
                hotelSearchResponse: hotelSearchResponse,
              ),
            ),
          );
        }
      case HotelBookFormScreen.routeName:
        var args = settings.arguments as Map?;
        if (args?['hotelSearch'] != null && args?['hotelDetail'] != null) {
          var hotelSearch = args!["hotelSearch"] as HotelSearch;
          var hotelDetailResponse = args["hotelDetail"] as HotelDetailResponse;
          var selectedRoom = args["selectedRoom"] as HotelRoom;

          return MaterialPageRoute(
            settings: RouteSettings(
                name: formatScreenName((HotelBookFormScreen).toString())),
            builder: (_) => BlocProvider(
              create: (context) {
                var selectedTrip = context.read<TripCubit>().selectedTrip;
                return HotelBookCubit()
                  ..createOrderAndUpdate(
                      hotelDetailResponse, selectedRoom, hotelSearch,
                      trip: selectedTrip);
              },
              child: HotelBookFormScreen(
                hotelSearch: hotelSearch,
                hotelDetailResponse: hotelDetailResponse,
              ),
            ),
          );
        }
      case HotelBookingReviewScreen.routeName:
        // Review screen expects HotelBookCubit to already be available in the widget tree.
        var args = settings.arguments as Map?;
        if (args?["cubit"] == null) break;
        return MaterialPageRoute(
          settings: RouteSettings(
              name: formatScreenName((HotelBookingReviewScreen).toString())),
          builder: (_) => BlocProvider.value(
            value: (args!["cubit"] as HotelBookCubit),
            child: const HotelBookingReviewScreen(),
          ),
        );
      case HotelPaymentScreen.routeName:
        var args = settings.arguments as Map?;
        if (args?["cubit"] == null) break;
        return MaterialPageRoute(
          settings: RouteSettings(
              name: formatScreenName((HotelPaymentScreen).toString())),
          builder: (context) => BlocProvider.value(
            value: (args!["cubit"] as HotelBookCubit),
            child: HotelPaymentScreen(
                orderUpdateResponse:
                    ((args["cubit"] as HotelBookCubit).state as HotelBookLoaded)
                        .updateOrderDetailResponse!),
          ),
        );

      case HotelBookingDetailScreen.routeName:
        var args = settings.arguments as Map?;
        if (args?['orderStatus'] != null) {
          final orderStatus = args!['orderStatus'] as OrderStatus;
          return MaterialPageRoute(
            settings: RouteSettings(
                name: formatScreenName((HotelBookingDetailScreen).toString())),
            builder: (_) => HotelBookingDetailScreen(orderStatus: orderStatus),
          );
        }
        break;

      // Buses

      case BusSearchScreen.routeName:
        return MaterialPageRoute(
          settings: RouteSettings(
              name: formatScreenName((BusSearchScreen).toString())),
          builder: (_) => const BusSearchScreen(),
        );
      case BusSearchListScreen.routeName:
        var args = settings.arguments as Map?;
        if (args?['busSearch'] != null) {
          var busSearch = args!["busSearch"] as BusSearch;

          return MaterialPageRoute(
            settings: RouteSettings(
                name: formatScreenName((BusSearchListScreen).toString())),
            builder: (_) => BlocProvider(
              create: (context) =>
                  BusSearchListingCubit(busSearch)..searchBuses(busSearch),
              child: const BusSearchListScreen(),
            ),
          );
        }
      case BusDetailScreen.routeName:
        var args = settings.arguments as Map?;
        if (args?['busSearchResponse'] != null && args?['busSearch'] != null) {
          var busSearchResponse =
              args!["busSearchResponse"] as BusSearchResponse;
          var busSearch = args["busSearch"] as BusSearch;

          return MaterialPageRoute(
            settings: RouteSettings(
                name: formatScreenName((BusDetailScreen).toString())),
            builder: (_) => BusDetailScreen(
                busSearchResponse: busSearchResponse, busSearch: busSearch),
          );
        }
      case BusBookFormScreen.routeName:
        var args = settings.arguments as Map?;
        if (args?['busSearchResponse'] != null &&
            args?['busSearch'] != null &&
            args?['busDetailResponse'] != null &&
            args?['selectedSeats'] != null &&
            args?['selectedBoardingPoint'] != null &&
            args?['selectedDroppingPoint'] != null) {
          var busSearchResponse =
              args!["busSearchResponse"] as BusSearchResponse;
          var busSearch = args["busSearch"] as BusSearch;
          var busDetailResponse =
              args["busDetailResponse"] as BusDetailResponse;
          var selectedSeats = args["selectedSeats"] as Set<String>;
          var selectedBoardingPoint = args["selectedBoardingPoint"] as BusPoint;
          var selectedDroppingPoint = args["selectedDroppingPoint"] as BusPoint;

          return MaterialPageRoute(
            settings: RouteSettings(
                name: formatScreenName((BusBookFormScreen).toString())),
            builder: (_) => BlocProvider(
              create: (context) => BusBookCubit()
                ..createOrderAndUpdate(
                  busSearch,
                  busDetailResponse,
                  busSearchResponse,
                  selectedSeats,
                  selectedBoardingPoint,
                  selectedDroppingPoint,
                ),
              child: BusBookFormScreen(
                busSearchResponse: busSearchResponse,
              ),
            ),
          );
        }
      case BusBookingReviewScreen.routeName:
        var args = settings.arguments as Map?;
        if (args?["cubit"] == null) break;

        return MaterialPageRoute(
          settings: RouteSettings(
              name: formatScreenName((BusBookingReviewScreen).toString())),
          builder: (_) => BlocProvider.value(
            value: args!["cubit"] as BusBookCubit,
            child: BusBookingReviewScreen(
                busBlockResponse:
                    args["blockResponse"] as BusBlockTicketResponse),
          ),
        );

      case BusTicketDetailScreen.routeName:
        var args = settings.arguments as Map?;
        if (args?['orderStatus'] != null) {
          final orderStatus = args!['orderStatus'] as OrderStatus;
          return MaterialPageRoute(
            settings: RouteSettings(
                name: formatScreenName((BusTicketDetailScreen).toString())),
            builder: (_) => BusTicketDetailScreen(orderStatus: orderStatus),
          );
        }
        break;

      case TripHomeScreen.routeName:
        return MaterialPageRoute(
          settings: RouteSettings(
              name: formatScreenName((TripHomeScreen).toString())),
          builder: (_) => const TripHomeScreen(),
        );

      case TripDetailScreen.routeName:
        var args = settings.arguments as Map?;
        if (args?['trip'] != null) {
          final trip = args!['trip'] as TripResponse;
          return MaterialPageRoute(
            settings: RouteSettings(
                name: formatScreenName((TripDetailScreen).toString())),
            builder: (_) => TripDetailScreen(trip: trip),
          );
        }
        break;

      default:
    }
    return null;
  }
}
