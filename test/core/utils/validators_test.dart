import 'package:coach_app/core/utils/validators.dart';
import 'package:coach_app/l10n/app_localizations_en.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final l10n = AppLocalizationsEn();

  group('Validators.email', () {
    final validate = Validators.email(l10n);

    test('rejects empty input', () {
      expect(validate(''), l10n.validationRequired);
    });

    test('rejects malformed addresses', () {
      expect(validate('alex@'), l10n.validationEmail);
      expect(validate('alex example.com'), l10n.validationEmail);
    });

    test('accepts valid addresses, ignoring surrounding spaces', () {
      expect(validate(' alex@example.com '), isNull);
    });
  });

  group('Validators.password', () {
    final validate = Validators.password(l10n);

    test('requires the minimum length', () {
      expect(validate('short'), l10n.validationPasswordLength(8));
      expect(validate('long enough'), isNull);
    });
  });

  group('Validators.confirmPassword', () {
    test('compares against the latest original value', () {
      var original = 'first-password';
      final validate = Validators.confirmPassword(l10n, () => original);

      expect(validate('first-password'), isNull);
      original = 'changed-password';
      expect(validate('first-password'), l10n.validationPasswordMismatch);
    });
  });

  group('Validators.otp', () {
    final validate = Validators.otp(l10n);

    test('accepts exactly six digits', () {
      expect(validate('123456'), isNull);
      expect(validate('12345'), l10n.validationOtp(6));
      expect(validate('12345a'), l10n.validationOtp(6));
    });
  });
}
