import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:travel/core/utils/locales.dart';
import 'package:travel/modules/locale/controllers/locale_controller.dart';

class LanguageBottomSheet extends GetWidget<LocaleController> {
  const LanguageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Gap(8),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'choose language'.tr,
            style: Get.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(24),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: languages.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final language = languages[index];
              return Obx(() => ListTile(
                    onTap: () => controller.languageCode(language['code']!),
                    leading: Text(
                      language['flag']!,
                      style: const TextStyle(fontSize: 24),
                    ),
                    title: Text(
                      language['name']!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(language['native']!),
                    trailing: controller.languageCode.value == language['code']
                        ? const Icon(Icons.check_circle, color: Colors.blue)
                        : null,
                  ));
            },
          ),
          const Gap(16),
          Obx(() => ElevatedButton(
                onPressed: controller.languageCode.value.isNotEmpty
                    ? () => Get.back()
                    : null,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text('Continue'.tr),
              )),
          const Gap(16),
        ],
      ),
    );
  }
}
