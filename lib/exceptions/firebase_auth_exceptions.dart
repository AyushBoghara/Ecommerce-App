class TFirebaseAuthException implements Exception {
  final String code;

  TFirebaseAuthException(this.code);

  String get message {
    switch (code) {
      case 'email-already-in-use':
        return 'The email address is already registered. Please use a different email.';

      case 'invalid-email':
        return 'The email address provided is invalid. Please enter a valid email. ';

      case 'weak-password':
        return 'The password is too weak. Please choose a stronger password.';

      case 'user-not-found':
        return 'No user found with this email. Please check the email or sign up.';

      case 'wrong-password':
        return 'Incorrect password. Please try again.';

      case 'too-many-requests':
        return 'Too many login attempts. Try again later or reset your password.';

      case 'network-request-failed':
        return 'Network error. Please check your internet connection.';

      case 'user-disabled':
        return 'This user account has been disabled. Contact support for help.';

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

      default:
        return 'An unknown error occurred. Please try again.';
    }
  }
}
