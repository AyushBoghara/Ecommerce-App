class TFormatException implements Exception {
  final String message;

  /// Default constructor with a generic error message.
  TFormatException(
      [this.message =
          "An unexpected format error occurred. Please check your input."]);

  /// Factory constructor to create an exception from a message.
  factory TFormatException.fromMessage(String message) {
    return TFormatException(message);
  }

  /// Getter to return the formatted error message.
  String get formattedMessage => message;

  /// Factory constructor to create an exception from an error code.
  factory TFormatException.fromCode(String code) {
    switch (code) {
      case 'invalid-email-format':
        return TFormatException(
            'Invalid email format. Please enter a valid email address.');

      case 'invalid-date-format':
        return TFormatException('Invalid date format. Please use YYYY-MM-DD.');

      case 'invalid-numeric-format':
        return TFormatException(
            'Invalid number format. Only numeric values are allowed.');

      case 'invalid-phone-number-format':
        return TFormatException(
            'Invalid phone number format. Use the correct country code.');

      case 'invalid-url-format':
        return TFormatException(
            'Invalid URL format. Please enter a valid URL.');

      case 'invalid-json-format':
        return TFormatException(
            'Invalid JSON format. Please check your syntax.');

      case 'invalid-uuid-format':
        return TFormatException(
            'Invalid UUID format. It should be a valid UUID v4.');

      case 'invalid-hex-format':
        return TFormatException(
            'Invalid hexadecimal format. Use a valid hex value.');

      case 'invalid-ipv4-format':
        return TFormatException(
            'Invalid IPv4 address format. Example: 192.168.1.1.');

      case 'invalid-ipv6-format':
        return TFormatException(
            'Invalid IPv6 address format. Example: 2001:db8::ff00:42:8329.');

      case 'invalid-time-format':
        return TFormatException(
            'Invalid time format. Use HH:MM:SS (24-hour format).');

      case 'invalid-credit-card-format':
        return TFormatException(
            'Invalid credit card number format. Check your input.');

      case 'invalid-password-format':
        return TFormatException(
            'Invalid password format. Ensure it meets the required criteria.');

      case 'invalid-currency-format':
        return TFormatException(
            'Invalid currency format. Use symbols like , €, or £.');

      case 'invalid-base64-format':
        return TFormatException(
            'Invalid Base64 format. Check if it is correctly encoded.');

      case 'invalid-binary-format':
        return TFormatException(
            'Invalid binary format. Only 0s and 1s are allowed.');

      case 'invalid-file-extension':
        return TFormatException(
            'Invalid file extension. Only allowed formats are .jpg, .png, .pdf, etc.');

      case 'invalid-boolean-format':
        return TFormatException(
            'Invalid boolean format. Use "true" or "false".');

      case 'invalid-zip-code-format':
        return TFormatException(
            'Invalid ZIP code format. Please enter a valid postal code.');

      case 'invalid-social-security-number-format':
        return TFormatException(
            'Invalid SSN format. Check the correct pattern.');

      case 'invalid-country-code-format':
        return TFormatException(
            'Invalid country code format. Use correct international codes.');

      case 'invalid-html-format':
        return TFormatException(
            'Invalid HTML format. Please check for syntax errors.');

      default:
        return TFormatException(
            'Unknown format error. Please check your input.');
    }
  }
}
