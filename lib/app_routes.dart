import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yellow_rose/features/auth/presentation/pages/sign_in_screen.dart';
import 'package:yellow_rose/features/flight/data/models/airsearch/air_response_data.dart';
import 'package:yellow_rose/features/flight/data/models/airsearch/fare_details_with_type.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/update_order_detail_response.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order_status/air_order_iitinerary.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order_status/order_status.dart';
import 'package:yellow_rose/features/flight/domain/entities/flight_recent_search.dart';
import 'package:yellow_rose/features/flight/presentation/cubit/flight_booking/flight_booking_cubit.dart';
import 'package:yellow_rose/features/flight/presentation/cubit/flight_order_modify/flight_order_modify_cubit.dart';
import 'package:yellow_rose/features/flight/presentation/cubit/flight_search_cubit.dart';
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
              create: (context) => FlightBookingCubit()
                ..repriceAndLoadData(itineraries, airSearch,
                    selectedFares: selectedfares),
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
              create: (context) => HotelBookCubit()
                ..createOrderAndUpdate(
                    hotelDetailResponse, selectedRoom, hotelSearch),
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

      default:
    }
    return null;
  }
}
