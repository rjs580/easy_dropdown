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
