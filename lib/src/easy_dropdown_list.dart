import 'dart:async';

import 'package:easy_dropdown2/src/easy_dropdown_config.dart';
import 'package:easy_dropdown2/src/easy_dropdown_tile.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// A widget that displays a list of items as a dropdown within an overlay.
///
/// The [EasyDropdownList] widget is part of the EasyDropdown package and is
/// used to display a list of items as a dropdown within an overlay. It can be
/// customized with various configuration options.
///
/// This class is intended for internal use within the EasyDropdown package
/// and may not be suitable for direct use in your application.
///
/// To use [EasyDropdownList], provide a list of items in the [items] parameter,
/// and optionally configure its appearance and behavior using the [config]
/// parameter. You can also specify the number of items to display using the
/// [itemCount] parameter.
///
class EasyDropdownList extends StatefulWidget {
  /// Default height of each tile in the dropdown list.
  static const double kTileHeight = 56;

  /// Creates an instance of [EasyDropdownList].
  ///
  /// The [items] parameter is required and represents the list of items to
  /// display in the dropdown.
  ///
  /// The [config] parameter allows you to customize the appearance and behavior
  /// of the dropdown. You can set properties like radius, background color, etc.
  ///
  /// The [itemCount] parameter specifies the number of items to display in the
  /// dropdown. If not specified, it will display all items in [items].
  ///
  /// The [alignment] parameter determines the alignment of the dropdown relative
  /// to its parent widget. It uses [AlignmentGeometry] to specify the alignment.
  ///
  /// The [removeOverlay] callback is used to trigger the removal of the overlay
  /// when necessary by [EasyDropdownList] and its predecessors.
  const EasyDropdownList({
    super.key,
    required this.items,
    this.itemCount,
    this.alignment,
    this.config = const EasyDropdownConfig(),
    this.removeOverlay,
  });

  /// A future or list of [EasyDropdownTile] widgets to display in the dropdown.
  final FutureOr<List<EasyDropdownTile>> items;

  /// Configuration options for customizing the appearance and behavior of
  /// the dropdown.
  final EasyDropdownConfig config;

  /// The number of items to display in the dropdown. If not specified, it
  /// will display all items in [items].
  final double? itemCount;

  /// The alignment of the dropdown relative to its parent widget.
  final AlignmentGeometry? alignment;

  /// Callback to remove the overlay when needed.
  final void Function([bool? noAnimation])? removeOverlay;

  @override
  State<EasyDropdownList> createState() => EasyDropdownListState();
}

class EasyDropdownListState extends State<EasyDropdownList> with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final ScrollController _scrollController;
  late final Animation<double> _heightAnimation;
  late final Animation<double> _opacityAnimation;

  double? _itemCount;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: widget.config.animationDuration ?? const Duration(milliseconds: 160),
    );

    _scrollController = ScrollController();

    _heightAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn));
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn));

    _itemCount = widget.itemCount;

    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final ShapeBorder? shape;

    if (widget.config.radius != null) {
      shape = RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(widget.config.radius!),
        ),
      );
    } else {
      shape = theme.floatingActionButtonTheme.shape ??
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          );
    }

    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        double height = widget.config.dropdownHeight ?? ((_itemCount ?? 1) * (widget.config.tileHeight ?? EasyDropdownList.kTileHeight));

        return SizedBox(
          height: _heightAnimation.value * height,
          child: ClipRect(
            clipBehavior: Clip.none,
            child: OverflowBox(
              maxHeight: _heightAnimation.value * height,
              minHeight: _heightAnimation.value * height,
              alignment: widget.alignment ?? Alignment.topCenter,
              child: Opacity(
                opacity: _opacityAnimation.value,
                child: child!,
              ),
            ),
          ),
        );
      },
      child: Material(
        type: MaterialType.canvas,
        elevation: widget.config.dropdownElevation ?? 2,
        clipBehavior: Clip.antiAlias,
        shape: shape,
        color: widget.config.backgroundColor ?? theme.colorScheme.surfaceVariant,
        child: FutureBuilder<List<EasyDropdownTile>>(
          future: ensureFuture(widget.items),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (snapshot.hasData) {
              if (_itemCount == null) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _itemCount = snapshot.data?.length.toDouble();
                  animationController.forward(from: 0.5);
                });
              }

              return ScrollConfiguration(
                behavior: const _CustomDropdownButtonScrollBehaviour(),
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  removeBottom: true,
                  removeRight: true,
                  removeLeft: true,
                  child: Scrollbar(
                    controller: _scrollController,
                    thumbVisibility: true,
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      controller: _scrollController,
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        return ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: (widget.config.tileHeight ?? EasyDropdownList.kTileHeight),
                          ),
                          child: snapshot.data?[index],
                        );
                      },
                      separatorBuilder: (context, index) {
                        if (widget.config.showDividers ?? false) {
                          return widget.config.dividerBuilder?.call(context, index) ?? const Divider();
                        }

                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ),
              );
            } else {
              return const Center(
                child: Text('No data available'),
              );
            }
          },
        ),
      ),
    );
  }

  Future<T> ensureFuture<T>(FutureOr<T> value) {
    if (value is Future<T>) {
      return value;
    }
    return Future<T>.value(value);
  }
}

class _CustomDropdownButtonScrollBehaviour extends MaterialScrollBehavior {
  const _CustomDropdownButtonScrollBehaviour() : super();

  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
