import 'package:flutter/material.dart';

import 'dart:math';
import 'package:flutter/material.dart';

/// Robust CustomDropdown:
/// - Uses CompositedTransformTarget/Follower so overlay follows trigger.
/// - Recreates overlay when parent updates, when scrolling, or when window metrics change.
/// - Transparent barrier to close on outside-tap.
/// - Scrollable menu constrained by maxHeight.
class CustomOverlayDropdown extends StatefulWidget {
  final Widget title; // trigger widget shown when closed
  final List<Widget> items; // items shown inside the dropdown
  final double maxHeight; // max height before scrolling kicks in
  final double verticalGap; // small gap between trigger and menu

  const CustomOverlayDropdown({
    super.key,
    required this.title,
    required this.items,
    this.maxHeight = 300,
    this.verticalGap = 6.0,
  });

  @override
  State<CustomOverlayDropdown> createState() => _CustomOverlayDropdownState();
}

class _CustomOverlayDropdownState extends State<CustomOverlayDropdown>
    with WidgetsBindingObserver {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _entry;
  bool _isOpen = false;

  // optional: listen to nearest Scrollable position so we can recreate overlay on scroll.
  ScrollPosition? _scrollPosition;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didUpdateWidget(covariant CustomOverlayDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If parent changed items/title while dropdown open, recreate overlay so it uses latest widgets.
    if (_isOpen) _recreateOverlay();
  }

  @override
  void didChangeMetrics() {
    // keyboard / viewport metric changes (e.g. keyboard show/hide) -> reposition overlay
    if (_isOpen) _recreateOverlay();
  }

  void _toggleDropdown() {
    if (_isOpen) {
      _removeOverlay();
    } else {
      _createOverlay();
    }
  }

  void _createOverlay() {
    // find trigger size/position
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Size triggerSize = renderBox.size;
    final Offset triggerOffset = renderBox.localToGlobal(Offset.zero);

    final media = MediaQuery.of(context);
    final screenSize = media.size;
    final bottomInset = media.viewInsets.bottom; // keyboard height if any

    // available space calculation
    final double availableBelow = screenSize.height -
        (triggerOffset.dy + triggerSize.height) -
        widget.verticalGap -
        bottomInset;
    final double availableAbove =
        triggerOffset.dy - widget.verticalGap - media.viewPadding.top;

    // prefer showing below unless not enough space
    final bool showBelow =
        availableBelow >= min(availableAbove, widget.maxHeight) ||
            availableBelow >= 160;

    final double menuMaxHeight = (showBelow ? availableBelow : availableAbove)
        .clamp(80.0, widget.maxHeight);

    // compute offset for CompositedTransformFollower:
    // when below: offset down by trigger height + gap; when above: negative offset to place above.
    final Offset followerOffset = showBelow
        ? Offset(0, triggerSize.height + widget.verticalGap)
        : Offset(0, -menuMaxHeight - widget.verticalGap);

    // attach scroll listener (nearest Scrollable) so overlay will be recreated while scrolling
    _attachScrollListener();

    _entry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            // transparent barrier to capture taps outside and close dropdown
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: _removeOverlay,
                child: const SizedBox.shrink(),
              ),
            ),

            // the follower will position the menu relative to the trigger
            CompositedTransformFollower(
              link: _layerLink,
              offset: followerOffset,
              showWhenUnlinked: false,
              child: Material(
                elevation: 6,
                borderRadius: BorderRadius.circular(8),
                clipBehavior: Clip.antiAlias,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: menuMaxHeight,
                    minWidth: triggerSize.width,
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: widget.items,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    Overlay.of(context).insert(_entry!);
    setState(() => _isOpen = true);
  }

  void _removeOverlay() {
    _entry?.remove();
    _entry = null;
    _removeScrollListener();
    if (_isOpen) setState(() => _isOpen = false);
  }

  void _recreateOverlay() {
    // simple approach: remove + create a fresh overlay (keeps things correct)
    _removeOverlay();
    // small post-frame delay to avoid "setState during build" issues
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _createOverlay();
    });
  }

  void _attachScrollListener() {
    // attach to nearest Scrollable once overlay is open
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final scrollable = Scrollable.of(context);
      final pos = scrollable.position;
      if (pos != _scrollPosition) {
        _removeScrollListener();
        _scrollPosition = pos;
        _scrollPosition!.addListener(_onScroll);
      }
    });
  }

  void _removeScrollListener() {
    if (_scrollPosition != null) {
      try {
        _scrollPosition!.removeListener(_onScroll);
      } catch (_) {}
      _scrollPosition = null;
    }
  }

  void _onScroll() {
    // reposition overlay while scrolling by recreating it
    if (_isOpen) _recreateOverlay();
  }

  @override
  void dispose() {
    _removeOverlay();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _toggleDropdown,
        behavior: HitTestBehavior.translucent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(6),
            color: Colors.white,
          ),
          child: Row(
            children: [
              Expanded(child: widget.title),
              Icon(_isOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: Colors.grey.shade700),
            ],
          ),
        ),
      ),
    );
  }
}
