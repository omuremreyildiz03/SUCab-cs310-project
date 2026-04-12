import 'package:flutter/material.dart';
import 'package:sucab/widgets/main_navigation_bar.dart';

class MyRidesScreen extends StatefulWidget {
  const MyRidesScreen({super.key});

  @override
  State<MyRidesScreen> createState() => _MyRidesScreenState();
}

class _MyRidesScreenState extends State<MyRidesScreen> {
  bool isJoinedSelected = true; // default tab

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 🔷 HEADER
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 60, bottom: 20),
            decoration: const BoxDecoration(
              color: Color(0xFF1E2A44),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(25),
              ),
            ),
            child: Column(
              children: [
                const Text(
                  "SuCab",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  "Your personal rides",
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 14),

                // 🔘 TOGGLE (TABS)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildToggleButton(
                      text: "Joined",
                      active: isJoinedSelected,
                      onTap: () {
                        setState(() {
                          isJoinedSelected = true;
                        });
                      },
                    ),
                    const SizedBox(width: 10),
                    _buildToggleButton(
                      text: "Created",
                      active: !isJoinedSelected,
                      onTap: () {
                        setState(() {
                          isJoinedSelected = false;
                        });
                      },
                    ),
                  ],
                )
              ],
            ),
          ),

          // ⚪ CONTENT AREA
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color(0xFFF5F6FA),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(25),
                ),
              ),
              child: _buildContent(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: MainNavigationBar(
        context,
        currentIndex: 1,
      ),
    );
  }

  // 📦 CONTENT SWITCHER
  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "ACTIVE",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),
        const SizedBox(height: 20),

        // ❗ EMPTY STATE (NO MOCK DATA)
        Expanded(
          child: Center(
            child: Text(
              isJoinedSelected
                  ? "You haven't joined any rides yet."
                  : "You haven't created any rides yet.",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}

// 🔘 Toggle Button
Widget _buildToggleButton({
  required String text,
  required bool active,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: active ? Colors.white : Colors.white24,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: active ? Colors.black : Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}