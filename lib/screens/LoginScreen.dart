import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:fruti_express_jahr/data/local/database.dart';
import 'package:fruti_express_jahr/service_locator.dart';
import 'package:fruti_express_jahr/providers/auth_provider.dart';
import 'package:fruti_express_jahr/utils/validators.dart';
import 'package:fruti_express_jahr/widgets/CustomTextFormField.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  String _errorMessage = '';
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });
    final database = locator<AppDatabase>();
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );

      final User firebaseUser = userCredential.user!;
      final String uid = firebaseUser.uid;

      final docSnapshot = await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(uid)
          .get();

      if (!docSnapshot.exists) {
        throw Exception("Perfil de usuario no encontrado en la base de datos.");
      }

      final Map<String, dynamic> perfil = docSnapshot.data()!;
      final Timestamp? remoteTimestamp = perfil['updatedAt'] as Timestamp?;
      final DateTime localDateUser = remoteTimestamp == null
          ? DateTime.now()
          : remoteTimestamp.toDate();
      await database.upsertUsuario(
        UsuariosCompanion(
          remoteId: drift.Value(uid),
          nombres: drift.Value(perfil['nombres']),
          apellidoPaterno: drift.Value(perfil['apellido_paterno']),
          apellidoMaterno: drift.Value(perfil['apellido_materno']),
          email: drift.Value(perfil['email']),
          telefono: drift.Value(perfil['telefono']),
          isSynced: drift.Value(true),
          updatedAt: drift.Value(localDateUser),
          isDeleted: drift.Value(false),
        ),
      );

      final perfilLocalCompleto = await database.getUsuarioPorRemoteId(uid);

      if (perfilLocalCompleto == null) {
        throw Exception("Error fatal: El perfil local no se pudo guardar.");
      }
      if (mounted) {
        context.read<AuthProvider>().setPerfilLocal(perfilLocalCompleto);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Inicio de sesión exitoso'),
            backgroundColor: Colors.deepPurple,
          ),
        );
        context.go("/syncing");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' ||
          e.code == 'wrong-password' ||
          e.code == 'invalid-credential') {
        _errorMessage = 'Correo o contraseña incorrectos.';
      } else {
        _errorMessage = 'Ocurrió un error. Inténtalo de nuevo.';
      }
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
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: 24.0,
            top: 30.0,
            right: 24.0,
            bottom: 0.0,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Material(
                  elevation: 10.0,
                  shape: const CircleBorder(),
                  clipBehavior: Clip.antiAlias,

                  child: ClipOval(
                    child: Image.asset(
                      'assets/icons/iconoApp.png',
                      height: 220,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Bienvenido de Nuevo',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 32),
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
                  validator: Validators.required,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
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
                  onPressed: _isLoading ? null : _login,
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
                          'Ingresar',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('¿No tienes una cuenta?'),
                    TextButton(
                      onPressed: () {
                        context.go("/registroUser");
                      },
                      child: const Text(
                        'Regístrate',
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
