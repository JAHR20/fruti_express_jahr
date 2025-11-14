class Validators {
  static String? name(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingresa tu nombre';
    }
    if (value.trim().length < 2) {
      return 'El nombre debe tener al menos 2 caracteres';
    }
    final nameRegExp = RegExp(r"^[a-zA-ZÀ-ÿ\u00f1\u00d1\s]+$");
    if (!nameRegExp.hasMatch(value)) {
      return 'El nombre solo puede contener letras y espacios';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingresa tu correo electrónico';
    }
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Por favor ingresa un correo válido';
    }
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingresa tu número de teléfono';
    }

    final phoneRegExp = RegExp(r'^\d{10}$');
    if (!phoneRegExp.hasMatch(value.replaceAll(' ', '').replaceAll('-', ''))) {
      return 'Por favor ingresa un número de teléfono válido';
    }

    return null;
  }

  static String? required(String? value, [String? fieldName]) {
    if (value == null || value.trim().isEmpty) {
      return 'Por favor ingresa ${fieldName ?? 'este campo'}';
    }
    return null;
  }

  static String? _minLengthLogic(
    String? value,
    int minLength, [
    String? fieldName,
  ]) {
    if (value != null && value.isNotEmpty && value.length < minLength) {
      return '${fieldName ?? 'Este campo'} debe tener al menos $minLength caracteres';
    }
    return null;
  }

  static String? Function(String?) minLength(int length, [String? fieldName]) {
    return (String? value) => _minLengthLogic(value, length, fieldName);
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingresa tu contraseña';
    }

    if (value.length < 8) {
      return 'La contraseña debe tener al menos 8 caracteres';
    }

    final hasUppercase = RegExp(r'[A-Z]').hasMatch(value);
    final hasLowercase = RegExp(r'[a-z]').hasMatch(value);
    final hasNumbers = RegExp(r'[0-9]').hasMatch(value);
    final hasSpecialCharacters = RegExp(
      r'[!@#$%^&*(),.?":{}|<>]',
    ).hasMatch(value);

    if (!hasUppercase) {
      return 'La contraseña debe tener al menos una mayúscula';
    }
    if (!hasLowercase) {
      return 'La contraseña debe tener al menos una minúscula';
    }
    if (!hasNumbers) {
      return 'La contraseña debe tener al menos un número';
    }
    if (!hasSpecialCharacters) {
      return 'La contraseña debe tener al menos un carácter especial';
    }

    return null;
  }

  static String? _confirmPassword(String? value, String? originalPassword) {
    if (value == null || value.isEmpty) {
      return 'Por favor confirma tu contraseña';
    }

    if (value != originalPassword) {
      return 'Las contraseñas no coinciden';
    }

    return null;
  }

  static String? Function(String?) confirmPassword(String? originalPassword) {
    return (String? value) {
      return _confirmPassword(value, originalPassword);
    };
  }

  static String? _maxLengthLogic(
    String? value,
    int maxLength, [
    String? fieldName,
  ]) {
    if (value != null && value.length > maxLength) {
      return '${fieldName ?? 'Este campo'} no puede tener más de $maxLength caracteres';
    }
    return null;
  }

  static String? Function(String?) maxLength(int length, [String? fieldName]) {
    return (String? value) => _maxLengthLogic(value, length, fieldName);
  }

  static String? Function(String?) compose(
    List<String? Function(String?)> validators,
  ) {
    return (String? value) {
      for (final validator in validators) {
        final error = validator(value);

        if (error != null) {
          return error;
        }
      }

      return null;
    };
  }
}
