import 'package:coach_app/core/utils/result.dart';
import 'package:coach_app/core/widgets/widgets.dart';
import 'package:coach_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:coach_app/features/auth/domain/entities/user.dart';
import 'package:coach_app/features/auth/presentation/screens/login_screen.dart';
import 'package:coach_app/l10n/app_localizations_en.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/fakes.dart';
import '../../../helpers/pump_app.dart';

void main() {
  final l10n = AppLocalizationsEn();
  late MockAuthRepository repository;

  setUp(() {
    repository = MockAuthRepository();
    when(() => repository.restoreSession())
        .thenAnswer((_) async => const Ok<User?>(null));
  });

  Finder fieldLabelled(String label) => find.descendant(
    of: find.widgetWithText(AppTextField, label),
    matching: find.byType(TextFormField),
  );

  Future<void> pumpLogin(WidgetTester tester) => tester.pumpApp(
    const LoginScreen(),
    overrides: [authRepositoryProvider.overrideWithValue(repository)],
  );

  testWidgets('shows validation errors and does not submit an empty form', (
    tester,
  ) async {
    await pumpLogin(tester);

    await tester.tap(find.text(l10n.loginButton));
    await tester.pump();

    expect(find.text(l10n.validationRequired), findsWidgets);
    verifyNever(
      () => repository.login(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    );
  });

  testWidgets('submits the entered credentials', (tester) async {
    when(
      () => repository.login(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((_) async => const Ok(testUser));
    await pumpLogin(tester);

    await tester.enterText(fieldLabelled(l10n.emailLabel), 'alex@example.com');
    await tester.enterText(fieldLabelled(l10n.passwordLabel), 'password1');
    await tester.tap(find.text(l10n.loginButton));
    await tester.pump();

    verify(
      () => repository.login(email: 'alex@example.com', password: 'password1'),
    ).called(1);
  });
}
