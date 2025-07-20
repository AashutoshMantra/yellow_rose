import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yellow_rose/core/common_widgets/custom_text_form_field.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/dependncy_injection.dart';
import 'package:yellow_rose/features/flight/data/models/airports.dart';
import 'package:yellow_rose/features/flight/domain/usecases/air_usecase.dart';
import 'package:yellow_rose/features/flight/presentation/cubit/flight_search_cubit.dart';

class AirportSearchScreen extends StatelessWidget {
  final Function(Airport) onClick;
  const AirportSearchScreen({super.key, required this.onClick});
List<Airport> filterAndSortAirports(List<Airport> airports, String searchQuery) {
  searchQuery = searchQuery.toLowerCase(); // Normalize search input

  return airports
      .where((airport) =>
          airport.iataCode!.toLowerCase().contains(searchQuery) ||
          airport.name!.toLowerCase().contains(searchQuery) ||
          airport.city!.toLowerCase().contains(searchQuery))
      .toList()
      ..sort((a, b) {
        // Convert values to lowercase for case-insensitive comparison
        String aCode = a.iataCode!.toLowerCase();
        String bCode = b.iataCode!.toLowerCase();
        String aName = a.name!.toLowerCase();
        String bName = b.name!.toLowerCase();
        String aCity = a.city!.toLowerCase();
        String bCity = b.city!.toLowerCase();

        // Exact IATA code match comes first
        if (aCode == searchQuery) return -1;
        if (bCode == searchQuery) return 1;

        // Exact city match comes next
        if (aCity == searchQuery) return -1;
        if (bCity == searchQuery) return 1;

        // Exact airport name match
        if (aName == searchQuery) return -1;
        if (bName == searchQuery) return 1;

        // If both start with query, sort alphabetically
        bool aStarts = aCode.startsWith(searchQuery) || aName.startsWith(searchQuery) || aCity.startsWith(searchQuery);
        bool bStarts = bCode.startsWith(searchQuery) || bName.startsWith(searchQuery) || bCity.startsWith(searchQuery);

        if (aStarts && !bStarts) return -1;
        if (!aStarts && bStarts) return 1;

        // Default sorting: Alphabetical order of city name
        return aCity.compareTo(bCity);
      });
}
  @override
  Widget build(BuildContext context) {
    final airUseCase = getIt<AirUseCase>();
    var filterValueString = ValueNotifier("");

    return SizedBox(
      height: MediaQuery.of(context).size.height * .85,
      child: Padding(
        padding: EdgeInsets.all(24.h),
        child: Column(
          children: [
            CustomTextFormField(
              icon: Icons.search,
              suffixicon: GestureDetector(
                onTap: (){
                   Navigator.of(context).pop();
                },
                child: const Icon(Icons.close)
                ),
              onchange: (value){
                filterValueString.value=value??"";
              },
              text: "Enter city",
            ),
            Expanded(
              child: FutureBuilder<List<Airport>>(
                  future: airUseCase.getAirports(),
                  builder: (ctx, snapshot) {
                    if (!snapshot.hasError) {
                      List<Airport> data = List.empty();
                      if (snapshot.connectionState == ConnectionState.done) {
                        data = snapshot.data ?? List.empty();
                      }

                      return ValueListenableBuilder<String>(
                          valueListenable: filterValueString,
                          builder: (context, filteredString, _) {
                            var searchQuery = filteredString.toLowerCase();
                            var filteredData =data;
                            if(searchQuery.isNotEmpty){
                             filteredData = filterAndSortAirports(data,searchQuery);
                            }
                            return ListView.builder(
                                itemCount: filteredData.length,
                                itemBuilder: (ctx, idx) {
                                  var airport = filteredData[idx];
                                  return GestureDetector(
                                    onTap:()=>onClick(airport),
                                    child: Container(
                                      margin: EdgeInsets.symmetric(vertical: 6.h),
                                      height: 45.h,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Flexible(
                                              child: Text(
                                            ("${airport.city ?? ""}, ${airport.country ?? ""}"),
                                            style: TextStyles.bodyMediumStyle(),
                                          )),
                                          Flexible(
                                              child: Text(
                                                  "${airport.iataCode ?? ""} - ${airport.name ?? ""}",
                                                  style:
                                                      TextStyles.bodyMediumStyle()
                                                          .copyWith(
                                                    color: AppColors
                                                        .primaryTextSwatch[500],
                                                  ))),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          });
                    }
                    return const Text("Something Went Wrong");
                  }),
            )
          ],
        ),
      ),
    );
  }
}
