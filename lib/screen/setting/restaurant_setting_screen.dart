import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/notification/local_notification_provider.dart';
import 'package:restaurant_app/provider/theme/restaurant_theme_provider.dart';

class RestaurantSettingScreen extends StatefulWidget {
  const RestaurantSettingScreen({super.key});

  @override
  State<RestaurantSettingScreen> createState() => _RestaurantSettingScreenState();
}

class _RestaurantSettingScreenState extends State<RestaurantSettingScreen> {
  @override
  void initState() {
    super.initState();
    context.read<LocalNotificationProvider>().loadReminderState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Theme',
                style: Theme.of(context).textTheme.titleLarge
              ),
            ),
            Consumer<RestaurantThemeProvider>(
                builder: (context, themeProvider, child) {
                  final isDark = themeProvider.themeMode == ThemeMode.dark;
                  return SwitchListTile(
                      title: const Text('Dark Mode'),
                      secondary: const Icon(Icons.dark_mode),
                      value: isDark,
                      onChanged: (bool value){
                        themeProvider.toggleTheme();
                      }
                  );
                }
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                  'Notification',
                  style: Theme.of(context).textTheme.titleLarge
              ),
            ),
            Consumer<LocalNotificationProvider>(
                builder: (context, provider, child) {
                  return SwitchListTile(
                      title: const Text('Add Reminder'),
                      secondary: const Icon(Icons.notifications_active),
                      value: provider.isReminderEnabled,
                      onChanged: (bool value){
                        provider.toggleReminder(value);
                      }
                  );
                },
            ),
          ],
        ),
      ),
    );
  }
}