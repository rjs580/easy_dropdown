import 'dart:async';

import 'package:easy_dropdown2/src/easy_dropdown_alignment.dart';
import 'package:easy_dropdown2/src/easy_dropdown_config.dart';
import 'package:easy_dropdown2/src/easy_dropdown_list.dart';
import 'package:easy_dropdown2/src/easy_dropdown_tile.dart';
import 'package:flutter/material.dart';

/// A widget that provides dropdown functionality.
///
/// The [EasyDropdown] widget wraps an existing child widget and adds the ability
/// to display a dropdown list of items when activated. It is typically used to
/// create dropdown menus.
///
/// Example usage:
///
/// ```dart
/// EasyDropdown(
///   key: _dropDownKey, // GlobalKey<EasyDropdownState>
///   config: const EasyDropdownConfig(
///     radius: 16,
///   ),
///   items: Future.sync(() async {
///     await Future.delayed(const Duration(seconds: 2));
///     return [
///       EasyDropdownTile(title: 'Test', onPressed: () {}),
///       EasyDropdownTile(title: 'Test 1', onPressed: () {}),
///       EasyDropdownTile(title: 'Test 2', onPressed: () {}),
///     ];
///   }),
///   // items: [
///   //    EasyDropdownTile(title: 'Test', onPressed: () {}),
///   //    EasyDropdownTile(title: 'Test 1', onPressed: () {}),
///   //    EasyDropdownTile(title: 'Test 2', onPressed: () {}),
///   //  ],
///   child: RaisedButton(
///     onPressed: () {
///       _dropDownKey.currentState?.showOverlay();
///     },
///     child: Text(
///       'A selected field',
///     ),
///   ),
/// );
/// ```
class EasyDropdown extends StatefulWidget {
  /// Creates an instance of [EasyDropdown].
  ///
  /// The [child] parameter is required and represents the widget that will
  /// trigger the dropdown when interacted with.
  ///
  /// The [items] parameter is required and specifies the list of items to
  /// display in the dropdown.
  ///
  /// The [itemCount] parameter allows you to specify the maximum number of
  /// items to display in the dropdown. If not provided, all items are displayed.
  ///
  /// The [config] parameter allows you to customize the appearance and behavior
  /// of the dropdown menu. It includes options such as radius, background color,
  /// tile height, dropdown width, and more.
  ///
  /// The [onDropdownStart] callback is invoked when the dropdown is opened.
  ///
  /// The [onDropdownEnd] callback is invoked when the dropdown is closed.
  const EasyDropdown({
    super.key,
    required this.child,
    required this.items,
    this.itemCount,
    this.config = const EasyDropdownConfig(),
    this.onDropdownStart,
    this.onDropdownEnd,
  });

  /// The widget that triggers the dropdown when interacted with.
  final Widget child;

  /// The list of items to display in the dropdown.
  final FutureOr<List<EasyDropdownTile>> items;

  /// The configuration options for the appearance and behavior of the dropdown menu.
  final EasyDropdownConfig config;

  /// The maximum number of items to display in the dropdown. If not provided,
  /// all items are displayed.
  final double? itemCount;

  /// A callback that is invoked when the dropdown is opened.
  final VoidCallback? onDropdownStart;

  /// A callback that is invoked when the dropdown is closed.
  final VoidCallback? onDropdownEnd;

  @override
  State<EasyDropdown> createState() => EasyDropdownState();
}

/// The state of the [EasyDropdown] widget.
///
/// This class manages the state and behavior of the [EasyDropdown] widget.
/// It handles the overlay display and removal when the dropdown is shown
/// or hidden.
class EasyDropdownState extends State<EasyDropdown> {
  final GlobalKey _dropDownKey = GlobalKey();

  OverlayEntry? _overlayEntry;
  GlobalKey<EasyDropdownListState>? _easyDropdownState;

  /// Displays the dropdown overlay.
  ///
  /// This method shows the dropdown overlay when called. It calculates the
  /// position and size of the dropdown and handles whether it should be
  /// displayed above or below the button based on available space.
  void showOverlay() {
    if (!mounted) return;

    if (_overlayEntry != null) {
      removeOverlay();
      return;
    }

    final RenderBox buttonRenderBox = _dropDownKey.currentContext!.findRenderObject() as RenderBox;
    final buttonSize = buttonRenderBox.size;

    final screenSize = MediaQuery.of(context).size;

    final dropdownWidth = widget.config.dropdownWidth ?? buttonSize.width; // Set the width as needed
    double dropdownHeight;

    // Calculate available space below and above the button
    final spaceBelowButton = screenSize.height - buttonRenderBox.localToGlobal(Offset.zero).dy - buttonSize.height;
    final spaceAboveButton = buttonRenderBox.localToGlobal(Offset.zero).dy;

    final minHeightOfTile = widget.config.dropdownHeight ?? (widget.config.tileHeight ?? EasyDropdownList.kTileHeight);
    bool displayBelow = true;

    if (spaceBelowButton >= minHeightOfTile) {
      // Sufficient space below the button, display below
      dropdownHeight = spaceBelowButton;
    } else if (spaceAboveButton >= minHeightOfTile) {
      // Sufficient space above the button, display above
      dropdownHeight = spaceAboveButton;
      displayBelow = false;
    } else {
      // Not enough space below or above, use a default height
      dropdownHeight = minHeightOfTile;
    }

    double horizontalPosition;

    switch (widget.config.dropdownAlignment) {
      case EasyDropdownAlignment.center:
        horizontalPosition = buttonRenderBox.localToGlobal(Offset.zero).dx + (buttonSize.width - dropdownWidth) / 2; // Center horizontally
        break;
      case EasyDropdownAlignment.left:
        horizontalPosition = buttonRenderBox.localToGlobal(Offset.zero).dx;
        break;
      case EasyDropdownAlignment.right:
        horizontalPosition = buttonRenderBox.localToGlobal(Offset.zero).dx + buttonSize.width - dropdownWidth;
        break;
      default:
        horizontalPosition = buttonRenderBox.localToGlobal(Offset.zero).dx + (buttonSize.width - dropdownWidth) / 2; // Default to center
        break;
    }

    final OverlayState overlayState = Overlay.of(context);
    _easyDropdownState = GlobalKey<EasyDropdownListState>();
    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  removeOverlay();
                },
              ),
            ),
            Positioned(
              top: spaceBelowButton >= minHeightOfTile ? (buttonRenderBox.localToGlobal(Offset.zero).dy + buttonSize.height + 4) : (buttonRenderBox.localToGlobal(Offset.zero).dy - dropdownHeight - 4),
              // left: buttonRenderBox.localToGlobal(Offset.zero).dx + (buttonSize.width - dropdownWidth) / 2,
              left: horizontalPosition,
              child: SizedBox(
                width: dropdownWidth,
                height: widget.config.dropdownHeight ?? dropdownHeight,
                child: EasyDropdownList(
                  key: _easyDropdownState,
                  items: widget.items,
                  config: widget.config,
                  alignment: displayBelow ? Alignment.topCenter : Alignment.bottomCenter,
                  itemCount: widget.itemCount,
                  removeOverlay: removeOverlay,
                ),
              ),
            )
          ],
        );
      },
    );

    overlayState.insert(_overlayEntry!);
    widget.onDropdownStart?.call();
  }

  /// Removes the dropdown overlay.
  ///
  /// This method removes the dropdown overlay. If [noAnimation] is set to true,
  /// the removal is instantaneous without any animation.
  Future<void> removeOverlay([bool? noAnimation]) async {
    if (noAnimation == true) {
      if (_overlayEntry != null) {
        widget.onDropdownEnd?.call();

        _overlayEntry?.remove();
        _overlayEntry = null;
      }

      return;
    }

    if (_overlayEntry != null) {
      widget.onDropdownEnd?.call();

      await _easyDropdownState?.currentState?.animationController.reverse();

      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      key: _dropDownKey,
      type: MaterialType.transparency,
      child: widget.child,
    );
  }
}
