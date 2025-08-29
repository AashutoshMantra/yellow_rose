import 'package:flutter/material.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';

class IncrementBoxWidget extends StatefulWidget {
  final int initialValue;
  final Function(int)? onValueChange;
  final int? maxValue;
  final int minValue;
  const IncrementBoxWidget(
      {super.key,
      this.initialValue = 0,
      this.onValueChange,
      this.maxValue,
      this.minValue = 0});

  @override
  State<IncrementBoxWidget> createState() => _IncrementBoxWidgetState();
}

class _IncrementBoxWidgetState extends State<IncrementBoxWidget> {
  int _value = 0;
  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: IconButton(
              icon: const Icon(
                Icons.remove_circle_outline,
              ),
              onPressed: _value > widget.minValue
                  ? () {
                      if (_value > widget.minValue) {
                        setState(() {
                          _value--;
                        });
                        if (widget.onValueChange != null) {
                          widget.onValueChange!(_value);
                        }
                      }
                    }
                  : null,
            ),
          ),
          // SizedBox(
          //   width: 6.w,
          // ),
          Flexible(
              child:
                  Text("$_value", style: TextStyles.bodyMediumSemiBoldStyle())),
          // SizedBox(
          //   width: 6.w,
          // ),
          Flexible(
            child: IconButton(
              icon: const Icon(Icons.add_circle_outline),
              onPressed: (widget.maxValue == null || _value < widget.maxValue!)
                  ? () {
                      if (widget.maxValue == null ||
                          _value < widget.maxValue!) {
                        setState(() {
                          _value++;
                        });
                        if (widget.onValueChange != null) {
                          widget.onValueChange!(_value);
                        }
                      }
                    }
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
