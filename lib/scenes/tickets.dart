import 'package:flutter/material.dart';
import 'package:sucab/widgets/main_navigation_bar.dart';
import 'package:sucab/widgets/notification_button.dart';

class TicketsScreen extends StatefulWidget {
  const TicketsScreen({super.key});

  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  static const Color _backgroundColor = Color(0xFF202540);
  static const Color _panelColor = Color(0xFFF7F6F4);
  static const Color _mutedTextColor = Color(0xFFA5A8B6);
  static const Color _cardTextColor = Color(0xFF2C3040);

  bool _showOldTickets = false;

  final List<_ActiveTicket> _activeTickets = const [
    _ActiveTicket(
      origin: 'Kadikoy',
      destination: 'Sabiha Gokcen',
      departureTime: '2:30 PM',
      duration: '28 min',
      seatsFilled: 1,
      seatsTotal: 4,
      accentColor: Color(0xFF2ECC71),
      progressCount: 1,
    ),
    _ActiveTicket(
      origin: 'Campus',
      destination: 'Sabiha Gokcen',
      departureTime: '3:00 PM',
      duration: '35 min',
      seatsFilled: 3,
      seatsTotal: 4,
      accentColor: Color(0xFFF5A623),
      progressCount: 3,
    ),
    _ActiveTicket(
      origin: 'Taksim',
      destination: 'Campus',
      departureTime: '3:45 PM',
      duration: '20 min',
      seatsFilled: 2,
      seatsTotal: 4,
      accentColor: Color(0xFF4A90E2),
      progressCount: 2,
    ),
  ];

  final List<_ActiveTicket> _fullTickets = const [
    _ActiveTicket(
      origin: 'Campus',
      destination: 'Ataturk Airport',
      departureTime: '5:15 PM',
      duration: '55 min',
      seatsFilled: 4,
      seatsTotal: 4,
      accentColor: Color(0xFFEB5757),
      progressCount: 4,
    ),
  ];

  final List<_PastTicketSection> _pastTicketSections = const [
    _PastTicketSection(
      title: 'March 2026',
      tickets: [
        _PastTicket(
          origin: 'Campus',
          destination: 'Sabiha Gokcen',
          dateLabel: 'Mar 22',
          timeLabel: '7:00 AM',
          seatsFilled: 4,
          seatsTotal: 4,
          progressCount: 4,
          rating: 5,
        ),
        _PastTicket(
          origin: 'Taksim',
          destination: 'Campus',
          dateLabel: 'Mar 18',
          timeLabel: '9:30 PM',
          seatsFilled: 2,
          seatsTotal: 4,
          progressCount: 2,
          rating: 4,
        ),
        _PastTicket(
          origin: 'Kadikoy',
          destination: 'Campus',
          dateLabel: 'Mar 10',
          timeLabel: '3:15 PM',
          seatsFilled: 3,
          seatsTotal: 4,
          progressCount: 3,
          rating: 3,
        ),
      ],
    ),
    _PastTicketSection(
      title: 'February 2026',
      tickets: [
        _PastTicket(
          origin: 'Campus',
          destination: 'Sabiha Gokcen',
          dateLabel: 'Feb 28',
          timeLabel: '5:45 AM',
          seatsFilled: 4,
          seatsTotal: 4,
          progressCount: 4,
          rating: 4,
        ),
        _PastTicket(
          origin: 'Sabiha Gokcen',
          destination: 'Campus',
          dateLabel: 'Feb 14',
          timeLabel: '11:00 AM',
          seatsFilled: 2,
          seatsTotal: 4,
          progressCount: 2,
          rating: 5,
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: Transform.translate(
              offset: const Offset(0, -18),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                decoration: const BoxDecoration(
                  color: _panelColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(34),
                  ),
                ),
                child: _showOldTickets
                    ? _buildPastTicketsContent()
                    : _buildActiveTicketsContent(),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: _showOldTickets
          ? null
          : FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/new_ticket'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBarTheme(
          data: const BottomNavigationBarThemeData(
            backgroundColor: _backgroundColor,
            selectedItemColor: Colors.white,
            unselectedItemColor: Color(0xFF747B95),
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
            type: BottomNavigationBarType.fixed,
            elevation: 0,
          ),
          child: MainNavigationBar(
            context,
            currentIndex: 0,
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      height: 250,
      color: _backgroundColor,
      child: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            const _HeaderDecoration(),
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'SuCab',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _showOldTickets ? 'All past rides' : 'Your active rides',
                    style: const TextStyle(
                      color: Color(0xFFB0B4C6),
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 18),
                  _buildSegmentedControl(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSegmentedControl() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.10),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _SegmentButton(
            label: 'Active',
            selected: !_showOldTickets,
            onTap: () {
              setState(() {
                _showOldTickets = false;
              });
            },
          ),
          const SizedBox(width: 8),
          _SegmentButton(
            label: 'Old',
            selected: _showOldTickets,
            onTap: () {
              setState(() {
                _showOldTickets = true;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActiveTicketsContent() {
    return ListView(
      children: [
        Text(
          'TODAY . ${_activeTickets.length} ACTIVE RIDES',
          style: const TextStyle(
            color: _mutedTextColor,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.8,
          ),
        ),
        const SizedBox(height: 18),
        for (final ticket in _activeTickets) ...[
          _ActiveTicketCard(ticket: ticket),
          const SizedBox(height: 14),
        ],
        const SizedBox(height: 6),
        const _LabeledDivider(label: 'Full rides'),
        const SizedBox(height: 18),
        for (final ticket in _fullTickets) ...[
          _ActiveTicketCard(ticket: ticket),
          const SizedBox(height: 14),
        ],
        const SizedBox(height: 90),
      ],
    );
  }

  Widget _buildPastTicketsContent() {
    return ListView(
      children: [
        for (var i = 0; i < _pastTicketSections.length; i++) ...[
          if (i == 0)
            Text(
              _pastTicketSections[i].title.toUpperCase(),
              style: const TextStyle(
                color: _mutedTextColor,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.8,
              ),
            )
          else
            _LabeledDivider(label: _pastTicketSections[i].title),
          const SizedBox(height: 18),
          for (final ticket in _pastTicketSections[i].tickets) ...[
            _PastTicketCard(ticket: ticket),
            const SizedBox(height: 14),
          ],
          const SizedBox(height: 6),
        ],
        const SizedBox(height: 32),
      ],
    );
  }
}

class _SegmentButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _SegmentButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        width: 96,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(22),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: selected ? const Color(0xFF33384C) : const Color(0xFFC3C6D3),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _ActiveTicketCard extends StatelessWidget {
  final _ActiveTicket ticket;

  const _ActiveTicketCard({required this.ticket});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.72),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 74,
            decoration: BoxDecoration(
              color: ticket.accentColor,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              child: Row(
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: ticket.accentColor.withOpacity(0.14),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      Icons.local_taxi_outlined,
                      color: ticket.accentColor,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${ticket.origin} -> ${ticket.destination}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: _TicketsScreenState._cardTextColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${ticket.departureTime} . ${ticket.duration}',
                          style: const TextStyle(
                            color: Color(0xFF8E93A5),
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: List.generate(
                            ticket.seatsTotal,
                            (index) => Container(
                              width: 10,
                              height: 10,
                              margin: const EdgeInsets.only(right: 4),
                              decoration: BoxDecoration(
                                color: index < ticket.progressCount
                                    ? ticket.accentColor
                                    : const Color(0xFFD7D9E2),
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: ticket.accentColor.withOpacity(0.14),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.person_outline,
                              size: 15,
                              color: ticket.accentColor,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${ticket.seatsFilled}/${ticket.seatsTotal}',
                              style: TextStyle(
                                color: ticket.accentColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: ticket.accentColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PastTicketCard extends StatelessWidget {
  final _PastTicket ticket;

  const _PastTicketCard({required this.ticket});

  @override
  Widget build(BuildContext context) {
    const Color accentColor = Color(0xFFBEC3CF);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.60),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 74,
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              child: Row(
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: accentColor.withOpacity(0.16),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.local_taxi_outlined,
                      color: accentColor,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${ticket.origin} -> ${ticket.destination}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color(0xFF7E8394),
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${ticket.dateLabel} . ${ticket.timeLabel}',
                          style: const TextStyle(
                            color: Color(0xFFB0B4C2),
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: List.generate(
                            ticket.seatsTotal,
                            (index) => Container(
                              width: 10,
                              height: 10,
                              margin: const EdgeInsets.only(right: 4),
                              decoration: BoxDecoration(
                                color: index < ticket.progressCount
                                    ? accentColor
                                    : const Color(0xFFD9DCE4),
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: accentColor.withOpacity(0.14),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.person_outline,
                              size: 15,
                              color: accentColor,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${ticket.seatsFilled}/${ticket.seatsTotal}',
                              style: const TextStyle(
                                color: accentColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(
                          5,
                          (index) => Icon(
                            Icons.star_rounded,
                            size: 14,
                            color: index < ticket.rating
                                ? const Color(0xFFF2C94C)
                                : const Color(0xFFE2E5EC),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LabeledDivider extends StatelessWidget {
  final String label;

  const _LabeledDivider({required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            color: Color(0xFFE4E1DD),
            thickness: 1,
            endIndent: 12,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFFC7C3BE),
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Expanded(
          child: Divider(
            color: Color(0xFFE4E1DD),
            thickness: 1,
            indent: 12,
          ),
        ),
      ],
    );
  }
}

class _HeaderDecoration extends StatelessWidget {
  const _HeaderDecoration();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _CircleGlow(
          top: -20,
          left: -14,
          size: 92,
          opacity: 0.08,
        ),
        _CircleGlow(
          top: 8,
          left: 116,
          size: 92,
          opacity: 0.05,
        ),
        _CircleGlow(
          top: -24,
          right: 30,
          size: 110,
          opacity: 0.08,
        ),
        _CircleGlow(
          top: 52,
          right: -24,
          size: 136,
          opacity: 0.06,
        ),
        _CircleGlow(
          top: 64,
          left: 210,
          size: 70,
          opacity: 0.04,
        ),
      ],
    );
  }
}

class _CircleGlow extends StatelessWidget {
  final double? top;
  final double? left;
  final double? right;
  final double size;
  final double opacity;

  const _CircleGlow({
    this.top,
    this.left,
    this.right,
    required this.size,
    required this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(opacity),
        ),
      ),
    );
  }
}

class _ActiveTicket {
  final String origin;
  final String destination;
  final String departureTime;
  final String duration;
  final int seatsFilled;
  final int seatsTotal;
  final Color accentColor;
  final int progressCount;

  const _ActiveTicket({
    required this.origin,
    required this.destination,
    required this.departureTime,
    required this.duration,
    required this.seatsFilled,
    required this.seatsTotal,
    required this.accentColor,
    required this.progressCount,
  });
}

class _PastTicketSection {
  final String title;
  final List<_PastTicket> tickets;

  const _PastTicketSection({
    required this.title,
    required this.tickets,
  });
}

class _PastTicket {
  final String origin;
  final String destination;
  final String dateLabel;
  final String timeLabel;
  final int seatsFilled;
  final int seatsTotal;
  final int progressCount;
  final int rating;

  const _PastTicket({
    required this.origin,
    required this.destination,
    required this.dateLabel,
    required this.timeLabel,
    required this.seatsFilled,
    required this.seatsTotal,
    required this.progressCount,
    required this.rating,
  });
}