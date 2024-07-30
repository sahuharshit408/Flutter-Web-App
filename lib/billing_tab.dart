import 'package:flutter/material.dart';

class BillingTab extends StatefulWidget {
  const BillingTab({super.key});

  @override
  _BillingTabState createState() => _BillingTabState();
}

class _BillingTabState extends State<BillingTab> {
  String _currentPlan = 'FREE'; // Default plan
  String _selectedPlan = 'FREE';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Billing', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            _buildCurrentPlanSection(),
            const SizedBox(height: 30),
            _buildPlansSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentPlanSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'You are using the $_currentPlan VERSION of Product',
              style: TextStyle(color: Colors.grey[600]),
            ),
            ElevatedButton(
              onPressed: () {
                _showUpgradePlanDialog(context);
              },
              child: const Text('Upgrade Plan'),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Monthly Credits Left', style: TextStyle(color: Colors.grey[600])),
            Text(
              _currentPlan == 'Pro' || _currentPlan == 'Premium' ? 'Unlimited' : '150 of 200',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPlansSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Plans', style: Theme.of(context).textTheme.headline6?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Table(
          border: TableBorder.all(color: Colors.grey),
          columnWidths: const {
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(2),
            2: FlexColumnWidth(2),
            3: FlexColumnWidth(2),
          },
          children: [
            TableRow(children: [
              _buildTableCell('Features', isHeader: true),
              _buildTableCell('Free', isHeader: true),
              _buildTableCell('Pro', isHeader: true),
              _buildTableCell('Premium', isHeader: true),
            ]),
            TableRow(children: [
              _buildTableCell('Credits'),
              _buildTableCell('Limited (200 monthly)'),
              _buildTableCell('Unlimited'),
              _buildTableCell('Unlimited'),
            ]),
            TableRow(children: [
              _buildTableCell('Resolution'),
              _buildTableCell('360p, 720p'),
              _buildTableCell('1080p'),
              _buildTableCell('2160p'),
            ]),
            TableRow(children: [
              _buildTableCell('Images'),
              _buildTableCell('AI Generated'),
              _buildTableCell('AI Generated, Manual'),
              _buildTableCell('AI Generated, Manual'),
            ]),
            TableRow(children: [
              _buildTableCell('Export Formats'),
              _buildTableCell('PNG'),
              _buildTableCell('PNG, WEBP'),
              _buildTableCell('PNG, JPEG, WEBP'),
            ]),
            TableRow(children: [
              _buildTableCell(''),
              _buildTableCell(''),
              _buildTableCellWithButton('Upgrade to PRO'),
              _buildTableCellWithButton('Upgrade to Premium'),
            ]),
          ],
        ),
      ],
    );
  }

  Widget _buildTableCell(String text, {bool isHeader = false}) {
    return Container(
      color: isHeader ? Colors.black54 : Colors.transparent,
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: isHeader
            ? const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)
            : const TextStyle(fontSize: 14),
      ),
    );
  }

  Widget _buildTableCellWithButton(String buttonText) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          _showUpgradePlanDialog(context);
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blueAccent,
        ),
        child: Text(buttonText),
      ),
    );
  }

  void _showUpgradePlanDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Plan'),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RadioListTile<String>(
                    title: const Text('Pro - \$9.99/month'),
                    value: 'Pro',
                    groupValue: _selectedPlan,
                    onChanged: (value) {
                      setState(() {
                        _selectedPlan = value!;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('Premium - \$29.99/month'),
                    value: 'Premium',
                    groupValue: _selectedPlan,
                    onChanged: (value) {
                      setState(() {
                        _selectedPlan = value!;
                      });
                    },
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _currentPlan = _selectedPlan;
                });
                Navigator.pop(context);
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: Scaffold(
      body: BillingTab(),
    ),
  ));
}
