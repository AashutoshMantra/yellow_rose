import 'package:flutter/material.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';

/// Which visual style the popup button should use.
enum PopupButtonType { primary, secondary, text }

/// Button descriptor used by PopupDialog.
class PopupButton {
  final String text;
  final VoidCallback? onPressed;
  final PopupButtonType type;
  final TextStyle? textStyle;
  final bool autoClose;

  const PopupButton({
    required this.text,
    this.onPressed,
    this.type = PopupButtonType.primary,
    this.textStyle,
    this.autoClose = true,
  });
}

/// Reusable PopupDialog widget. Keep this lightweight: it renders icon/title/message/content
/// and a flexible button area. You can pass custom [content] if you need a complex body.
class PopupDialog extends StatelessWidget {
  final Widget? leading;
  final String? title;
  final String? message;
  final Widget? content;
  final List<PopupButton> buttons;
  final bool showCloseIcon;
  final double borderRadius;
  final Color backgroundColor;
  final TextStyle? titleTextStyle;
  final TextStyle? messageTextStyle;

  const PopupDialog({
    super.key,
    this.leading,
    this.title,
    this.message,
    this.content,
    this.buttons = const [],
    this.showCloseIcon = true,
    this.borderRadius = 15.0,
    this.backgroundColor = Colors.white,
    this.titleTextStyle,
    this.messageTextStyle,
  });

  Widget _buildButton(BuildContext context, PopupButton b) {
    final onPressed = b.onPressed == null
        ? null
        : () {
            if (b.autoClose) {
              Navigator.of(context).pop();
              // give the pop a microtask gap so caller runs after pop
              Future.microtask(() => b.onPressed?.call());
            } else {
              b.onPressed?.call();
            }
          };

    final child = Text(
      b.text,
      style: b.textStyle ??
          TextStyles.bodyMediumBoldStyle().copyWith(
              color: b.type == PopupButtonType.primary ? Colors.white : null),
    );

    switch (b.type) {
      case PopupButtonType.primary:
        return ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            textStyle: b.textStyle,
            backgroundColor: AppColors.primary,
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
          child: child,
        );
      case PopupButtonType.secondary:
        return OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: AppColors.primarySwatch[800]!),
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
          child: child,
        );
      case PopupButtonType.text:
      default:
        return TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14)),
          child: child,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    // safe fallbacks to app text styles
    final resolvedTitleStyle =
        titleTextStyle ?? TextStyles.bodyMediumBoldStyle();
    final resolvedMessageStyle =
        messageTextStyle ?? TextStyles.bodySmallSemiBoldStyle();

    final effectiveButtons = buttons.isEmpty
        ? [
            PopupButton(
              text: 'OK',
              type: PopupButtonType.primary,
              onPressed: () => Navigator.of(context).pop(),
            )
          ]
        : buttons;

    final bool horizontalButtons = effectiveButtons.length <= 2;

    // limit maximum width on wide screens
    final double maxWidth = MediaQuery.of(context).size.width * 0.9;
    final double dialogWidth = maxWidth > 420 ? 420 : maxWidth;

    return Center(
      child: Material(
        color: Colors.transparent,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: dialogWidth),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: Container(
              color: backgroundColor,
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // close icon row
                  if (showCloseIcon)
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: Icon(
                          Icons.highlight_off,
                          size: 30.h,
                        ),
                        splashRadius: 20,
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),

                  // icon / image
                  if (leading != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Center(child: leading),
                    ),

                  // title
                  if (title != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(title!,
                          style: resolvedTitleStyle,
                          textAlign: TextAlign.center),
                    ),

                  // message
                  if (message != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(message!,
                          style: resolvedMessageStyle,
                          textAlign: TextAlign.center),
                    ),

                  // custom content
                  if (content != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: content!,
                    ),

                  const SizedBox(height: 8),

                  // buttons
                  horizontalButtons
                      ? Row(
                          children: effectiveButtons
                              .map(
                                (b) => Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6),
                                    child: _buildButton(context, b),
                                  ),
                                ),
                              )
                              .toList(),
                        )
                      : Column(
                          children: effectiveButtons
                              .map(
                                (b) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 6),
                                  child: _buildButton(context, b),
                                ),
                              )
                              .toList(),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
