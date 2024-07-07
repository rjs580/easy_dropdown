/// EasyDropdown is a Flutter library that provides an easy-to-use and
/// customizable dropdown menu widget. It allows you to create dropdown menus
/// that can be displayed below or above a button, with various configuration
/// options for styling and behavior.
///
///
/// EasyDropdown simplifies the process of creating dropdowns in your Flutter
/// app, making it straightforward to add interactive and user-friendly
/// dropdowns to your UI.
///
/// Usage:
/// ```
/// import 'package:easy_dropdown2/easy_dropdown2.dart';
///
/// // Create an EasyDropdown widget with custom configuration and items.
/// EasyDropdown(
///   key: _dropDownKey, // GlobalKey<EasyDropdownState>
///   config: const EasyDropdownConfig(
///     radius: 16,
///     backgroundColor: Colors.blue,
///     tileHeight: 64,
///     dropdownWidth: 200,
///   ),
///   items: Future.sync(() async {
///     await Future.delayed(const Duration(seconds: 2));
///     return [
///       EasyDropdownTile(title: 'Test', onPressed: () {}),
///       EasyDropdownTile(title: 'Test 1', onPressed: () {}),
///       EasyDropdownTile(title: 'Test 2', onPressed: () {}),
///     ];
///   }),
///   // You can add items directly as arrays as well
///   // items: [
///   //    EasyDropdownTile(title: 'Test', onPressed: () {}),
///   //    EasyDropdownTile(title: 'Test 1', onPressed: () {}),
///   //    EasyDropdownTile(title: 'Test 2', onPressed: () {}),
///   //  ],
///   child: RaisedButton(
///     onPressed: () {
///       // Show the dropdown when the button is pressed.
///       _dropDownKey.currentState?.showOverlay();
///     },
///     child: Text(
///       'A selected field',
///     ),
///   ),
/// );
/// ```
///
/// This library provides the core classes [EasyDropdown] and [EasyDropdownTile]
/// to create and customize dropdowns.
///
/// For more details and customization options, refer to the documentation of
/// each individual class.
library easy_dropdown;

export 'src/easy_dropdown_alignment.dart' show EasyDropdownAlignment;
export 'src/easy_dropdown_direction.dart' show EasyDropdownDirection;
export 'src/easy_dropdown_tile.dart' show EasyDropdownTile;
export 'src/easy_dropdown_config.dart' show EasyDropdownConfig;
export 'src/easy_dropdown.dart' show EasyDropdown, EasyDropdownState;
export 'src/easy_dropdown_list.dart'
    hide EasyDropdownList, EasyDropdownListState;
