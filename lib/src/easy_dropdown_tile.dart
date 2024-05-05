import 'package:easy_dropdown2/src/easy_dropdown_list.dart';
import 'package:flutter/material.dart';

/// A widget representing a tile within an EasyDropdown.
///
/// An [EasyDropdownTile] is typically used to display a selectable item
/// within a dropdown list. It provides customization options for the tile's
/// appearance, including its title, subtitle, icon, and selected state.
///
/// Example usage:
///
/// ```dart
/// EasyDropdownTile(
///   title: 'Option 1',
///   subtitle: 'Description for Option 1',
///   icon: Icons.star,
///   isSelected: true,
///   onPressed: () {
///     // Callback when the tile is pressed.
///   },
/// )
/// ```
class EasyDropdownTile extends StatelessWidget {
  /// Creates an instance of [EasyDropdownTile].
  ///
  /// The [title] parameter is required and represents the main title of the tile.
  ///
  /// The [onPressed] parameter is a callback that is invoked when the tile is
  /// pressed.
  ///
  /// The [padding] parameter controls the padding applied to the tile. Defaults
  /// to `EdgeInsets.all(16)`.
  ///
  /// The [icon] parameter specifies an optional icon to display on the left
  /// side of the tile.
  ///
  /// The [subtitle] parameter allows you to provide an optional subtitle for
  /// the tile.
  ///
  /// The [isSelected] parameter indicates whether the tile is selected.
  ///
  /// The [iconColor] parameter sets the color of the icon. Defaults to the theme's
  /// `onSurfaceVariant` color.
  ///
  /// The [iconSize] parameter specifies the size of the icon.
  ///
  /// The [iconPadding] parameter controls the padding around the icon. Defaults
  /// to `EdgeInsets.only(right: 16)`.
  ///
  /// The [titleStyle] parameter sets the style for the title text. Defaults to
  /// the theme's large label style.
  ///
  /// The [titleAlignment] parameter specifies the alignment of the title text.
  /// Defaults to [TextAlign.center].
  ///
  /// The [subtitleStyle] parameter sets the style for the subtitle text. Defaults
  /// to the theme's small label style.
  ///
  /// The [subtitleAlignment] parameter specifies the alignment of the subtitle text.
  /// Defaults to [TextAlign.start].
  ///
  /// The [selectedIcon] parameter allows you to specify an optional icon to display
  /// on the right side of the tile when it is selected. Defaults to [Icons.check_rounded].
  ///
  /// The [selectedIconColor] parameter sets the color of the selected icon. Defaults
  /// to the theme's `onSurfaceVariant` color.
  ///
  /// The [selectedIconSize] parameter specifies the size of the selected icon.
  ///
  /// The [selectedIconPadding] parameter controls the padding around the selected
  /// icon. Defaults to `EdgeInsets.only(left: 16)`.
  ///
  /// The [selectedBackgroundColor] is the background color of the tile when it is selected.
  /// Defaults to [ThemeData.splashColor].

  const EasyDropdownTile({
    super.key,
    required this.title,
    required this.onPressed,
    this.padding = const EdgeInsets.all(16),
    this.icon,
    this.subtitle,
    this.isSelected = false,
    this.iconColor,
    this.iconSize,
    this.iconPadding = const EdgeInsets.only(right: 16),
    this.titleStyle,
    this.titleAlignment,
    this.subtitleStyle,
    this.subtitleAlignment,
    this.selectedIcon,
    this.selectedIconColor,
    this.selectedIconSize,
    this.selectedIconPadding = const EdgeInsets.only(left: 16),
    this.selectedBackgroundColor,
  });

  /// The [padding] parameter controls the padding applied to the tile. Defaults
  /// to `EdgeInsets.all(16)`.
  final EdgeInsets padding;

  /// The main title of the tile.
  final String title;

  /// The style for the title text. Defaults to the theme's large label style.
  final TextStyle? titleStyle;

  /// The alignment of the title text. Defaults to [TextAlign.center].
  final TextAlign? titleAlignment;

  /// An optional subtitle for the tile.
  final String? subtitle;

  /// The style for the subtitle text. Defaults to the theme's small label style.
  final TextStyle? subtitleStyle;

  /// The alignment of the subtitle text. Defaults to [TextAlign.start].
  final TextAlign? subtitleAlignment;

  /// Indicates whether the tile is selected.
  final bool isSelected;

  /// A callback that is invoked when the tile is pressed.
  final VoidCallback? onPressed;

  /// An optional icon to display on the left side of the tile.
  final IconData? icon;

  /// The color of the icon. Defaults to the theme's `onSurfaceVariant` color.
  final Color? iconColor;

  /// The size of the icon.
  final double? iconSize;

  /// The padding around the icon. Defaults to `EdgeInsets.only(right: 16)`.
  final EdgeInsets iconPadding;

  /// An optional icon to display on the right side of the tile when it is selected.
  final IconData? selectedIcon;

  /// The color of the selected icon. Defaults to the theme's `onSurfaceVariant` color.
  final Color? selectedIconColor;

  /// The size of the selected icon. Defaults to 22.
  final double? selectedIconSize;

  /// The padding around the selected icon. Defaults to `EdgeInsets.only(left: 16)`.
  final EdgeInsets selectedIconPadding;

  /// The [selectedBackgroundColor] is the background color of the tile when it is selected.
  /// Defaults to [ThemeData.splashColor].
  final Color? selectedBackgroundColor;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final Widget titleWidget = Text(
      title,
      style: (titleStyle ??
          theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.bold,
          )),
      textAlign: titleAlignment ?? TextAlign.center,
    );

    final Widget? subtitleWidget = (subtitle?.isNotEmpty == true)
        ? Text(
            subtitle!,
            softWrap: true,
            style: subtitleStyle ?? theme.textTheme.labelSmall,
            textAlign: subtitleAlignment ?? TextAlign.start,
          )
        : null;

    return InkWell(
      onTap: () {
        Future.delayed(const Duration(milliseconds: 160), () {
          final dropdownList =
              context.findAncestorStateOfType<EasyDropdownListState>();
          if (dropdownList != null) {
            dropdownList.widget.removeOverlay?.call();
          }
          onPressed?.call();
        });
      },
      child: Container(
        padding: padding,
        color: isSelected == true
            ? (selectedBackgroundColor ?? theme.splashColor)
            : null,
        child: Row(
          children: [
            if (icon != null)
              Padding(
                padding: iconPadding,
                child: Icon(
                  icon,
                  color: iconColor ?? theme.colorScheme.onSurfaceVariant,
                  size: iconSize,
                ),
              ),
            Expanded(
              child: subtitleWidget != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        titleWidget,
                        subtitleWidget,
                      ],
                    )
                  : titleWidget,
            ),
            if (isSelected == true)
              Padding(
                padding: selectedIconPadding,
                child: Icon(
                  selectedIcon ?? Icons.check_rounded,
                  color:
                      selectedIconColor ?? theme.colorScheme.onSurfaceVariant,
                  size: selectedIconSize ?? 22,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
