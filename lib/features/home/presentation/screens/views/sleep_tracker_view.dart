import 'package:flutter/material.dart';

class SleepTrackerView extends StatefulWidget {
  const SleepTrackerView({super.key});

  @override
  SleepTrackerViewState createState() => SleepTrackerViewState();
}

class SleepTrackerViewState extends State<SleepTrackerView> {
  final List<FocusNode> _focusNodes = List.generate(5, (_) => FocusNode());
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNodes[0].requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: FocusTraversalGroup(
          policy: OrderedTraversalPolicy(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDateSelector(colors),
              const SizedBox(height: 20),
              _buildSleepTrackingCard(colors),
              const SizedBox(height: 20),
              _buildStatistics(colors),
              const SizedBox(height: 20),
              _buildGraphPlaceholder(colors),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateSelector(ColorScheme colors) {
    return Focus(
      focusNode: _focusNodes[0],
      onFocusChange: (hasFocus) => setState(() {}),
      child: GestureDetector(
        onTap: _selectDate,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${_selectedDate.day} ${_monthName(_selectedDate.month)}',
              style: TextStyle(
                color: _focusNodes[0].hasFocus ? colors.primary : Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(
              Icons.calendar_today,
              color: _focusNodes[0].hasFocus ? colors.primary : Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSleepTrackingCard(ColorScheme colors) {
    return Focus(
      focusNode: _focusNodes[1],
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: colors.primary.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            onPressed: () {},
            child: const Text('Start tracking'),
          ),
        ),
      ),
    );
  }

  Widget _buildStatistics(ColorScheme colors) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStatisticCard('Quality', '78%', colors.primary, 2),
        const SizedBox(width: 16),
        _buildStatisticCard('Duration', '7h 50m', colors.secondary, 3),
      ],
    );
  }

  Widget _buildStatisticCard(
      String title, String value, Color color, int index) {
    return Focus(
      focusNode: _focusNodes[index],
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGraphPlaceholder(ColorScheme colors) {
    return Expanded(
      child: Focus(
        focusNode: _focusNodes[4],
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: colors.primary.withOpacity(0.5),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: const Center(
            child: Text(
              'Weekly Sleep Graph',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _selectDate() {
    showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    ).then((pickedDate) {
      if (pickedDate != null && pickedDate != _selectedDate) {
        setState(() {
          _selectedDate = pickedDate;
        });
      }
    });
  }

  String _monthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }
}

class SimpleSleepTracker extends StatelessWidget {
  const SimpleSleepTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: FocusTraversalGroup(
          policy: OrderedTraversalPolicy(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Focus(
                child: GestureDetector(
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2025),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '18 August',
                        style:
                            Theme.of(context).textTheme.displaySmall?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                      ),
                      Icon(
                        Icons.calendar_today,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Focus(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text('Start tracking'),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Focus(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Quality',
                        style: TextStyle(color: Colors.white70, fontSize: 14.0),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '78%',
                        style: TextStyle(color: Colors.white, fontSize: 24.0),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Focus(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Duration',
                        style: TextStyle(color: Colors.white70, fontSize: 14.0),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '7h 50m',
                        style: TextStyle(color: Colors.white, fontSize: 24.0),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Focus(
                child: Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: const Center(
                      child: Text(
                        'Weekly Sleep Graph',
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
