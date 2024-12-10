class ProfileModel {
  final String name;
  final String email;
  final String phone;
  final String memberID;
  final int trips;
  final String lastTrip;
  final int loyaltyPoints;
  final List<TripModel> upcomingTrips;

  ProfileModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.memberID,
    required this.trips,
    required this.lastTrip,
    required this.loyaltyPoints,
    required this.upcomingTrips,
  });

  ProfileModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? memberID,
    int? trips,
    String? lastTrip,
    int? loyaltyPoints,
    List<TripModel>? upcomingTrips,
  }) {
    return ProfileModel(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      memberID: memberID ?? this.memberID,
      trips: trips ?? this.trips,
      lastTrip: lastTrip ?? this.lastTrip,
      loyaltyPoints: loyaltyPoints ?? this.loyaltyPoints,
      upcomingTrips: upcomingTrips ?? this.upcomingTrips,
    );
  }
}

class TripModel {
  final int id;
  final String from;
  final String to;
  final String date;
  final String time;

  TripModel({
    required this.id,
    required this.from,
    required this.to,
    required this.date,
    required this.time,
  });
}