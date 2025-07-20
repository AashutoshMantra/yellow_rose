import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/WidgetUtils.dart';
import 'package:yellow_rose/core/utils/extensions.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/flight/domain/entities/passenger_details_entity.dart';
import 'package:yellow_rose/features/flight/domain/entities/passenger_type.dart';
import 'package:yellow_rose/features/flight/presentation/pages/add_update_passenger_details_screen.dart';

class TravelerDetailsWidget extends StatelessWidget {
  final int maxAdult;
  final int maxChild;
  final int maxInfant;
  final List<PassengerDetailsEntity> passengerDetails;
  Map<PassengerType, List<PassengerDetailsEntity>> passengerTypeGrouped;
  final Function(PassengerDetailsEntity passenger) onAddUpdate;
  TravelerDetailsWidget(
      {super.key,
      required this.maxAdult,
      this.maxChild = 0,
      this.maxInfant = 0,
      required this.passengerDetails,
      required this.onAddUpdate})
      : passengerTypeGrouped =
            passengerDetails.groupListsBy((d) => d.passengerType);

  int getMaxCount(PassengerType passengerType) {
    if (passengerType.isAdult()) {
      return maxAdult;
    }
    if (passengerType.isChild()) {
      return maxChild;
    }
    return maxInfant;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.primarySwatch[200]!,
          ),
          borderRadius: BorderRadius.circular(10),
          color: AppColors.primaryTextSwatch[50]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Traveller Details",
            style: TextStyles.h6Style().copyWith(color: AppColors.primary),
          ),
          Builder(builder: (ctx) {
            return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: PassengerType.values.length,
                itemBuilder: (ctx, idx) {
                  var passengerDetails =
                      passengerTypeGrouped[PassengerType.values[idx]];
                  if (getMaxCount(PassengerType.values[idx]) > 0) {
                    return TravelerDetailWidget(
                        maxCount: getMaxCount(PassengerType.values[idx]),
                        passengerType: PassengerType.values[idx],
                        passengerDetails: passengerDetails ?? [],
                        onAddUpdate: (PassengerDetailsEntity passenger) {
                          onAddUpdate(passenger);
                        });
                  }
                  return const SizedBox();
                });
          })
        ],
      ),
    );
  }
}

class TravelerDetailWidget extends StatelessWidget {
  final int maxCount;
  final List<PassengerDetailsEntity> passengerDetails;
  final PassengerType passengerType;
  final Function(PassengerDetailsEntity passenger) onAddUpdate;

  const TravelerDetailWidget({
    super.key,
    required this.maxCount,
    required this.passengerDetails,
    required this.passengerType,
    required this.onAddUpdate,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            leading: const Icon(
              Icons.account_circle,
              color: AppColors.primaryGreen,
            ),
            title: Text(
              "${passengerType.description.toTitleCase()} (${passengerType.ageString})",
              style: TextStyles.bodyLargeSemiBoldStyle(),
            ),
            trailing: Text("${passengerDetails.length}/$maxCount added",
                style: TextStyles.bodySmallSemiBoldStyle()
                    .copyWith(color: AppColors.primaryTextSwatch[500])),
          ),
          ...passengerDetails.map((passenger) {
            return Container(
              padding: EdgeInsets.all(5.h),
              margin: EdgeInsets.only(bottom: 8.h),
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.primary,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "${passenger.title.name} ${passenger.name} ${passenger.lastName}",
                      style: TextStyles.bodySmallSemiBoldStyle()
                          .copyWith(color: AppColors.primary),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () async {
                      var updatedPasenger = await WidgetUtil.showBottomSheet(
                          context,
                          AddUpdatePassengerDetailsScreen(
                            passengerDetailsEntity: passenger,
                            passengerType: passenger.passengerType,
                          ));
                      onAddUpdate(updatedPasenger ?? passenger);
                    },
                    icon: const Icon(Icons.edit),
                    color: AppColors.primaryGreen,
                  )
                ],
              ),
            );
          }),
          SizedBox(height: 8.h),
          OutlinedButton.icon(
            onPressed: passengerDetails.length == maxCount
                ? null
                : () async {
                    var addedPassenger = await WidgetUtil.showBottomSheet(
                        context,
                        AddUpdatePassengerDetailsScreen(
                            passengerType: passengerType));
                    if (addedPassenger != null) {
                      onAddUpdate(addedPassenger);
                    }
                  },
            icon: const Icon(Icons.add),
            label: Text("ADD NEW ${passengerType.description}"),
            style: ButtonStyle(
              elevation: WidgetStateProperty.all(100),
              shape: WidgetStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5))),
            ),
          )
        ],
      ),
    );
  }
}
