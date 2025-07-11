import 'package:currency_formatter/currency_formatter.dart';
import 'package:flutter/services.dart';
import 'package:haptext_api/exports.dart';

export 'package:flutter_svg/svg.dart';

extension StringExtension on String {
  String toCurrency({String sign = "₦"}) {
    CurrencyFormat nairaSettings = const CurrencyFormat(
        symbol: '₦',
        symbolSide: SymbolSide.left,
        thousandSeparator: ',',
        decimalSeparator: '.');
    String formatted =
        CurrencyFormatter.format(double.tryParse(this) ?? 0, nairaSettings);
    return formatted.replaceAll(' ', '');
  }

  String capitalizeFirstChar() {
    if (length > 0) {
      return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
    }
    return this;
  }

  void copyToClipboard(String successMessage) {
    Clipboard.setData(ClipboardData(
      text: this,
    )).then(
      (value) {
        ToastMessage.showSuccessToast(message: successMessage);
      },
    );
  }
}

// extension SvgExtension on String {
//   /// SVG with color
//   SvgPicture svg({Color? color, double? height, double? width, BoxFit? fit}) =>
//       SvgPicture.asset(
//         this,
//         fit: fit ?? BoxFit.scaleDown,
//         // ignore: deprecated_member_use
//         color: color,
//         height: height,
//         width: width,
//       );
// }

/// For validation
extension ValidatingExtensions on String {
  String? validateAnyField({String? field}) {
    if (toString().isEmpty) {
      return '$field field is required ';
    } else {
      return null;
    }
  }

  String? validateName({String? field}) {
    if (toString().isEmpty) {
      return '$field  is required ';
    } else if (toString().length < 3) {
      return 'Enter valid $field';
    } else {
      return null;
    }
  }

  String? validatePhoneNumber() {
    if (isEmpty) {
      return 'Phone number is required';
    }

    final pattern = RegExp(r'^\+?[0-9]{8,}$');

    if (!pattern.hasMatch(this)) {
      return 'Invalid phone number';
    } else if (length < 11) {
      return 'Invalid phone number';
    } else {
      return null;
    }
  }

  String? validateForm() {
    if (isEmpty) {
      return 'Fill the required form';
    }
    return null;
  }

  String? validateEmail() {
    if (toString().isEmpty) {
      return 'Email is required';
    }

    final pattern = RegExp(
      r"^((([a-zA-Z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-zA-Z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-zA-Z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-zA-Z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-zA-Z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-zA-Z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-zA-Z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-zA-Z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-zA-Z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$",
    );

    if (pattern.hasMatch(this)) {
      return null;
    } else {
      return 'Invalid email';
    }
  }

  String? validatePassword() {
    if (isEmpty) {
      return 'Password is required';
    }
    if (!RegExp(r'[-!@#$%^&*()_=+\[\]{}|;:",.<>/?]').hasMatch(this)) {
      return 'Password must contain at least one special character';
    }
    if (!RegExp(r'[A-Z]').hasMatch(this)) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!RegExp(r'[a-z]').hasMatch(this)) {
      return 'Password must contain at least one lowercase letter';
    }
    if (!RegExp(r'[0-9]').hasMatch(this)) {
      return 'Password must include at least one number';
    }

    if (length < 8) {
      return 'Password has to be longer than 6 characters';
    }

    return null;
  }
}

extension Initials on String {
  String generateAsterisks() {
    return '*' * length;
  }
}
