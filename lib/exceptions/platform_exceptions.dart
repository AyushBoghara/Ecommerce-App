class TPlatformException implements Exception {
  final String code;

  TPlatformException(this.code);

  String get message {
    switch (code) {
      case 'INVALID_LOGIN_CREDENTIALS':
        return 'Invalid login credentials. Please check your email and password.';

      case 'invalid-password':
        return 'Invalid password. Please enter the correct password.';

      case 'user-not-found':
        return 'No user found with this email. Please sign up.';

      case 'uid-already-exists':
        return 'The provided UID already exists. Please use a different UID.';

      case 'email-already-exists':
        return 'This email is already in use. Please use a different email.';

      case 'account-exists-with-different-credential':
        return 'An account with this email exists using a different sign-in method.';

      case 'requires-recent-login':
        return 'This operation requires recent login. Please log in again.';

      case 'too-many-requests':
        return 'Too many login attempts. Please try again later.';

      case 'unauthorized-domain':
        return 'This domain is not authorized for authentication.';

      case 'operation-not-allowed':
        return 'This authentication method is not enabled. Contact support.';

      case 'user-disabled':
        return 'This account has been disabled. Contact support.';

      case 'invalid-verification-code':
        return 'Invalid verification code. Please enter the correct code.';

      case 'invalid-verification-id':
        return 'Invalid verification ID. Please request a new code.';

      /// 🔹 **Network & Connectivity Errors**
      case 'internet-error':
        return 'No internet connection. Please check your network.';

      case 'network-request-failed':
        return 'Network error. Please try again.';

      case 'timeout':
        return 'Request timed out. Please try again.';

      case 'quota-exceeded':
        return 'Service quota exceeded. Try again later.';

      case 'server-unavailable':
        return 'Server is temporarily unavailable. Please try again later.';

      /// 🔹 **Database & Firestore Errors**
      case 'permission-denied':
        return 'You do not have permission to access this resource.';

      case 'document-not-found':
        return 'Requested document was not found.';

      case 'invalid-argument':
        return 'Invalid argument provided. Please check your input.';

      case 'data-loss':
        return 'Data loss detected. Please report this issue.';

      case 'failed-precondition':
        return 'Operation failed due to an invalid precondition.';

      /// 🔹 **Storage Errors**
      case 'object-not-found':
        return 'File not found in Firebase Storage.';

      case 'bucket-not-found':
        return 'Storage bucket does not exist.';

      case 'project-not-found':
        return 'Firebase project was not found.';

      case 'unauthenticated':
        return 'User is not authenticated.';

      /// 🔹 **Other Firebase & Platform Errors**
      case 'invalid-credential':
        return 'Invalid credentials provided. Please check and try again.';

      case 'session-expired':
        return 'Session has expired. Please log in again.';

      case 'app-not-authorized':
        return 'This app is not authorized to use Firebase Authentication.';

      case 'keychain-error':
        return 'A Keychain error occurred. Restart your device and try again.';

      case 'tenant-id-mismatch':
        return 'Tenant ID does not match the expected value.';

      case 'unsupported-platform':
        return 'This feature is not supported on your current platform.';

      case 'internal-error':
        return 'An internal server error occurred. Please try again later.';

      default:
        return 'An unknown platform error occurred. Please check your input and try again.';
    }
  }
}
