import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:yellow_rose/core/common_widgets/custom_text_form_field.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/dependncy_injection.dart';
import 'package:yellow_rose/features/hotel/data/models/places/places.dart';
import 'package:yellow_rose/features/hotel/domain/usecases/hotel_search_case.dart';

class PlaceSearchBottomSheet extends StatefulWidget {
  final Function(PlaceEntity place)? onClick;
  final Function(String error)? onError;

  const PlaceSearchBottomSheet({
    super.key,
    this.onClick,
    this.onError,
  });

  @override
  State<PlaceSearchBottomSheet> createState() => _PlaceSearchBottomSheetState();
}

class _PlaceSearchBottomSheetState extends State<PlaceSearchBottomSheet> {
  final TextEditingController _controller = TextEditingController();
  final ValueNotifier<List<Prediction>> _results = ValueNotifier([]);
  final ValueNotifier<bool> _isLoading = ValueNotifier(false);
  Timer? _debounce;

  final HotelSearchCase _placeUseCase = getIt<HotelSearchCase>();

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 300), () async {
      if (query.trim().isEmpty) {
        _results.value = [];
        return;
      }
      _isLoading.value = true;
      try {
        final result =
            (await _placeUseCase.getPlaceSuggestions(query)).predictions;
        if (mounted) {
          _results.value = result;
        }
      } catch (e, s) {
        log("$e $s");
        _results.value = [];
      }
      if (mounted) {
        _isLoading.value = false;
      }
    });
  }

  Future<void> _onItemClicked(Prediction suggestion) async {
    _isLoading.value = true;

    try {
      final result = await _placeUseCase.getPlaceDetails(suggestion.placeId!);
      widget.onClick?.call(result!);
    } catch (e) {
      widget.onError?.call(e.toString());
    }

    _isLoading.value = false;
  }

  @override
  void dispose() {
    _controller.dispose();
    _debounce?.cancel();
    _results.dispose();
    _isLoading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .85,
      child: Padding(
        padding: EdgeInsets.all(24.h),
        child: Column(
          children: [
            CustomTextFormField(
              cont: _controller,
              icon: Icons.search,
              suffixicon: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: const Icon(Icons.close),
              ),
              onchange: (str) => _onSearchChanged(str ?? ''),
              text: "Search places",
            ),
            ValueListenableBuilder<bool>(
              valueListenable: _isLoading,
              builder: (_, loading, __) => loading
                  ? const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: LinearProgressIndicator(),
                    )
                  : const SizedBox.shrink(),
            ),
            Expanded(
              child: ValueListenableBuilder<List<Prediction>>(
                valueListenable: _results,
                builder: (_, suggestions, __) {
                  return ListView.builder(
                    itemCount: suggestions.length,
                    itemBuilder: (ctx, idx) {
                      final place = suggestions[idx];
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => _onItemClicked(place),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 6.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                place.description ?? "",
                                style: TextStyles.bodyMediumStyle(),
                              ),
                              Text(
                                place.structuredFormatting?.secondaryText ?? "",
                                style: TextStyles.bodyMediumStyle().copyWith(
                                  color: AppColors.primaryTextSwatch[500],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
