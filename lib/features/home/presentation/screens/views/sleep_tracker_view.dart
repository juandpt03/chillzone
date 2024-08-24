// import 'package:chillzone/features/home/presentation/providers/providers.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class SleepTrackerView extends StatelessWidget {
//   const SleepTrackerView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final colors = Theme.of(context).colorScheme;
//     final size = MediaQuery.of(context).size;

//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(40.0),
//         child: Column(
//           children: [
//             const Expanded(
//               flex: 2,
//               child: Row(
//                 children: [
//                   CalendarComponent(),
//                   SizedBox(width: 40),
//                   SleepSummaryComponent(),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 40),
//             const SleepCounterComponent(),
//             const SizedBox(height: 40),
//             const Expanded(
//               flex: 2,
//               child: SleepHistoryComponent(),
//             ),
//             const SizedBox(height: 40),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 context.watch<SleepTrackerProvider>().sleepStartTime == null
//                     ? ElevatedButton(
//                         onPressed: context
//                             .read<SleepTrackerProvider>()
//                             .startSleepTracking,
//                         style: ElevatedButton.styleFrom(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 50, vertical: 20),
//                           backgroundColor: colors.primary,
//                         ),
//                         child: Text('Start Sleep',
//                             style: TextStyle(fontSize: size.height * 0.03)),
//                       )
//                     : ElevatedButton(
//                         onPressed: context
//                             .read<SleepTrackerProvider>()
//                             .stopSleepTracking,
//                         style: ElevatedButton.styleFrom(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 50, vertical: 20),
//                           backgroundColor: colors.error,
//                         ),
//                         child: Text('Stop Sleep',
//                             style: TextStyle(fontSize: size.height * 0.03)),
//                       ),
//                 ElevatedButton(
//                   onPressed: () => _showRecommendations(context),
//                   style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 50, vertical: 20),
//                     backgroundColor: colors.secondary,
//                   ),
//                   child: Text('View Recommendations',
//                       style: TextStyle(fontSize: size.height * 0.03)),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showRecommendations(BuildContext context) {
//     final model = context.read<SleepTrackerProvider>();
//     String recommendation;

//     if (model.elapsedTime.inHours < 7) {
//       recommendation =
//           'You had less sleep last night. Consider taking a nap today!';
//     } else {
//       recommendation =
//           'Great! You had a good amount of sleep. Stay active today!';
//     }

//     showDialog(
//       context: context,
//       builder: (context) {
//         final colors = Theme.of(context).colorScheme;
//         final size = MediaQuery.of(context).size;

//         return AlertDialog(
//           backgroundColor: colors.surface,
//           title: Text(
//             'Today\'s Recommendations',
//             style: TextStyle(fontSize: size.height * 0.03),
//           ),
//           content: Text(
//             recommendation,
//             style: TextStyle(fontSize: size.height * 0.025),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child:
//                   Text('OK', style: TextStyle(fontSize: size.height * 0.025)),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// class CalendarComponent extends StatelessWidget {
//   const CalendarComponent({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final model = context.watch<SleepTrackerProvider>();

//     return Expanded(
//       child: CalendarDatePicker(
//         initialDate: model.selectedDate,
//         firstDate: DateTime.now().subtract(const Duration(days: 365)),
//         lastDate: DateTime.now().add(const Duration(days: 365)),
//         onDateChanged: (date) {
//           model.selectDate(date);
//         },
//       ),
//     );
//   }
// }

// class SleepSummaryComponent extends StatelessWidget {
//   const SleepSummaryComponent({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final model = context.watch<SleepTrackerProvider>();
//     final sleepDataForSelectedDate = model.getSleepDataForSelectedDate();
//     final size = MediaQuery.of(context).size;

//     if (sleepDataForSelectedDate.isEmpty) {
//       return Text(
//         'No sleep data for selected date',
//         style: TextStyle(fontSize: size.height * 0.025),
//       );
//     }

//     final totalSleepDuration = sleepDataForSelectedDate
//         .map((data) => data.duration)
//         .reduce((a, b) => a + b);

//     return Column(
//       children: [
//         Text(
//           'You slept for ${totalSleepDuration.inHours} hours and ${totalSleepDuration.inMinutes % 60} minutes',
//           style: TextStyle(
//               fontSize: size.height * 0.035, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 20),
//         CircularProgressIndicator(
//           value: totalSleepDuration.inHours / 8,
//           strokeWidth: 10,
//           color: Theme.of(context).colorScheme.primary,
//         ),
//       ],
//     );
//   }
// }

// class SleepHistoryComponent extends StatelessWidget {
//   const SleepHistoryComponent({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final model = context.watch<SleepTrackerProvider>();
//     final sleepDataForSelectedDate = model.getSleepDataForSelectedDate();
//     final size = MediaQuery.of(context).size;

//     return Expanded(
//       child: ListView.builder(
//         itemCount: sleepDataForSelectedDate.length,
//         itemBuilder: (context, index) {
//           final sleepData = sleepDataForSelectedDate[index];
//           return ListTile(
//             title: Text(
//               'Time: ${model.formatDuration(sleepData.duration)}',
//               style: TextStyle(fontSize: size.height * 0.03),
//             ),
//             subtitle: Text(
//               'Duration: ${sleepData.duration.inHours} hours, ${sleepData.duration.inMinutes % 60} minutes',
//               style: TextStyle(fontSize: size.height * 0.025),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class SleepCounterComponent extends StatelessWidget {
//   const SleepCounterComponent({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final model = context.watch<SleepTrackerProvider>();
//     final size = MediaQuery.of(context).size;

//     return Column(
//       children: [
//         Text(
//           'Sleeping for:',
//           style: TextStyle(
//               fontSize: size.height * 0.035, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 20),
//         Text(
//           model.formatDuration(model.elapsedTime),
//           style: TextStyle(
//               fontSize: size.height * 0.07, fontWeight: FontWeight.bold),
//         ),
//       ],
//     );
//   }
// }
