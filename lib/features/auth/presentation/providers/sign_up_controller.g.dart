// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Submission state of the sign-up form: idle, loading, or error(Failure).

@ProviderFor(SignUpController)
final signUpControllerProvider = SignUpControllerProvider._();

/// Submission state of the sign-up form: idle, loading, or error(Failure).
final class SignUpControllerProvider
    extends $AsyncNotifierProvider<SignUpController, void> {
  /// Submission state of the sign-up form: idle, loading, or error(Failure).
  SignUpControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'signUpControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$signUpControllerHash();

  @$internal
  @override
  SignUpController create() => SignUpController();
}

String _$signUpControllerHash() => r'8567d770d07b2622aff863201c406923bfd8529d';

/// Submission state of the sign-up form: idle, loading, or error(Failure).

abstract class _$SignUpController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
