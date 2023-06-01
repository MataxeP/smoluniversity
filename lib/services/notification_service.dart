import 'package:awesome_notifications/awesome_notifications.dart';

Future<void> cancelNotification(int id) async {
  await AwesomeNotifications().cancel(id);
}

Future<void> createLessonRemindedNotification(
    int id, String title, int day, int hour, int minute) async {
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: id,
          channelKey: 'schedule',
          title: title,
          body: 'До следующей пары осталось 20 минут!',
          notificationLayout: NotificationLayout.Default),
      schedule: NotificationCalendar(
          weekday: day,
          hour: hour,
          minute: minute,
          second: 0,
          millisecond: 0,
          repeats: true));
}

Future<void> createNoteRemindedNotification(
    int id,
    String title,
    String description,
    int hour,
    int year,
    int month,
    int day,
    int minute) async {
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: id,
          channelKey: 'notes',
          title: title,
          body: description,
          notificationLayout: NotificationLayout.Default),
      schedule: NotificationCalendar(
          year: year,
          month: month,
          day: day,
          hour: hour,
          minute: minute,
          second: 0,
          millisecond: 0));
}
