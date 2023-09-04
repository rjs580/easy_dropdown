import 'package:easy_dropdown/src/easy_dropdown_alignment.dart';
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

  @override
  List<Object?> get props => [
        radius,
        backgroundColor,
        tileHeight,
        dropdownWidth,
      ];
}
