import 'package:coach_app/app.dart';
import 'package:coach_app/core/storage/secure_storage.dart';
import 'package:coach_app/core/widgets/widgets.dart';
import 'package:coach_app/features/auth/data/datasources/auth_mock_data_source.dart';
import 'package:coach_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:coach_app/features/auth/presentation/screens/login_screen.dart';
import 'package:coach_app/features/home/presentation/screens/home_screen.dart';
import 'package:coach_app/features/profile/presentation/screens/profile_screen.dart';
import 'package:coach_app/l10n/app_localizations_en.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/fake_secure_storage.dart';

void main() {
  final l10n = AppLocalizationsEn();

  testWidgets('login → tabs → logout → login', (tester) async {
    final storage = FakeSecureStorage();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          secureStorageProvider.overrideWithValue(storage),
          authRemoteDataSourceProvider.overrideWithValue(
            AuthMockDataSource(latency: Duration.zero),
          ),
        ],
        child: const CoachApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(LoginScreen), findsOneWidget);

    Finder field(String label) => find.descendant(
      of: find.widgetWithText(AppTextField, label),
      matching: find.byType(TextFormField),
    );
    await tester.enterText(field(l10n.emailLabel), 'alex@example.com');
    await tester.enterText(field(l10n.passwordLabel), 'password1');
    await tester.tap(find.text(l10n.loginButton));
    await tester.pumpAndSettle();

    expect(find.byType(HomeScreen), findsOneWidget);
    expect(find.byType(AppBottomNavBar), findsOneWidget);
    expect(storage.values, isNotEmpty);

    await tester.tap(find.text(l10n.tabProfile));
    await tester.pumpAndSettle();
    expect(find.byType(ProfileScreen), findsOneWidget);
    expect(find.text('alex@example.com'), findsOneWidget);

    await tester.tap(find.text(l10n.logoutButton));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.logoutButton).last);
    await tester.pumpAndSettle();

    expect(find.byType(LoginScreen), findsOneWidget);
    expect(storage.values, isEmpty);
  });
}
