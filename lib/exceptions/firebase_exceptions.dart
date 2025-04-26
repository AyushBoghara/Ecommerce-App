class TFirebaseException implements Exception {
  final String code;

  TFirebaseException(this.code);

  String get message {
    switch (code) {
      case 'unknown':
        return 'An unknown error occurred. Please try again.';

      case 'invalid-custom-token':
        return 'The custom token format is invalid. Please check and try again.';

      case 'custom-token-mismatch':
        return 'The custom token is for a different Firebase project.';

      case 'user-disabled':
        return 'This user account has been disabled. Contact support for help.';

      case 'user-not-found':
        return 'No user found with this email. Please check or sign up.';

      case 'wrong-password':
        return 'Incorrect password. Please try again.';

      case 'email-already-in-use':
        return 'This email is already in use. Please try another one.';

      case 'invalid-email':
        return 'Invalid email format. Please enter a valid email.';

      case 'weak-password':
        return 'Weak password. Use at least 6 characters.';

      case 'operation-not-allowed':
        return 'This operation is not allowed. Contact support for assistance.';

      case 'requires-recent-login':
        return 'This operation requires recent login. Please log in again and try.';

      case 'provider-already-linked':
        return 'This provider is already linked to this account.';

      case 'credential-already-in-use':
        return 'This credential is already associated with another account.';

      case 'invalid-credential':
        return 'Invalid credential. Please try again.';

      case 'invalid-verification-code':
        return 'Invalid verification code. Please check and try again.';

      case 'invalid-verification-id':
        return 'Invalid verification ID. Please request a new one.';

      case 'session-expired':
        return 'Session expired. Please try again.';

      case 'too-many-requests':
        return 'Too many login attempts. Try again later.';

      case 'network-request-failed':
        return 'Network error. Please check your internet connection.';

      case 'app-not-authorized':
        return 'This app is not authorized to use Firebase Authentication.';

      case 'keychain-error':
        return 'A Keychain error occurred. Please restart your device and try again.';

      case 'tenant-id-mismatch':
        return 'Tenant ID does not match the expected value.';

      case 'timeout':
        return 'The request timed out. Please try again.';

      case 'quota-exceeded':
        return 'Quota exceeded. Try again later.';

      default:
        return 'An unexpected error occurred. Please try again.';
    }
  }
}
