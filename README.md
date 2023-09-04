# EasyDropdown

EasyDropdown is a Flutter library that simplifies the creation of customizable and user-friendly dropdown menus. It offers flexible positioning, styling, and a straightforward API to create dropdowns with ease.

<img src="https://github.com/rjs580/easy_dropdown/blob/master/EasyDropdownDemo.gif?raw=true" width="200"/>

## Features

- Create dropdown menus with customizable tiles.
- Flexible positioning options: display dropdowns above or below a button.
- Customize tile height, dropdown width, and other styling options.
- Smooth animations for showing and hiding the dropdown.

## Getting Started

### Installation

To use EasyDropdown in your Flutter project, add it as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  easy_dropdown: ^1.0.0  # Replace with the latest version
```
Then, run `flutter pub get` to fetch the package.

### Usage

Here's a simple example of how to use EasyDropdown:

```dart
import 'package:flutter/material.dart';
import 'package:easy_dropdown/easy_dropdown.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GlobalKey<EasyDropdownState> _dropdownKey = GlobalKey<EasyDropdownState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('EasyDropdown Example'),
        ),
        body: Center(
          child: EasyDropdown(
            key: _dropdownKey,
            items: Future.sync(() async {
              // Simulate loading items from an async source
              await Future.delayed(const Duration(seconds: 2));
              return [
                EasyDropdownTile(title: 'Item 1', onPressed: () {}),
                EasyDropdownTile(title: 'Item 2', onPressed: () {}),
                EasyDropdownTile(title: 'Item 3', onPressed: () {}),
              ];
            }),
            // Items can also just be an array
            // items: [
            //    EasyDropdownTile(title: 'Test', onPressed: () {}),
            //    EasyDropdownTile(title: 'Test 1', onPressed: () {}),
            //    EasyDropdownTile(title: 'Test 2', onPressed: () {}),
            //  ],
            child: ElevatedButton(
              onPressed: () {
                // Show the EasyDropdown when the button is pressed
                _dropdownKey.currentState?.showOverlay();
              },
              child: Text('Open Dropdown'),
            ),
          ),
        ),
      ),
    );
  }
}
```

### Documentation
For detailed usage instructions and customization options, please refer to the [documentation](https://pub.dev/packages/easy_dropdown).

### License
This project is licensed under the MIT License - see the LICENSE file for details.