import 'package:coach_app/core/error/failure.dart';
import 'package:coach_app/l10n/app_localizations.dart';

extension FailureMessage on Failure {
  /// Prefers the server's message for validation errors (e.g. "Email already
  /// registered"); otherwise uses a localised generic message.
  String localizedMessage(AppLocalizations l10n) {
    return switch (this) {
      NetworkFailure() => l10n.errorNetwork,
      UnauthorizedFailure(:final message) => message ?? l10n.errorUnauthorized,
      ValidationFailure(:final message) => message ?? l10n.errorInvalidData,
      ServerFailure() => l10n.errorServer,
      UnknownFailure() => l10n.errorUnknown,
    };
  }
}
