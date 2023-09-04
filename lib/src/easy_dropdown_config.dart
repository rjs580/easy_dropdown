import 'package:easy_dropdown2/src/easy_dropdown_alignment.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Configuration class for EasyDropdown widget.
class EasyDropdownConfig extends Equatable {
  /// Creates an instance of EasyDropdownConfig with optional parameters.
  ///
  /// [radius]: Radius for rounding the corners of the dropdown. If null,
  /// the default is [FloatingActionButtonThemeData.shape].
  ///
  /// [backgroundColor]: Background color of the dropdown. If null, the
  /// default is [ColorScheme.surfaceVariant].
  ///
  /// [tileHeight]: Height of individual tiles in the dropdown list. If null,
  /// the default is 56.
  ///
  /// [dropdownWidth]: Width of the dropdown.
  ///
  /// [dropdownHeight]: Height of the dropdown.
  ///
  /// [dropdownAlignment]: Alignment of the dropdown relative to the button.
  /// If null, the default is [EasyDropdownAlignment.center].
  const EasyDropdownConfig({
    this.radius,
    this.backgroundColor,
    this.tileHeight,
    this.dropdownWidth,
    this.dropdownHeight,
    this.dropdownAlignment,
    this.buttonMargin,
    this.showDividers,
    this.dividerBuilder,
    this.animationDuration,
  });

  /// Optional radius for rounding the corners of the dropdown. Defaults to
  /// [FloatingActionButtonThemeData.shape] if null.
  final double? radius;

  /// Optional background color of the dropdown. Defaults to
  /// [ColorScheme.surfaceVariant] if null.
  final Color? backgroundColor;

  /// Optional height of individual tiles in the dropdown list. Defaults to 56
  /// if null.
  final double? tileHeight;

  /// Optional width of the dropdown.
  final double? dropdownWidth;

  /// Optional height of the dropdown.
  final double? dropdownHeight;

  /// Optional alignment of the dropdown relative to the button. Defaults to
  /// [EasyDropdownAlignment.center] if null.
  final EasyDropdownAlignment? dropdownAlignment;

  /// The margin between the button and the dropdown.
  ///
  /// Use this value to control how far the dropdown should be positioned
  /// from the button.
  final double? buttonMargin;

  /// Whether to display dividers between items.
  final bool? showDividers;

  /// Builder function for custom dividers. Defaults to [Divider] if null
  final DividerBuilder? dividerBuilder;

  /// The duration for the dropdown animation.
  ///
  /// Use a [Duration] object to specify the animation duration in any time unit (e.g., seconds, milliseconds).
  /// Defaults to 160 milliseconds.
  final Duration? animationDuration;

  @override
  List<Object?> get props => [
        radius,
        backgroundColor,
        tileHeight,
        dropdownWidth,
        dropdownHeight,
        dropdownAlignment,
        buttonMargin,
        showDividers,
        dividerBuilder,
        animationDuration,
      ];
}

/// A typedef for the divider builder function.
typedef DividerBuilder = Widget Function(BuildContext context, int index);
