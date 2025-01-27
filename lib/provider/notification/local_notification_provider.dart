import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_app/service/local_notification_service.dart';

class LocalNotificationProvider extends ChangeNotifier {
  LocalNotificationProvider(this.flutterNotificationService);

  final LocalNotificationService flutterNotificationService;

  int _notificationId = 0;
  bool? _permission = false;
  bool? get permission => _permission;

  bool _isReminderEnabled = false;
  bool get isReminderEnabled => _isReminderEnabled;

  List<PendingNotificationRequest> pendingNotificationRequests = [];

  Future<void> requestPermissions() async {
    _permission = await flutterNotificationService.requestPermissions();
    notifyListeners();
  }

  Future<void> toggleReminder(bool isEnabled) async {
    _isReminderEnabled = isEnabled;
    await flutterNotificationService.toggleDailyReminder(isEnabled);
    notifyListeners();
  }

  Future<void> loadReminderState() async {
    _isReminderEnabled = await flutterNotificationService.getReminderState();
    notifyListeners();
  }

  void scheduleDailyElevenAMNotification() {
    _notificationId += 1;
    flutterNotificationService.scheduleDailyElevenAMNotification(
      id: _notificationId,
    );
  }

  void showNotification() {
    _notificationId += 1;
    flutterNotificationService.showNotification(
      id: _notificationId,
      title: "New Notification",
      body: "This is a new notification with id $_notificationId",
      payload: "This is a payload from notification with id $_notificationId",
    );
  }

  Future<void> checkPendingNotificationRequests(BuildContext context) async {
    pendingNotificationRequests =
    await flutterNotificationService.pendingNotificationRequests();
    notifyListeners();
  }

  Future<void> cancelNotification(int id) async {
    await flutterNotificationService.cancelNotification(id);
  }
}