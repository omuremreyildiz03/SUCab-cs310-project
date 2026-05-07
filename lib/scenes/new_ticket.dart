import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/ride_provider.dart';
import 'style_utils.dart';

class NewTicketScreen extends StatefulWidget {
  const NewTicketScreen({super.key});

  @override
  State<NewTicketScreen> createState() => _NewTicketScreenState();
}

class _NewTicketScreenState extends State<NewTicketScreen> {
  final _titleController = TextEditingController();
  final _fromController = TextEditingController();
  final _toController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _pickupController = TextEditingController();
  final _preferenceController = TextEditingController();
  int _seats = 1;

  @override
  void dispose() {
    _titleController.dispose();
    _fromController.dispose();
    _toController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _pickupController.dispose();
    _preferenceController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final title = _titleController.text.trim();
    final from = _fromController.text.trim();
    final to = _toController.text.trim();
    final date = _dateController.text.trim();
    final time = _timeController.text.trim();

    if (title.isEmpty || from.isEmpty || to.isEmpty || date.isEmpty || time.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields.')),
      );
      return;
    }

    final authProvider = context.read<AuthProvider>();
    final rideProvider = context.read<RideProvider>();
    final user = authProvider.userProfile;

    if (user == null) return;

    final success = await rideProvider.createRide(
      title: title,
      from: from,
      to: to,
      date: date,
      time: time,
      availableSeats: _seats,
      driverName: user.name,
      driverUid: user.uid,
      preference: _preferenceController.text.trim().isEmpty
          ? null
          : _preferenceController.text.trim(),
      pickupPoint: _pickupController.text.trim().isEmpty
          ? null
          : _pickupController.text.trim(),
    );

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ride created successfully!')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final rideProvider = context.watch<RideProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text('New Ride', style: AppTextStyles.heading),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildField(_titleController, 'Title *', 'Ride title'),
            _buildField(_fromController, 'From *', 'Departure point'),
            _buildField(_toController, 'To *', 'Destination'),
            _buildField(_dateController, 'Date *', 'e.g. May 10, 2026'),
            _buildField(_timeController, 'Time *', 'e.g. 08:30'),
            _buildField(_pickupController, 'Pickup Point', 'Optional'),
            _buildField(_preferenceController, 'Preferences', 'e.g. No smoking'),
            const SizedBox(height: 16),
            const Text('Available Seats for Passengers',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
            const SizedBox(height: 4),
            Text('(You are the driver — max 3 passengers)',
                style: TextStyle(color: AppColors.secondaryText, fontSize: 12)),
            const SizedBox(height: 8),
            Row(
              children: [
                IconButton(
                  onPressed: () =>
                      setState(() => _seats = (_seats - 1).clamp(1, 3)),
                  icon: const Icon(Icons.remove_circle_outline),
                ),
                Text('$_seats',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w700)),
                IconButton(
                  onPressed: () =>
                      setState(() => _seats = (_seats + 1).clamp(1, 3)),
                  icon: const Icon(Icons.add_circle_outline),
                ),
              ],
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: rideProvider.isLoading ? null : _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: rideProvider.isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                            color: Colors.white, strokeWidth: 2),
                      )
                    : const Text('Create', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(
      TextEditingController controller, String label, String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: AppColors.cardBackground,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
          ),
        ],
      ),
    );
  }
}
