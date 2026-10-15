// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tenant_config.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(tenantConfig)
final tenantConfigProvider = TenantConfigProvider._();

final class TenantConfigProvider
    extends $FunctionalProvider<TenantConfig, TenantConfig, TenantConfig>
    with $Provider<TenantConfig> {
  TenantConfigProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tenantConfigProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tenantConfigHash();

  @$internal
  @override
  $ProviderElement<TenantConfig> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TenantConfig create(Ref ref) {
    return tenantConfig(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TenantConfig value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TenantConfig>(value),
    );
  }
}

String _$tenantConfigHash() => r'42c8112815dabdf48d906c3327e699cdb07cbfab';
