import 'package:flutter/material.dart';
import 'package:yellow_rose/core/common_widgets/custom_text_form_field.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/dependncy_injection.dart';
import 'package:yellow_rose/features/bus/data/models/search/bus_city_response.dart';
import 'package:yellow_rose/features/bus/domain/usecases/bus_usecase.dart';

class BusCitySearchScreen extends StatelessWidget {
  final Function(BusCityResponse) onClick;
  const BusCitySearchScreen({super.key, required this.onClick});

  List<BusCityResponse> filterAndSortCities(
      List<BusCityResponse> cities, String searchQuery) {
    searchQuery = searchQuery.toLowerCase(); // Normalize search input

    return cities
        .where((city) =>
            city.cityName?.toLowerCase().contains(searchQuery) == true ||
            city.cityLabel?.toLowerCase().contains(searchQuery) == true)
        .toList()
      ..sort((a, b) {
        // Convert values to lowercase for case-insensitive comparison
        String aName = a.cityName?.toLowerCase() ?? '';
        String bName = b.cityName?.toLowerCase() ?? '';
        String aLabel = a.cityLabel?.toLowerCase() ?? '';
        String bLabel = b.cityLabel?.toLowerCase() ?? '';

        // Exact city name match comes first
        if (aName == searchQuery) return -1;
        if (bName == searchQuery) return 1;

        // Exact city label match comes next
        if (aLabel == searchQuery) return -1;
        if (bLabel == searchQuery) return 1;

        // If both start with query, sort alphabetically
        bool aStarts =
            aName.startsWith(searchQuery) || aLabel.startsWith(searchQuery);
        bool bStarts =
            bName.startsWith(searchQuery) || bLabel.startsWith(searchQuery);

        if (aStarts && !bStarts) return -1;
        if (!aStarts && bStarts) return 1;

        // Default sorting: Alphabetical order of city name
        return aName.compareTo(bName);
      });
  }

  @override
  Widget build(BuildContext context) {
    final busUseCase = getIt<BusUseCase>();
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
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(Icons.close),
              ),
              onchange: (value) {
                filterValueString.value = value ?? "";
              },
              text: "Enter city",
            ),
            Expanded(
              child: FutureBuilder<List<BusCityResponse>>(
                  future: busUseCase.getBusCities(),
                  builder: (ctx, snapshot) {
                    if (!snapshot.hasError) {
                      List<BusCityResponse> data = List.empty();
                      if (snapshot.connectionState == ConnectionState.done) {
                        data = snapshot.data ?? List.empty();
                      }

                      return ValueListenableBuilder<String>(
                          valueListenable: filterValueString,
                          builder: (context, filteredString, _) {
                            var searchQuery = filteredString.toLowerCase();
                            var filteredData = data;
                            if (searchQuery.isNotEmpty) {
                              filteredData =
                                  filterAndSortCities(data, searchQuery);
                            }
                            return ListView.builder(
                                itemCount: filteredData.length,
                                itemBuilder: (ctx, idx) {
                                  var city = filteredData[idx];
                                  return GestureDetector(
                                    onTap: () => onClick(city),
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 6.h),
                                      height: 45.h,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Flexible(
                                              child: Text(
                                            city.cityName ?? "",
                                            style: TextStyles.bodyMediumStyle(),
                                          )),
                                          Flexible(
                                              child: Text(city.cityLabel ?? "",
                                                  style: TextStyles
                                                          .bodyMediumStyle()
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
