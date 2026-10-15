import 'package:coach_app/core/error/failure.dart';
import 'package:coach_app/core/error/failure_message.dart';
import 'package:coach_app/core/utils/extensions/context_extensions.dart';
import 'package:coach_app/core/widgets/feedback/app_toast.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension AsyncValueUi on AsyncValue<void> {
  /// Use inside `ref.listen` to surface submission errors as a toast:
  ///
  /// ```dart
  /// ref.listen(
  ///   loginControllerProvider,
  ///   (_, state) => state.showErrorToast(context),
  /// );
  /// ```
  void showErrorToast(BuildContext context) {
    if (isLoading || !hasError) return;
    context.showFailureToast(error!);
  }
}

extension FailureToast on BuildContext {
  /// Shows [error] as a localised toast; unexpected errors get a generic text.
  void showFailureToast(Object error) {
    final message = error is Failure
        ? error.localizedMessage(l10n)
        : l10n.errorUnknown;
    showToast(message, type: ToastType.error);
  }
}
