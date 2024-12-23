import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:travel/core/enums/network_enum.dart';
import 'package:travel/core/theme/status_config.dart';
import 'package:travel/domains/entities/network.dart';
import 'package:travel/modules/network/controllers/network_controllers.dart';
import 'package:travel/modules/network/shared/status_indicator.dart';

class NetworkStatusNotification extends GetView<NetworkController> {
  const NetworkStatusNotification({super.key});

  StatusConfig _getStatusConfig(NetworkState state) {
    final configs = {
      NetworkStatus.offline: StatusConfig(
        icon: LucideIcons.wifiOff,
        gradient: const LinearGradient(
          colors: [Color(0xFFDC2626), Color(0xFFEF4444)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        textColor: Colors.white,
        pulseColor: Colors.transparent.withOpacity(0.1),
        message: state.type == NetworkType.none
            ? 'No connection'
            : 'No internet access',
        description: 'Check your WiFi or mobile data settings',
      ),
      NetworkStatus.connected: StatusConfig(
        icon: LucideIcons.wifi,
        gradient: const LinearGradient(
          colors: [Color(0xFF22C55E), Color(0xFF16A34A)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        textColor: Colors.white,
        pulseColor: Colors.transparent.withOpacity(0.1),
        message:
            'Connected to ${state.type == NetworkType.wifi ? 'WiFi' : 'Mobile Data'}',
        description: 'Your connection is stable.',
      ),
    };
    return configs[state.status]!;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final config = _getStatusConfig(controller.networkState);

      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: controller.isExpanded ? 96 : 48,
        child: Container(
          decoration: BoxDecoration(
            gradient: config.gradient,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              onTap: controller.toggleExpanded,
              child: Column(
                children: [
                  SizedBox(
                    height: 48,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          StatusIndicator(
                            icon: config.icon,
                            pulseColor: config.pulseColor,
                            iconColor: config.textColor,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              config.message,
                              style: TextStyle(
                                color: config.textColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (controller.isExpanded)
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            config.description,
                            style: TextStyle(
                              color: config.textColor.withOpacity(0.9),
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            'Last checked: ${controller.networkState.lastChecked.hour}:${controller.networkState.lastChecked.minute}',
                            style: TextStyle(
                              color: config.textColor.withOpacity(0.75),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
