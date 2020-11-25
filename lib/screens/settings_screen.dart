import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clean_settings/clean_settings.dart';

import '../providers/settings.dart';
import '../widgets/app_drawer.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<Settings>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      drawer: AppDrawer(),
      body: SettingContainer(
        sections: [
          SettingSection(
            title: 'Currency Symbol',
            items: [
              SettingCheckboxItem(
                title: 'Show Currency Symbol',
                description:
                    'Show the chosen currency symbol when displaying money amounts',
                value: settingsProvider.showCurrency,
                onChanged: (changedShowCurrency) =>
                    settingsProvider.showCurrency = changedShowCurrency,
              ),
              SettingTextItem(
                title: 'Change Currency Symbol',
                onChanged: (changedCurrencySymbol) {
                  if (changedCurrencySymbol.isEmpty) {
                    // TODO: show snackbar or something
                    return;
                  }
                  settingsProvider.currencySymbol = changedCurrencySymbol;
                },
                displayValue: settingsProvider.currencySymbol,
                initialValue: settingsProvider.currencySymbol,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
