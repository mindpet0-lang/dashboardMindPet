class Validators {

  static String? validateEmail(
    String? value,
  ) {

    if (value == null ||
        value.isEmpty) {

      return 'El correo es obligatorio';
    }

    final regex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    );

    if (!regex.hasMatch(value)) {

      return 'Correo inválido';
    }

    return null;
  }

  static String? validatePassword(
    String? value,
  ) {

    if (value == null ||
        value.isEmpty) {

      return 'La contraseña es obligatoria';
    }

    if (value.length < 6) {

      return 'Mínimo 6 caracteres';
    }

    return null;
  }

  static String? validateName(
    String? value,
  ) {

    if (value == null ||
        value.trim().isEmpty) {

      return 'Campo obligatorio';
    }

    return null;
  }

  static String? validateMood(
    int mood,
  ) {

    if (mood < 1 || mood > 10) {

      return 'Estado emocional inválido';
    }

    return null;
  }

  static String? validateEmpty(
    String? value,
  ) {

    if (value == null ||
        value.trim().isEmpty) {

      return 'Este campo es obligatorio';
    }

    return null;
  }
}