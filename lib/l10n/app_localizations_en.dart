// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String accountEyebrow(String tenantName) {
    return '$tenantName account';
  }

  @override
  String get emailLabel => 'Email address';

  @override
  String get emailHint => 'you@example.com';

  @override
  String get passwordLabel => 'Password';

  @override
  String get passwordHint => 'Enter your password';

  @override
  String get newPasswordHint => 'At least 8 characters';

  @override
  String get confirmPasswordLabel => 'Confirm password';

  @override
  String get confirmPasswordHint => 'Repeat your password';

  @override
  String get fullNameLabel => 'Full name';

  @override
  String get fullNameHint => 'Alex Morgan';

  @override
  String get showPassword => 'Show password';

  @override
  String get hidePassword => 'Hide password';

  @override
  String get loginTitle => 'Welcome back.';

  @override
  String get loginButton => 'Log in';

  @override
  String get forgotPasswordLink => 'Forgot password?';

  @override
  String noAccountPrompt(String tenantName) {
    return 'New to $tenantName?';
  }

  @override
  String get createAccountLink => 'Create an account';

  @override
  String get signUpTitle => 'Make your first move.';

  @override
  String get signUpButton => 'Create account';

  @override
  String get acceptTerms => 'I agree to the terms and privacy policy';

  @override
  String get haveAccountPrompt => 'Already a member?';

  @override
  String get loginLink => 'Log in';

  @override
  String get forgotPasswordTitle => 'Reset your password.';

  @override
  String get forgotPasswordSubtitle =>
      'Enter your email to request a one-time code.';

  @override
  String get requestCodeButton => 'Request code';

  @override
  String get otpLabel => 'One-time code';

  @override
  String get otpHint => '6-digit code';

  @override
  String otpSentMessage(String email) {
    return 'We sent a code to $email.';
  }

  @override
  String get verifyCodeButton => 'Verify code';

  @override
  String get resendCodeButton => 'Request another code';

  @override
  String get codeResent => 'A new code is on its way.';

  @override
  String get changeEmailButton => 'Use a different email';

  @override
  String get newPasswordLabel => 'New password';

  @override
  String get newPasswordSubtitle =>
      'Choose a strong password you haven\'t used before.';

  @override
  String get savePasswordButton => 'Save password';

  @override
  String get passwordResetSuccess =>
      'Password updated. Log in with your new password.';

  @override
  String get backToLogin => 'Back to log in';

  @override
  String get validationRequired => 'This field is required';

  @override
  String get validationEmail => 'Enter a valid email address';

  @override
  String validationPasswordLength(int min) {
    return 'Use at least $min characters';
  }

  @override
  String get validationPasswordMismatch => 'Passwords don\'t match';

  @override
  String validationOtp(int length) {
    return 'Enter the $length-digit code';
  }

  @override
  String get validationAcceptTerms => 'Please accept the terms to continue';

  @override
  String get errorNetwork =>
      'You appear to be offline. Check your connection and try again.';

  @override
  String get errorUnauthorized =>
      'Your session has expired. Please log in again.';

  @override
  String get errorServer =>
      'Something went wrong on our side. Please try again shortly.';

  @override
  String get errorUnknown => 'Something went wrong. Please try again.';

  @override
  String get errorInvalidData => 'Please check the details and try again.';

  @override
  String get tabHome => 'Home';

  @override
  String get tabWallet => 'Wallet';

  @override
  String get tabMessages => 'Messages';

  @override
  String get tabContacts => 'Contacts';

  @override
  String get tabProfile => 'Profile';

  @override
  String greeting(String name) {
    return 'Hello $name.';
  }

  @override
  String get comingSoonTitle => 'Coming soon';

  @override
  String get comingSoonMessage =>
      'This section is being built and will arrive in an upcoming release.';

  @override
  String get walletEyebrow => 'Payments & passes';

  @override
  String get walletTitle => 'Your wallet.';

  @override
  String get messagesEyebrow => 'Support';

  @override
  String get messagesTitle => 'Messages.';

  @override
  String get contactsEyebrow => 'Your people';

  @override
  String get contactsTitle => 'Contacts.';

  @override
  String get profileEyebrow => 'Profile';

  @override
  String get profileTitle => 'Your profile.';

  @override
  String get logoutButton => 'Log out';

  @override
  String get logoutConfirmTitle => 'Log out?';

  @override
  String get logoutConfirmMessage =>
      'You\'ll need to log in again to access your account.';

  @override
  String get cancel => 'Cancel';

  @override
  String get poweredBy => 'Powered by';

  @override
  String appVersion(String version) {
    return 'Version $version';
  }
}
