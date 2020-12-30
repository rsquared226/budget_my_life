import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

import '../providers/settings.dart';
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

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<Settings>(context);

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
          ],
        ),
      ),
    );
  }
}
