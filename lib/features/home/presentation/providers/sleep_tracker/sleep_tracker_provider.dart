import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SleepTrackerProvider extends ChangeNotifier {
  DateTime? _sleepStartTime;
  DateTime? _wakeUpTime;
  Duration? _sleepDuration;
  List<SleepData> _sleepHistory = [];
  DateTime _selectedDate = DateTime.now();
  Timer? _timer;
  Duration _elapsedTime = Duration.zero;

  DateTime? get sleepStartTime => _sleepStartTime;
  Duration get elapsedTime => _elapsedTime;
  DateTime get selectedDate => _selectedDate;
  List<SleepData> get sleepHistory => _sleepHistory;

  SleepTrackerProvider() {
    _loadSleepHistory();
  }

  void startSleepTracking() {
    _sleepStartTime = DateTime.now();
    _elapsedTime = Duration.zero;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _elapsedTime = DateTime.now().difference(_sleepStartTime!);
      notifyListeners();
    });
  }

  void stopSleepTracking() async {
    _timer?.cancel();

    _wakeUpTime = DateTime.now();
    _sleepDuration = _wakeUpTime!.difference(_sleepStartTime!);

    _sleepHistory.add(SleepData(
      date: _wakeUpTime!,
      duration: _sleepDuration!,
    ));

    await _saveSleepData();

    _sleepStartTime = null;
    _wakeUpTime = null;
    _elapsedTime = Duration.zero;
    notifyListeners();
  }

  void selectDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  List<SleepData> getSleepDataForSelectedDate() {
    return _sleepHistory.where((data) {
      return data.date.year == _selectedDate.year &&
          data.date.month == _selectedDate.month &&
          data.date.day == _selectedDate.day;
    }).toList();
  }

  String formatDuration(Duration duration) {
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  void _loadSleepHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final historyData = prefs.getStringList('sleepHistory') ?? [];

    _sleepHistory = historyData.map((data) {
      final splitData = data.split('|');
      return SleepData(
        date: DateTime.parse(splitData[0]),
        duration: Duration(seconds: int.parse(splitData[1])),
      );
    }).toList();

    notifyListeners();
  }

  Future<void> _saveSleepData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final historyData = _sleepHistory.map((data) {
      return '${data.date.toIso8601String()}|${data.duration.inSeconds}';
    }).toList();

    await prefs.setStringList('sleepHistory', historyData);
  }
}

class SleepData {
  final DateTime date;
  final Duration duration;

  SleepData({required this.date, required this.duration});
}
