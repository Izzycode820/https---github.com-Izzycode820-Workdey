import 'package:flutter/services.dart';

class CameroonPhoneFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Allow complete deletion
    if (newValue.text.isEmpty) return newValue;

    // Remove all non-digit characters
    final digits = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    // If user is trying to delete the prefix, prevent it
    if (newValue.text.length < oldValue.text.length && 
        oldValue.text.startsWith('+237') && 
        newValue.text.length <= 4) {
      return oldValue;
    }

    String formatted = '+237 ';
    
    // Format the remaining digits (after 237)
    if (digits.length > 3) {
      final remainingDigits = digits.substring(3);
      formatted += _formatCameroonNumber(remainingDigits);
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  String _formatCameroonNumber(String digits) {
    if (digits.isEmpty) return '';
    if (digits.length <= 3) return digits;
    if (digits.length <= 5) return '${digits.substring(0, 3)} ${digits.substring(3)}';
    if (digits.length <= 7) return '${digits.substring(0, 3)} ${digits.substring(3, 5)} ${digits.substring(5)}';
    return '${digits.substring(0, 3)} ${digits.substring(3, 5)} ${digits.substring(5, 7)} ${digits.substring(7)}';
  }

  static String getCompressedNumber(String formattedNumber) {
    return formattedNumber.replaceAll(' ', '');
  }
}