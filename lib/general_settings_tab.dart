import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GeneralSettingsTab extends StatefulWidget {
  final bool isDarkTheme;
  final ValueChanged<bool> onThemeChanged;

  const GeneralSettingsTab({
    super.key,
    required this.isDarkTheme,
    required this.onThemeChanged,
  });

  @override
  _GeneralSettingsTabState createState() => _GeneralSettingsTabState();
}

class _GeneralSettingsTabState extends State<GeneralSettingsTab> {
  late bool _isDarkTheme;
  bool _updatesEnabled = true;
  bool _recommendationsEnabled = false;
  String _selectedLanguage = 'English UK';

  @override
  void initState() {
    super.initState();
    _isDarkTheme = widget.isDarkTheme;
  }

  @override
  void didUpdateWidget(GeneralSettingsTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isDarkTheme != oldWidget.isDarkTheme) {
      setState(() {
        _isDarkTheme = widget.isDarkTheme;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // return Padding(
    //   padding: const EdgeInsets.all(8.0),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
          return SingleChildScrollView(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width < 600 ? 16.0 : 24.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'General Settings',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  _buildSwitchTile(
                    context,
                    'Dark Theme',
                    _isDarkTheme,
                        (bool value) {
                      setState(() {
                        _isDarkTheme = value;
                        widget.onThemeChanged(value);
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  _buildSwitchTile(
                    context,
                    'Email Updates',
                    _updatesEnabled,
                        (bool value) {
                      setState(() {
                        _updatesEnabled = value;
                      });
                    },
                  ),
                  _buildSwitchTile(
                    context,
                    'Email Recommendations',
                    _recommendationsEnabled,
                        (bool value) {
                      setState(() {
                        _recommendationsEnabled = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Language',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  _buildDropdown(
                    context,
                    _selectedLanguage,
                        (String? newValue) {
                      setState(() {
                        _selectedLanguage = newValue!;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _navigateToFeedbackForm(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width < 600 ? 12 : 16, horizontal: MediaQuery.of(context).size.width < 600 ? 24 : 32),
                      textStyle: TextStyle(fontSize: MediaQuery.of(context).size.width < 600 ? 14 : 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Feedback & Suggestions'),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          _showCancelConfirmation(context);
                        },
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width < 600 ? 12 : 16, horizontal: MediaQuery.of(context).size.width < 600 ? 24 : 32),
                          textStyle: TextStyle(fontSize: MediaQuery.of(context).size.width < 600 ? 14 : 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Cancel'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          _saveSettings();
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width < 600 ? 12 : 16, horizontal: MediaQuery.of(context).size.width < 600 ? 24 : 32),
                          textStyle: TextStyle(fontSize: MediaQuery.of(context).size.width < 600 ? 14 : 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Save Settings'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
    //     ],
    //   ),
    // );
  }

  Widget _buildSwitchTile(BuildContext context, String title, bool value, ValueChanged<bool> onChanged) {
    return SwitchListTile(
      title: Text(title, style: Theme.of(context).textTheme.bodyLarge),
      value: value,
      onChanged: onChanged,
    );
  }

  Widget _buildDropdown(BuildContext context, String selectedValue, ValueChanged<String?> onChanged) {
    return DropdownButton<String>(
      value: selectedValue,
      items: const [
        DropdownMenuItem(value: 'English UK', child: Text('English UK')),
        DropdownMenuItem(value: 'English US', child: Text('English US')),
        DropdownMenuItem(value: 'Hindi', child: Text('Hindi')),
      ],
      onChanged: onChanged,
      isExpanded: true,
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }

  void _navigateToFeedbackForm(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const FeedbackFormScreen(), // Placeholder for feedback form screen
      ),
    );
  }

  void _showCancelConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Cancel Changes'),
          content: const Text('Are you sure you want to discard changes?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // Implement any additional cancel logic if needed
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  void _saveSettings() {
    // Simulate saving settings
    Fluttertoast.showToast(
      msg: "Settings Saved!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    // Add actual save logic here
  }
}

// Placeholder feedback form screen
class FeedbackFormScreen extends StatelessWidget {
  const FeedbackFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Feedback Form')),
      body: const Center(
        child: Text('This is Feedback Form'),
      ),
    );
  }
}
