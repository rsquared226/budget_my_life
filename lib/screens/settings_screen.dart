import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

import '../providers/settings.dart';
import '../providers/theme_provider.dart';
import '../widgets/app_drawer.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = '/settings';

  // Mostly came from here: https://github.com/grouped/clean_settings/blob/master/lib/src/setting_text_item.dart
  Future<void> textAlertDialog({
    @required BuildContext context,
    @required String title,
    String initialValue = '',
    String hintText = '',
    String confirmText = 'OK',
    @required ValueChanged<String> onChanged,
  }) async {
    final changedCurrencySymbol = await showDialog<String>(
      context: context,
      builder: (context) {
        var controller = TextEditingController(text: initialValue);
        return AlertDialog(
          title: Text(title),
          contentPadding: const EdgeInsets.all(16.0),
          content: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: controller,
                  autofocus: true,
                  decoration: InputDecoration(hintText: hintText),
                ),
              )
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text('CANCEL'),
              onPressed: () => Navigator.pop(context),
            ),
            FlatButton(
              child: Text(confirmText),
              onPressed: () => Navigator.pop(context, controller.text),
            )
          ],
        );
      },
    );

    if (changedCurrencySymbol != null &&
        changedCurrencySymbol != initialValue) {
      onChanged(changedCurrencySymbol);
    }
  }

  // Did this to make the build method code slightly easier to read.
  // This displays a set of choices and allows the user to choose between any of
  // them. An enum type is expected to be passed in as T with the string
  // representation.
  Future<void> simpleChoiceDialog<T>({
    @required BuildContext context,
    @required String title,
    T initialValue,
    @required Map<T, String> choices,
    @required ValueChanged<T> onChanged,
  }) async {
    final selectedChoice = await showDialog<T>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text(title),
          children: List<SimpleDialogOption>.generate(
            choices.length,
            (index) => SimpleDialogOption(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              onPressed: () =>
                  Navigator.pop(context, choices.keys.elementAt(index)),
              child: Text(
                choices.values.elementAt(index),
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        );
      },
    );

    if (selectedChoice != null && selectedChoice != initialValue) {
      onChanged(selectedChoice);
    }
  }

  String themeTypeToString(ThemeType themeType) {
    switch (themeType) {
      case ThemeType.Dark:
        return 'Dark';
      case ThemeType.Amoled:
        return 'OLED Black';
      default:
        return 'Light';
    }
  }

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<Settings>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: SettingsList(
          backgroundColor: Theme.of(context).canvasColor,
          sections: [
            SettingsSection(
              title: 'Currency Symbol',
              tiles: [
                SettingsTile.switchTile(
                  title: 'Show Currency Symbol',
                  subtitle: (settingsProvider.showCurrency ? 'S' : 'Not s') +
                      'howing the chosen currency symbol',
                  subtitleMaxLines: 2,
                  switchValue: settingsProvider.showCurrency,
                  onToggle: (changedShowCurrency) =>
                      settingsProvider.showCurrency = changedShowCurrency,
                ),
                SettingsTile(
                  enabled: settingsProvider.showCurrency,
                  title: 'Change Currency Symbol',
                  subtitle: settingsProvider.currencySymbol,
                  onPressed: (BuildContext context) => textAlertDialog(
                    context: context,
                    title: 'Change currency symbol',
                    confirmText: 'SET',
                    initialValue: settingsProvider.currencySymbol,
                    onChanged: (changedCurrencySymbol) {
                      if (changedCurrencySymbol.isNotEmpty ||
                          changedCurrencySymbol.length <= 5) {
                        settingsProvider.currencySymbol = changedCurrencySymbol;
                      }
                    },
                  ),
                ),
              ],
            ),
            SettingsSection(
              title: 'Theme',
              tiles: [
                SettingsTile(
                  title: 'Change Theme',
                  subtitle: themeTypeToString(themeProvider.themeType),
                  onPressed: (BuildContext context) =>
                      simpleChoiceDialog<ThemeType>(
                    context: context,
                    title: 'Change Theme',
                    initialValue: themeProvider.themeType,
                    // Go through all theme options and display them.
                    choices: Map.fromIterable(
                      ThemeType.values,
                      key: (element) => element,
                      value: (element) => themeTypeToString(element),
                    ),
                    onChanged: (newTheme) => themeProvider.themeType = newTheme,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
