import 'package:flutter/material.dart';

class SettingsView extends StatefulWidget {
  static const routeName = '/settings';
  const SettingsView({super.key});

  @override
  SettingsViewState createState() => SettingsViewState();
}

class SettingsViewState extends State<SettingsView> {
  final FocusNode _firstOptionFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _firstOptionFocusNode.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> settingsOptions = [
      'Dark Mode',
      'Notifications',
      'Language',
      'Privacy',
      'Account',
    ];

    return Scaffold(
      body: ListView.builder(
        itemCount: settingsOptions.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: SettingsOptionCard(
              optionName: settingsOptions[index],
              focusNode: index == 0 ? _firstOptionFocusNode : FocusNode(),
            ),
          );
        },
      ),
    );
  }
}

class SettingsOptionCard extends StatefulWidget {
  final String optionName;
  final FocusNode focusNode;

  const SettingsOptionCard({
    super.key,
    required this.optionName,
    required this.focusNode,
  });

  @override
  SettingsOptionCardState createState() => SettingsOptionCardState();
}

class SettingsOptionCardState extends State<SettingsOptionCard> {
  late ValueNotifier<bool> _isFocusedNotifier;

  @override
  void initState() {
    super.initState();
    _isFocusedNotifier = ValueNotifier<bool>(false);
  }

  @override
  void dispose() {
    _isFocusedNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Focus(
      focusNode: widget.focusNode,
      onFocusChange: (hasFocus) {
        _isFocusedNotifier.value = hasFocus;
      },
      child: ValueListenableBuilder<bool>(
        valueListenable: _isFocusedNotifier,
        builder: (context, isFocused, child) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              color: isFocused ? colors.primary : colors.surfaceBright,
              border: Border.all(
                color: isFocused ? colors.primary : Colors.transparent,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: isFocused
                  ? [
                      BoxShadow(
                        color: colors.shadow.withOpacity(0.3),
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                        offset: const Offset(0, 5),
                      ),
                    ]
                  : [
                      BoxShadow(
                        color: colors.shadow.withOpacity(0.1),
                        blurRadius: 5.0,
                        offset: const Offset(0, 2),
                      ),
                    ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Icon(
                    Icons.settings,
                    color: isFocused ? colors.onPrimary : colors.onSurface,
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Text(
                      widget.optionName,
                      style: TextStyle(
                        color: isFocused ? colors.onPrimary : colors.onSurface,
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  if (isFocused)
                    Icon(
                      Icons.arrow_forward_ios,
                      color: colors.onPrimary,
                      size: 18.0,
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
