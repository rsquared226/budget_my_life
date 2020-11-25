import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clean_settings/clean_settings.dart';

import '../providers/settings.dart';
import '../widgets/app_drawer.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = '/settings';

  // All this is for simulating a disabled setting when the checkbox is unchecked.
  Widget _buildSettingDisabled({
    @required BuildContext context,
    @required bool disabled,
    @required Widget child,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 125),
      foregroundDecoration: BoxDecoration(
        color: !disabled ? null : Theme.of(context).canvasColor.withOpacity(.6),
      ),
      child: IgnorePointer(
        ignoring: disabled,
        // This is the actual setting.
        child: child,
      ),
    );
  }

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
              _buildSettingDisabled(
                context: context,
                disabled: !settingsProvider.showCurrency,
                child: SettingTextItem(
                  title: 'Change Currency Symbol',
                  onChanged: (changedCurrencySymbol) {
                    if (changedCurrencySymbol == null ||
                        changedCurrencySymbol.isEmpty ||
                        changedCurrencySymbol.length > 5) {
                      // Don't change anything if the users clicks cancel or if they input nothing in the box.
                      return;
                    }
                    settingsProvider.currencySymbol = changedCurrencySymbol;
                  },
                  displayValue: settingsProvider.currencySymbol,
                  initialValue: settingsProvider.currencySymbol,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
