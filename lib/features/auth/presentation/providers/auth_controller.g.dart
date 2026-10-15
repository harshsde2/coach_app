// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Source of truth for "who is signed in".
///
/// * loading → session is being restored (splash screen)
/// * data(User) → signed in
/// * data(null) → signed out
///
/// The router listens to this provider to guard routes, so signing in or
/// out anywhere automatically moves the user to the right screen.

@ProviderFor(AuthController)
final authControllerProvider = AuthControllerProvider._();

/// Source of truth for "who is signed in".
///
/// * loading → session is being restored (splash screen)
/// * data(User) → signed in
/// * data(null) → signed out
///
/// The router listens to this provider to guard routes, so signing in or
/// out anywhere automatically moves the user to the right screen.
final class AuthControllerProvider
    extends $AsyncNotifierProvider<AuthController, User?> {
  /// Source of truth for "who is signed in".
  ///
  /// * loading → session is being restored (splash screen)
  /// * data(User) → signed in
  /// * data(null) → signed out
  ///
  /// The router listens to this provider to guard routes, so signing in or
  /// out anywhere automatically moves the user to the right screen.
  AuthControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authControllerHash();

  @$internal
  @override
  AuthController create() => AuthController();
}

String _$authControllerHash() => r'1115331d1357c4be10e0e6d9028202fe5772949c';

/// Source of truth for "who is signed in".
///
/// * loading → session is being restored (splash screen)
/// * data(User) → signed in
/// * data(null) → signed out
///
/// The router listens to this provider to guard routes, so signing in or
/// out anywhere automatically moves the user to the right screen.

abstract class _$AuthController extends $AsyncNotifier<User?> {
  FutureOr<User?> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<User?>, User?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<User?>, User?>,
              AsyncValue<User?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// The signed-in user, or `null` when signed out or still loading.

@ProviderFor(currentUser)
final currentUserProvider = CurrentUserProvider._();

/// The signed-in user, or `null` when signed out or still loading.

final class CurrentUserProvider extends $FunctionalProvider<User?, User?, User?>
    with $Provider<User?> {
  /// The signed-in user, or `null` when signed out or still loading.
  CurrentUserProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentUserProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentUserHash();

  @$internal
  @override
  $ProviderElement<User?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  User? create(Ref ref) {
    return currentUser(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(User? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<User?>(value),
    );
  }
}

String _$currentUserHash() => r'b2e160ffdd8d9d24caea5b650fa95a7499a9094c';
