import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yellow_rose/features/auth/presentation/pages/sign_in_screen.dart';
import 'package:yellow_rose/features/flight/data/models/airsearch/air_response_data.dart';
import 'package:yellow_rose/features/flight/data/models/airsearch/fare_details_with_type.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/update_order_detail_response.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order_status/order_status.dart';
import 'package:yellow_rose/features/flight/domain/entities/flight_recent_search.dart';
import 'package:yellow_rose/features/flight/presentation/cubit/flight_booking/flight_booking_cubit.dart';
import 'package:yellow_rose/features/flight/presentation/cubit/flight_search_cubit.dart';
import 'package:yellow_rose/features/flight/presentation/cubit/flight_search_listing_cubit/flight_search_listing_cubit.dart';
import 'package:yellow_rose/features/flight/presentation/pages/air_addond_selection_screen.dart';
import 'package:yellow_rose/features/flight/presentation/pages/booking_detailed_screen.dart';
import 'package:yellow_rose/features/flight/presentation/pages/flight_booking_screen.dart';
import 'package:yellow_rose/features/flight/presentation/pages/flight_search_list.dart';
import 'package:yellow_rose/features/flight/presentation/pages/flight_search_screen.dart';
import 'package:yellow_rose/features/flight/presentation/pages/flight_ticket_screen.dart';
import 'package:yellow_rose/features/home_screen/presentation/pages/dashboard.dart';

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

      default:
    }
    return null;
  }
}
