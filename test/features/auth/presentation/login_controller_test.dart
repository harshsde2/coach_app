import 'package:coach_app/core/error/failure.dart';
import 'package:coach_app/core/utils/result.dart';
import 'package:coach_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:coach_app/features/auth/domain/entities/user.dart';
import 'package:coach_app/features/auth/presentation/providers/auth_controller.dart';
import 'package:coach_app/features/auth/presentation/providers/login_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/fakes.dart';

void main() {
  late MockAuthRepository repository;
  late ProviderContainer container;

  setUp(() async {
    repository = MockAuthRepository();
    when(() => repository.restoreSession())
        .thenAnswer((_) async => const Ok<User?>(null));
    container = ProviderContainer.test(
      overrides: [authRepositoryProvider.overrideWithValue(repository)],
    );
    // Session restored → signed out.
    await container.read(authControllerProvider.future);
    container.listen(loginControllerProvider, (_, _) {});
  });

  test('signs the user in on success', () async {
    when(
      () => repository.login(email: 'alex@example.com', password: 'password1'),
    ).thenAnswer((_) async => const Ok(testUser));

    await container
        .read(loginControllerProvider.notifier)
        .submit(email: 'alex@example.com', password: 'password1');

    expect(container.read(loginControllerProvider), isA<AsyncData<void>>());
    expect(container.read(currentUserProvider), testUser);
  });

  test('exposes the failure and stays signed out on error', () async {
    when(
      () => repository.login(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((_) async => const Err(ValidationFailure('Wrong password')));

    await container
        .read(loginControllerProvider.notifier)
        .submit(email: 'alex@example.com', password: 'nope');

    final state = container.read(loginControllerProvider);
    expect(state.error, isA<ValidationFailure>());
    expect(container.read(currentUserProvider), isNull);
  });
}
