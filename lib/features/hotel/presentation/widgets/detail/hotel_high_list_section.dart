import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';

class PropertyHighlightsSection extends StatelessWidget {
  final String title;
  final String htmlContent;

  const PropertyHighlightsSection({
    super.key,
    required this.htmlContent,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: AppColors.primarySwatch[300]!,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyles.h6Style(),
          ),
          const SizedBox(height: 8),
          Stack(
            children: [
              SizedBox(
                height: 150,
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Html(
                    data: htmlContent,
                    style: {
                      'body': Style(
                        margin: Margins.zero,
                        padding: HtmlPaddings.zero,
                        fontSize: FontSize.medium,
                        color: Colors.black87,
                      ),
                      'p': Style(margin: Margins.only(bottom: 8)),
                      'strong': Style(fontWeight: FontWeight.bold),
                    },
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: IgnorePointer(
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white.withOpacity(0),
                          Colors.white,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 8,
                right: 0,
                child: TextButton.icon(
                  style: TextButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    backgroundColor: Colors.grey.shade200,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      builder: (_) {
                        return PropertyHighlightBottomSheet(
                          htmlContent: htmlContent,
                          title: title,
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.expand_more),
                  label: const Text("View more"),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class PropertyHighlightBottomSheet extends StatelessWidget {
  final String title;

  final String htmlContent;

  const PropertyHighlightBottomSheet(
      {super.key, required this.htmlContent, required this.title});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.8,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      expand: false,
      builder: (_, controller) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyles.h6Style(),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child: SingleChildScrollView(
                  controller: controller,
                  child: Html(data: htmlContent),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
