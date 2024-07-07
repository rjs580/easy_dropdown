## 1.4.1
- Fixed an issue where the set direction of the dropdown was not working

## 1.4.0
- Added a new direction feature for dropdowns. Now, you can specify the direction of the dropdown by using the `EasyDropdownDirection` enumeration in the `EasyDropdownConfig`. If not specified, the dropdown will follow the default direction.

## 1.3.2
- Fix an issue where bold font gets applied to custom text styling

## 1.3.1
- Fixed an issue with Android Predictive Back feature

## 1.3.0
- Fixed an issue where the dropdown was not displayed correctly above the button when a specific height was specified and there was not enough room to display it below.
- Resolved the problem with the scrollbar not rendering properly in landscape orientation.
- Fixed the positioning of the dropdown when changing screen orientation.
- Added a new feature to customize the elevation of the dropdown. Now you can control the shadow depth of the dropdown to enhance its appearance.

## 1.2.1

- Fixed an issue where `EasyDropdownTile` was not conforming to the set height set in `EasyDropdownConfig` or the default `kTileHeight`.

## 1.2.0

- Added the `selectedBackgroundColor` property to `EasyDropdownTile` to customize the background color when a tile is selected. The default value is `ThemeData.splashColor`.
- Added a default value for the `radius` property in `EasyDropdownConfig`. If `radius` is null, it will use `FloatingActionButtonThemeData.shape` as the default value. If `FloatingActionButtonThemeData.shape` is also null, the radius will default to 16.

## 1.1.0

- Added `buttonMargin` configuration option to `EasyDropdownConfig` for controlling the margin between the button and the dropdown.
- Added `showDividers` configuration option to `EasyDropdownConfig` for controlling divider display between items.
- Added `dividerBuilder` configuration option to `EasyDropdownConfig` for customizing divider widgets.
- Added `animationDuration` configuration option to `EasyDropdownConfig` for controlling the animation duration of the dropdown. Users can specify the duration in various time units (e.g., seconds, milliseconds).
- Fixed an issue where subtitles were not being displayed for `EasyDropdownTile`.
- Updated documentation to reflect the new configuration option.

## 1.0.0

- Initial release of EasyDropdown library.
- Basic dropdown functionality with customizable tiles.
- Supports showing the dropdown above or below a button.
- Configurable tile height, dropdown width, and other options.
