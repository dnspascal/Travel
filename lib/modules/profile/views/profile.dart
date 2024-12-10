import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class BusTicketProfile extends StatefulWidget {
  @override
  _BusTicketProfileState createState() => _BusTicketProfileState();
}

class _BusTicketProfileState extends State<BusTicketProfile> {
  bool isEditing = false;
  String activeSection = 'profile';
  ScrollController scrollController = ScrollController();

  Map<String, dynamic> profile = {
    'name': "Alex Thompson",
    'email': "alex.thompson@travel.com",
    'phone': "+1 (555) 123-4567",
    'memberID': "BT-2024-5678",
    'trips': 42,
    'lastTrip': "New York to Boston",
    'loyaltyPoints': 1250,
    'upcomingTrips': [
      {
        'id': 1,
        'from': "Boston",
        'to': "New York",
        'date': "2024-03-15",
        'time': "09:00 AM"
      },
      {
        'id': 2,
        'from': "New York",
        'to': "Philadelphia",
        'date': "2024-03-22",
        'time': "02:30 PM"
      }
    ]
  };

  late Map<String, dynamic> editProfile;
  int animatedTrips = 0;
  int animatedPoints = 0;

  @override
  void initState() {
    super.initState();
    editProfile = Map.from(profile);
    _startAnimations();
  }

  void _startAnimations() {
    Future.delayed(const Duration(milliseconds: 500), () {
      _animateTrips();
      _animatePoints();
    });
  }

  void _animateTrips() {
    if (animatedTrips < profile['trips']) {
      Future.delayed(const Duration(milliseconds: 10), () {
        setState(() {
          animatedTrips++;
        });
        _animateTrips();
      });
    }
  }

  void _animatePoints() {
    if (animatedPoints < profile['loyaltyPoints']) {
      Future.delayed(const Duration(milliseconds: 15), () {
        setState(() {
          animatedPoints += 10;
        });
        _animatePoints();
      });
    }
  }

  void _scrollToSection(String section) {
    switch (section) {
      case 'profile':
        scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        break;
      case 'trips':
        scrollController.animateTo(
          MediaQuery.of(context).size.height,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        break;
      case 'payment':
        scrollController.animateTo(
          MediaQuery.of(context).size.height * 2,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        break;
    }
  }

  void _handleSave() {
    setState(() {
      profile = Map.from(editProfile);
      isEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 227, 236, 244),
              Color.fromARGB(255, 245, 245, 245)
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              _buildHeader(),

              // Navigation Indicator
              // _buildNavigationIndicator(),

              // Scrollable Content
              Expanded(
                child: NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    if (scrollNotification is ScrollUpdateNotification) {
                      _updateActiveSection(scrollNotification.metrics.pixels);
                    }
                    return true;
                  },
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: [
                        _buildProfileSection(),
                        _buildTripsSection(),
                        _buildPaymentSection(),
                      ],
                    ),
                  ),
                ),
              ),

              // Quick Actions
              // _buildQuickActions(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            children: [
              Icon(LucideIcons.ticket, color: Color(0xFF0D47A1), size: 32),
              SizedBox(width: 8),
              Text(
                'My Profile',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D47A1),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () =>
                isEditing ? _handleSave() : setState(() => isEditing = true),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Color(0xFF0D47A1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isEditing ? LucideIcons.save : LucideIcons.edit,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: ['profile', 'trips', 'payment'].map((section) {
        return GestureDetector(
          onTap: () => _scrollToSection(section),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: activeSection == section
                  ? const Color(0xFF4338CA)
                  : const Color(0xFFBDE0FE),
              shape: BoxShape.circle,
            ),
          ),
        );
      }).toList(),
    );
  }

  void _updateActiveSection(double scrollPosition) {
    final screenHeight = MediaQuery.of(context).size.height;
    if (scrollPosition < screenHeight * 0.5) {
      setState(() => activeSection = 'profile');
    } else if (scrollPosition < screenHeight * 1.5) {
      setState(() => activeSection = 'trips');
    } else {
      setState(() => activeSection = 'payment');
    }
  }

  Widget _buildProfileSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Profile Image
          Container(
            width: 144,
            height: 144,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: const Center(
              child: Icon(
                LucideIcons.user,
                color: Color(0xFF0D47A1),
                size: 72,
              ),
            ),
          ),

          // Profile Details
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildProfileField(
                  LucideIcons.user,
                  'Full Name',
                  'name',
                ),
                _buildProfileField(
                  LucideIcons.mail,
                  'Email',
                  'email',
                ),
                _buildProfileField(
                  LucideIcons.phone,
                  'Phone',
                  'phone',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileField(IconData icon, String label, String key) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF0D47A1), size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                ),
                isEditing
                    ? TextFormField(
                        initialValue: editProfile[key],
                        onChanged: (value) {
                          setState(() {
                            editProfile[key] = value;
                          });
                        },
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFBDE0FE)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF0D47A1)),
                          ),
                        ),
                      )
                    : Text(
                        profile[key],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTripsSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Upcoming Trips',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF0D47A1),
                  ),
                ),
                Icon(LucideIcons.calendar, color: Color(0xFF0D47A1), size: 24),
              ],
            ),
            const SizedBox(height: 16),
            ...profile['upcomingTrips'].map<Widget>((trip) {
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF2FF),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${trip['from']} to ${trip['to']}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0D47A1),
                          ),
                        ),
                        Text(
                          '${trip['date']} | ${trip['time']}',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const Icon(LucideIcons.arrowRight,
                        color: Color(0xFF0D47A1)),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Payment Methods',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF0D47A1),
                  ),
                ),
                Icon(LucideIcons.creditCard,
                    color: Color(0xFF0D47A1), size: 24),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade800, Colors.blue.shade900],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Visa Card',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        '**** **** **** 4567',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Icon(LucideIcons.creditCard, color: Colors.white, size: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildQuickActions() {
  //   return Container(
  //     margin: EdgeInsets.all(16),
  //     padding: EdgeInsets.all(8),
  //     decoration: BoxDecoration(
  //       color: Colors.white.withOpacity(0.3),
  //       borderRadius: BorderRadius.circular(100),
  //     ),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
}
