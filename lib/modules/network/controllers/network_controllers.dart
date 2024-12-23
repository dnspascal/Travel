import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:travel/core/enums/network_enum.dart';
import 'package:travel/domains/entities/network.dart';

class NetworkController extends GetxController {
  final _networkState = NetworkState(
    status: NetworkStatus.offline,
    type: NetworkType.none,
    connectionSpeed: 0,
    lastChecked: DateTime.now(),
  ).obs;

  final _isRetrying = false.obs;
  final _isExpanded = false.obs;

  NetworkState get networkState => _networkState.value;
  bool get isRetrying => _isRetrying.value;
  bool get isExpanded => _isExpanded.value;

  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  Timer? _checkTimer;

  @override
  void onInit() {
    super.onInit();
    checkConnection();
    _startPeriodicCheck();
    _subscribeToConnectivityChanges();
  }

  void _startPeriodicCheck() {
    _checkTimer?.cancel();
    _checkTimer = Timer.periodic(
      Duration(seconds: networkState.status == NetworkStatus.unstable ? 10 : 30),
      (_) => checkConnection(),
    );
  }

  Future<void> checkConnection() async {
    try {
      _isRetrying.value = true;
      final results = await _connectivity.checkConnectivity();
      // Handle the first result, or none if the list is empty
      final primaryResult = results.isNotEmpty ? results.first : ConnectivityResult.none;
      _updateNetworkState(primaryResult);
    } catch (e) {
      print('Error checking connection: $e');
      _networkState.value = _networkState.value.copyWith(
        status: NetworkStatus.error,
        type: NetworkType.none,
        lastChecked: DateTime.now(),
      );
    } finally {
      _isRetrying.value = false;
      _startPeriodicCheck();
    }
  }

  void _subscribeToConnectivityChanges() {
    _connectivitySubscription?.cancel();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      (results) {
        final primaryResult = results.isNotEmpty ? results.first : ConnectivityResult.none;
        _updateNetworkState(primaryResult);
      },
      onError: (error) {
        print('Error in connectivity listener: $error');
        _networkState.value = _networkState.value.copyWith(
          status: NetworkStatus.error,
          type: NetworkType.none,
          lastChecked: DateTime.now(),
        );
      },
    );
  }

  void _updateNetworkState(ConnectivityResult result) {
    final networkType = _mapConnectivityResult(result);
    _networkState.value = _networkState.value.copyWith(
      status: networkType != NetworkType.none
          ? NetworkStatus.connected
          : NetworkStatus.offline,
      type: networkType,
      lastChecked: DateTime.now(),
    );
  }

  NetworkType _mapConnectivityResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        return NetworkType.wifi;
      case ConnectivityResult.mobile:
        return NetworkType.mobile;
      case ConnectivityResult.ethernet:
        return NetworkType.ethernet;
      case ConnectivityResult.bluetooth:
        return NetworkType.bluetooth;
      case ConnectivityResult.vpn:
        return NetworkType.vpn;
      case ConnectivityResult.none:
      case ConnectivityResult.other:
        return NetworkType.none;
    }
  }

  void toggleExpanded() {
    _isExpanded.value = !_isExpanded.value;
  }

  @override
  void onClose() {
    _checkTimer?.cancel();
    _connectivitySubscription?.cancel();
    super.onClose();
  }
}