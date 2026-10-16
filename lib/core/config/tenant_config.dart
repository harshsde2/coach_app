import 'dart:ui';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tenant_config.g.dart';

/// Values come from `--dart-define-from-file=config/tenants/<tenant>.json`,
/// so one codebase can ship a separately branded app per fibodo business.
class TenantConfig {
  const TenantConfig({
    required this.id,
    required this.name,
    required this.tagline,
    required this.brandPrimary,
    required this.brandSecondary,
    required this.onBrand,
  });

  factory TenantConfig.fromEnvironment() {
    return TenantConfig(
      id: const String.fromEnvironment('TENANT_ID', defaultValue: 'form'),
      name: const String.fromEnvironment('TENANT_NAME', defaultValue: 'FORM'),
      tagline: const String.fromEnvironment(
        'TENANT_TAGLINE',
        defaultValue: 'Move well. Get strong. Feel capable.',
      ),
      brandPrimary: _parseHex(
        const String.fromEnvironment(
          'TENANT_BRAND_PRIMARY',
          defaultValue: 'C8FF36',
        ),
      ),
      brandSecondary: _parseHex(
        const String.fromEnvironment(
          'TENANT_BRAND_SECONDARY',
          defaultValue: '95D813',
        ),
      ),
      onBrand: _parseHex(
        const String.fromEnvironment('TENANT_ON_BRAND', defaultValue: '111111'),
      ),
    );
  }

  final String id;
  final String name;
  final String tagline;
  final Color brandPrimary;
  final Color brandSecondary;

  final Color onBrand;

  String get initial => name.isEmpty ? '' : name[0].toUpperCase();

  static Color _parseHex(String hex) =>
      Color(int.parse('FF${hex.replaceFirst('#', '')}', radix: 16));
}

@Riverpod(keepAlive: true)
TenantConfig tenantConfig(Ref ref) => TenantConfig.fromEnvironment();
