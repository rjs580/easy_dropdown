import 'package:easy_dropdown2/easy_dropdown2.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF006C4A),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFF73FBBF),
  onPrimaryContainer: Color(0xFF002114),
  secondary: Color(0xFF006C4A),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFF73FBBF),
  onSecondaryContainer: Color(0xFF002114),
  tertiary: Color(0xFF006C4A),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFF73FBBF),
  onTertiaryContainer: Color(0xFF002114),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  background: Color(0xFFF4FFF6),
  onBackground: Color(0xFF002114),
  surface: Color(0xFFF4FFF6),
  onSurface: Color(0xFF002114),
  surfaceVariant: Color(0xFFDCE5DD),
  onSurfaceVariant: Color(0xFF404943),
  outline: Color(0xFF707973),
  onInverseSurface: Color(0xFFBEFFDC),
  inverseSurface: Color(0xFF003825),
  inversePrimary: Color(0xFF53DEA5),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF006C4A),
  outlineVariant: Color(0xFFC0C9C1),
  scrim: Color(0xFF000000),
);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final lightTheme = ThemeData(
      useMaterial3: true,
      colorScheme: lightColorScheme,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );

    return MaterialApp(
      theme: lightTheme,
      home: const EasyDropdownTest(),
    );
  }
}

class EasyDropdownTest extends StatefulWidget {
  const EasyDropdownTest({
    super.key,
  });

  @override
  State<EasyDropdownTest> createState() => _EasyDropdownTestState();
}

class _EasyDropdownTestState extends State<EasyDropdownTest> {
  final GlobalKey<EasyDropdownState> _dropDownKey = GlobalKey();
  final GlobalKey<EasyDropdownState> _dropDownKey2 = GlobalKey();
  final GlobalKey<EasyDropdownState> _dropDownKey3 = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              EasyDropdown(
                key: _dropDownKey,
                config: const EasyDropdownConfig(
                  radius: 16,
                  showDividers: true,
                ),
                items: Future.sync(() async {
                  await Future.delayed(const Duration(seconds: 2));
                  return [
                    EasyDropdownTile(
                      title: 'Test',
                      subtitle: 'A subtitle to test, maybe it can be long but could also be short',
                      onPressed: () {},
                    ),
                    EasyDropdownTile(
                      title: 'Test 1',
                      subtitle: 'A subtitle to test, maybe it can be long but could also be short. A subtitle to test, maybe it can be long but could also be short. A subtitle to test, maybe it can be long but could also be short. A subtitle to test, maybe it can be long but could also be short. A subtitle to test, maybe it can be long but could also be short.',
                      onPressed: () {},
                    ),
                    EasyDropdownTile(title: 'Test 2', onPressed: () {}),
                  ];
                }),
                child: InkWell(
                  onTap: () {
                    _dropDownKey.currentState?.showOverlay();
                  },
                  child: const InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Test Button',
                      suffixIcon: Icon(Icons.arrow_drop_down),
                    ),
                    child: Text(
                      'A selected field',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 200),
              EasyDropdown(
                key: _dropDownKey3,
                config: const EasyDropdownConfig(
                  radius: 16,
                  dropdownWidth: 200,
                  dropdownHeight: 100,
                  animationDuration: Duration(milliseconds: 120),
                ),
                items: Future.sync(() async {
                  await Future.delayed(const Duration(seconds: 6));
                  return [
                    EasyDropdownTile(title: 'Test', onPressed: () {}),
                    EasyDropdownTile(title: 'Test 1', onPressed: () {}),
                    EasyDropdownTile(
                      title: 'Test 2',
                      onPressed: () {},
                      isSelected: true,
                    ),
                  ];
                }),
                child: SizedBox(
                  width: 150,
                  child: InkWell(
                    onTap: () {
                      _dropDownKey3.currentState?.showOverlay();
                    },
                    child: const InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Test Button',
                        suffixIcon: Icon(Icons.arrow_drop_down),
                      ),
                      child: Text(
                        'A selected field',
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 600),
              EasyDropdown(
                key: _dropDownKey2,
                config: const EasyDropdownConfig(
                  radius: 16,
                  // dropdownHeight: 300,
                ),
                items: Future.sync(() async {
                  await Future.delayed(const Duration(seconds: 4));
                  return [
                    EasyDropdownTile(title: 'Test', onPressed: () {}),
                    EasyDropdownTile(title: 'Test 1', onPressed: () {}),
                    EasyDropdownTile(
                      title: 'Test 2',
                      onPressed: () {},
                      isSelected: true,
                    ),
                  ];
                }),
                child: InkWell(
                  onTap: () {
                    _dropDownKey2.currentState?.showOverlay();
                  },
                  child: const InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Test Button',
                      suffixIcon: Icon(Icons.arrow_drop_down),
                    ),
                    child: Text(
                      'A selected field',
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
