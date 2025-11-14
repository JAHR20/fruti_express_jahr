// archivo: lib/pages/register_page.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fruti_express_jahr/data/local/database.dart';
import 'package:fruti_express_jahr/service_locator.dart';
import 'package:fruti_express_jahr/widgets/CustomTextFormField.dart';
import 'package:go_router/go_router.dart';
import '../utils/validators.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombresController = TextEditingController();
  final _apellidoPaternoController = TextEditingController();
  final _apellidoMaternoController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  String _errorMessage = '';
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _nombresController.dispose();
    _apellidoPaternoController.dispose();
    _apellidoMaternoController.dispose();
    _telefonoController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );
      final User newUser = userCredential.user!;
      final String uid = newUser.uid;
      final String email = _emailController.text.trim();
      final String nombres = _nombresController.text.trim();
      final String apellidoPaterno = _apellidoPaternoController.text.trim();
      final String apellidoMaterno = _apellidoMaternoController.text.trim();
      final String telefono = _telefonoController.text.trim();

      final Map<String, dynamic> userProfile = {
        'nombres': nombres,
        'apellido_paterno': apellidoPaterno,
        'apellido_materno': apellidoMaterno,
        'email': email,
        'telefono': telefono,
        'createdAt': FieldValue.serverTimestamp(),
      };
      await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(uid)
          .set(userProfile);

      final database = locator<AppDatabase>();
      await database.insertUsuario(
        UsuariosCompanion(
          nombres: drift.Value(nombres),
          apellidoPaterno: drift.Value(apellidoPaterno),
          apellidoMaterno: drift.Value(apellidoMaterno),
          email: drift.Value(email),
          telefono: drift.Value(telefono),
          remoteId: drift.Value(uid),
          isSynced: drift.Value(true),
          updatedAt: drift.Value(DateTime.now()),
          isDeleted: drift.Value(false),
        ),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('¡Registro exitoso! Por favor, inicia sesión.'),
            backgroundColor: Colors.blue,
          ),
        );
        context.go("/login");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _errorMessage = 'La contraseña es demasiado débil.';
      } else if (e.code == 'email-already-in-use') {
        _errorMessage = 'Este correo electrónico ya está en uso.';
      } else {
        _errorMessage = 'Ocurrió un error. Inténtalo de nuevo.';
      }
    } on FirebaseException catch (e) {
      _errorMessage = 'Error al guardar en la nube: ${e.message}';
    } catch (e) {
      _errorMessage = 'Error local inesperado: $e';
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Crear Cuenta',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Registrate',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 32),
                const Text(
                  'Crea tu cuenta para empezar',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 32),
                CustomTextFormField(
                  controller: _nombresController,
                  labelText: 'Nombre(s)',
                  validator: Validators.required,
                  //prefixIcon: Icon(Icons.person_outline),
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  controller: _apellidoPaternoController,
                  labelText: 'Apellido Paterno',
                  validator: Validators.required,
                  //prefixIcon: Icon(Icons.person_outline),
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  controller: _apellidoMaternoController,
                  labelText: 'Apellido Materno (Opcional)',
                  validator: (value) {
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  controller: _telefonoController,
                  labelText: 'Teléfono',
                  keyboardType: TextInputType.number,
                  validator: Validators.phone,
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  controller: _emailController,
                  labelText: 'Correo Electrónico',
                  validator: Validators.email,
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  controller: _passwordController,
                  labelText: 'Contraseña',
                  isPassword: !_isPasswordVisible,
                  validator: Validators.password,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () => setState(
                      () => _isPasswordVisible = !_isPasswordVisible,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  controller: _confirmPasswordController,
                  labelText: 'Confirmar Contraseña',
                  isPassword: !_isConfirmPasswordVisible,
                  validator: (value) {
                    if (value != _passwordController.text) {
                      return 'Las contraseñas no coinciden';
                    }
                    return null;
                  },
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isConfirmPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () => setState(
                      () => _isConfirmPasswordVisible =
                          !_isConfirmPasswordVisible,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                if (_errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      _errorMessage,
                      style: const TextStyle(color: Colors.red, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.deepPurple,
                  ),
                  onPressed: _isLoading ? null : _register,
                  child: _isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ),
                        )
                      : const Text(
                          'Registrarse',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('¿Ya tienes una cuenta?'),
                    TextButton(
                      onPressed: () {
                        context.go("/login");
                      },
                      child: const Text(
                        'Inicia Sesión',
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
