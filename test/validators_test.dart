import 'package:flutter_test/flutter_test.dart';
import 'package:fruti_express_jahr/utils/validators.dart';

void main() {
  group('Validators.name', () {
    test('debería retornar error si el nombre es nulo o vacío', () {
      expect(Validators.name(null), 'Por favor ingresa tu nombre');
      expect(Validators.name(''), 'Por favor ingresa tu nombre');
    });

    test(
      'debería retornar error si el nombre es muy corto (menos de 2 caracteres)',
      () {
        expect(
          Validators.name('a'),
          'El nombre debe tener al menos 2 caracteres',
        );
        expect(
          Validators.name(' a '),
          'El nombre debe tener al menos 2 caracteres',
        );
      },
    );

    test('debería retornar error si el nombre contiene números o símbolos', () {
      expect(
        Validators.name('Nombre123'),
        'El nombre solo puede contener letras y espacios',
      );
      expect(
        Validators.name('Nombre!'),
        'El nombre solo puede contener letras y espacios',
      );
    });

    test('debería retornar null (válido) para nombres correctos', () {
      expect(Validators.name('Juan'), null);
      expect(Validators.name('Ana María'), null);
      expect(Validators.name('Ñoño'), null);
    });
  });

  group('Validators.email', () {
    test('debería retornar error si el email es nulo o vacío', () {
      expect(Validators.email(null), 'Por favor ingresa tu correo electrónico');
      expect(Validators.email(''), 'Por favor ingresa tu correo electrónico');
    });

    test('debería retornar error si el formato de email es inválido', () {
      expect(
        Validators.email('emailinvalido'),
        'Por favor ingresa un correo válido',
      );
      expect(
        Validators.email('email@dominio'),
        'Por favor ingresa un correo válido',
      );
      expect(
        Validators.email('email@dominio.'),
        'Por favor ingresa un correo válido',
      );
    });

    test('debería retornar null (válido) para un email correcto', () {
      expect(Validators.email('test@gmail.com'), null);
      expect(Validators.email('mi.correo-123@dominio.co'), null);
    });
  });

  group('Validators.phone', () {
    test('debería retornar error si el teléfono es nulo o vacío', () {
      expect(Validators.phone(null), 'Por favor ingresa tu número de teléfono');
      expect(Validators.phone(''), 'Por favor ingresa tu número de teléfono');
    });

    test('debería retornar error si el teléfono no tiene 10 dígitos', () {
      expect(
        Validators.phone('12345'),
        'Por favor ingresa un número de teléfono válido',
      );
      expect(
        Validators.phone('12345678901'),
        'Por favor ingresa un número de teléfono válido',
      );
      expect(
        Validators.phone('abcdefghij'),
        'Por favor ingresa un número de teléfono válido',
      );
    });

    test('debería retornar null (válido) para 10 dígitos', () {
      expect(Validators.phone('1234567890'), null);
    });

    test(
      'debería retornar null (válido) para 10 dígitos con espacios o guiones',
      () {
        expect(Validators.phone('123 456 7890'), null);
        expect(Validators.phone('123-456-7890'), null);
      },
    );
  });

  group('Validators.required', () {
    test('debería retornar error si el valor es nulo o vacío', () {
      expect(Validators.required(null), 'Por favor ingresa este campo');
      expect(Validators.required(''), 'Por favor ingresa este campo');
      // Prueba con solo espacios
      expect(Validators.required('   '), 'Por favor ingresa este campo');
    });

    test('debería retornar un mensaje de error personalizado', () {
      expect(
        Validators.required(null, 'el nombre'),
        'Por favor ingresa el nombre',
      );
    });

    test('debería retornar null (válido) si el valor está presente', () {
      expect(Validators.required('Hola'), null);
    });
  });

  group('Validators.password', () {
    test('debería retornar error si la contraseña es nula o vacía', () {
      expect(Validators.password(null), 'Por favor ingresa tu contraseña');
      expect(Validators.password(''), 'Por favor ingresa tu contraseña');
    });
    test('debería retornar error si la contraseña es muy corta (< 8)', () {
      expect(
        Validators.password('1234567'),
        'La contraseña debe tener al menos 8 caracteres',
      );
    });

    test('debería retornar error si falta una mayúscula', () {
      expect(
        Validators.password('password123!'),
        'La contraseña debe tener al menos una mayúscula',
      );
    });

    test('debería retornar error si falta una minúscula', () {
      expect(
        Validators.password('PASSWORD123!'),
        'La contraseña debe tener al menos una minúscula',
      );
    });

    test('debería retornar error si falta un número', () {
      expect(
        Validators.password('PasswordCon!'),
        'La contraseña debe tener al menos un número',
      );
    });

    test('debería retornar error si falta un carácter especial', () {
      expect(
        Validators.password('Password123'),
        'La contraseña debe tener al menos un carácter especial',
      );
    });

    test('debería retornar null (válido) para una contraseña segura', () {
      expect(Validators.password('Password123!'), null);
      expect(Validators.password('P@ssw0rdSegura'), null);
    });
  });

  group('Validators.confirmPassword', () {
    test('debería retornar error si la confirmación es nula o vacía', () {
      final validator = Validators.confirmPassword('Original123');
      expect(validator(null), 'Por favor confirma tu contraseña');
      expect(validator(''), 'Por favor confirma tu contraseña');
    });

    test('debería retornar error si las contraseñas no coinciden', () {
      final validator = Validators.confirmPassword('Original123');
      expect(validator('OtraCosa123'), 'Las contraseñas no coinciden');
    });

    test('debería retornar null (válido) si las contraseñas coinciden', () {
      final validator = Validators.confirmPassword('Original123');
      expect(validator('Original123'), null);
    });
  });

  /*group('Validators.compose', () {
    test('debería retornar null si no hay validadores', () {
      final composed = Validators.compose([]);
      expect(composed('un valor'), null);
    });

    test('debería retornar null si todos los validadores pasan', () {
      final composed = Validators.compose([
        Validators.required,
        Validators.minLength(3),
      ]);
      expect(composed('valor largo'), null);
    });

    test('debería retornar el primer error que encuentre', () {
      final composed = Validators.compose([
        Validators.required,
        Validators.email,
      ]);
      // Falla el primer validador
      expect(composed(''), 'Por favor ingresa este campo');
      // Falla el segundo validador
      expect(composed('emailinvalido'), 'Por favor ingresa un correo válido');
    });
  });*/
}
