import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AccountSettingsTab extends StatefulWidget {
  const AccountSettingsTab({super.key});

  @override
  _AccountSettingsTabState createState() => _AccountSettingsTabState();
}

class _AccountSettingsTabState extends State<AccountSettingsTab> {
  File? _profileImage;
  String _profileName = 'Name123';
  String _email = 'TXXXXXXXXXX@xyz.com';
  String _role = 'Content Creator';
  String _password = '*********';

  @override
  Widget build(BuildContext context) {
    // return Padding(
    //   padding: const EdgeInsets.all(8.0),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
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
                  Text('Account Settings', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  _buildProfilePictureSection(context),
                  const SizedBox(height: 20),
                  _buildProfileField(context, 'Profile Name', _profileName, () {
                    _showEditDialog(context, 'Profile Name', _profileName, (value) {
                      setState(() {
                        _profileName = value;
                      });
                    });
                  }),
                  _buildProfileField(context, 'Email ID', _email, () {
                    _showEditDialog(context, 'Email ID', _email, (value) {
                      setState(() {
                        _email = value;
                      });
                    });
                  }),
                  _buildProfileField(context, 'Role', _role, () {
                    _showRoleSelectionDialog(context);
                  }),
                  _buildProfileField(context, 'Password', _password, () {
                    _showEditDialog(context, 'Password', '', (value) {
                      setState(() {
                        _password = value;
                      });
                    }, isPassword: true);
                  }),
                  _buildCurrentPlanSection(context),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          // Handle cancel action
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 28),
                          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Cancel'),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: () {
                          // Handle save settings action
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 28),
                          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
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

  Widget _buildProfilePictureSection(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: MediaQuery.of(context).size.width < 600 ? 24 : 30, // Responsive size
          backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
          child: _profileImage == null ? Text('T', style: TextStyle(fontSize: MediaQuery.of(context).size.width < 600 ? 20 : 30, fontWeight: FontWeight.bold)) : null,
        ),
        const SizedBox(width: 20),
        ElevatedButton(
          onPressed: () {
            _selectProfilePicture(context);
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            textStyle: const TextStyle(fontSize: 14),
          ),
          child: const Text('Add'),
        ),
        const SizedBox(width: 10),
        OutlinedButton(
          onPressed: () {
            _removeProfilePicture();
          },
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            textStyle: const TextStyle(fontSize: 14),
          ),
          child: const Text('Remove'),
        ),
      ],
    );
  }

  Widget _buildProfileField(BuildContext context, String label, String value, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey[600])),
              Text(value, style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              textStyle: const TextStyle(fontSize: 14),
            ),
            child: const Text('Change'),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentPlanSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Current Plan', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey[600])),
              const Text('Product AI Free Version', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              _navigateToBillingTab(context);
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              textStyle: const TextStyle(fontSize: 14),
            ),
            child: const Row(
              children: [
                Icon(Icons.upgrade, size: 20),
                SizedBox(width: 6),
                Text('Upgrade plan'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToBillingTab(BuildContext context) {
    final tabController = DefaultTabController.of(context);
    tabController.animateTo(2); // Switch to the Billing tab
  }

  void _selectProfilePicture(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  void _removeProfilePicture() {
    setState(() {
      _profileImage = null;
    });
  }

  void _showEditDialog(BuildContext context, String field, String currentValue, ValueChanged<String> onSave, {bool isPassword = false}) {
    final TextEditingController controller = TextEditingController(text: currentValue);

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400), // Constrain the width
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Edit $field', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                TextField(
                  controller: controller,
                  obscureText: isPassword,
                  decoration: InputDecoration(
                    labelText: field,
                    hintText: isPassword ? 'Enter new password' : 'Enter new $field',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel', style: TextStyle(fontSize: 16)),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        onSave(controller.text);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Save', style: TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showRoleSelectionDialog(BuildContext context) {
    String selectedRole = _role;
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400), // Constrain the width
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Select Role', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                DropdownButton<String>(
                  value: selectedRole,
                  items: const [
                    DropdownMenuItem(value: 'Content Creator', child: Text('Content Creator')),
                    DropdownMenuItem(value: 'Viewer', child: Text('Viewer')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedRole = value!;
                    });
                  },
                  isExpanded: true,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel', style: TextStyle(fontSize: 16)),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _role = selectedRole;
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Save', style: TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showUpgradePlanDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400), // Constrain the width
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Upgrade Plan', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                const Text('Select a new plan to upgrade.', style: TextStyle(fontSize: 16)),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel', style: TextStyle(fontSize: 16)),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        // Handle plan upgrade
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Upgrade', style: TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
