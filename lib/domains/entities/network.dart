import 'package:travel/core/enums/network_enum.dart';

class NetworkState {
  final NetworkStatus status;
  final NetworkType type;
  final double connectionSpeed;
  final DateTime lastChecked;

  NetworkState({
    required this.status,
    required this.type,
    required this.connectionSpeed,
    required this.lastChecked,
  });

  NetworkState copyWith({
    NetworkStatus? status,
    NetworkType? type,
    double? connectionSpeed,
    DateTime? lastChecked,
  }) {
    return NetworkState(
      status: status ?? this.status,
      type: type ?? this.type,
      connectionSpeed: connectionSpeed ?? this.connectionSpeed,
      lastChecked: lastChecked ?? this.lastChecked,
    );
  }
}
