import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:drift/drift.dart';
import 'package:fruti_express_jahr/providers/auth_provider.dart';
import '../data/local/database.dart';
import 'dart:async';

class SyncService {
  final AppDatabase _localDb;
  final AuthProvider _authProvider;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  StreamSubscription? _perfilListener;
  StreamSubscription? _direccionesListener;
  SyncService(this._localDb, this._authProvider);

  String? get _userId {
    return _authProvider.firebaseUser?.uid;
  }

  int? get _localUserId {
    return _authProvider.perfilLocal?.id;
  }

  Future<void> initializeSync() async {
    final userId = _userId;
    if (userId == null) return;
    await _pullRemoteData();
    final perfilLocal = await _localDb.getUsuarioPorRemoteId(userId);
    if (perfilLocal != null) {
      _authProvider.setPerfilLocal(perfilLocal);
    }
    await syncPendingData();
    listenForRemoteChanges();
  }

  Future<void> _pullRemoteData() async {
    if (_userId == null) return;

    try {
      final docSnapshot = await _firestore
          .collection('usuarios')
          .doc(_userId)
          .get();
      if (docSnapshot.exists) {
        final perfil = docSnapshot.data()!;
        await _localDb.upsertUsuario(
          UsuariosCompanion(
            remoteId: Value(_userId!),
            nombres: Value(perfil['nombres']),
            apellidoPaterno: Value(perfil['apellidoPaterno']),
            apellidoMaterno: Value(perfil['apellidoMaterno']),
            email: Value(perfil['email']),
            telefono: Value(perfil['telefono']),
            isSynced: Value(true),
            updatedAt: Value((perfil['updatedAt'] as Timestamp).toDate()),
            isDeleted: Value(false),
          ),
        );
      }

      final direccionesSnapshot = await _firestore
          .collection('usuarios')
          .doc(_userId)
          .collection('direcciones')
          .get();

      for (final doc in direccionesSnapshot.docs) {
        final remoteData = doc.data();
        final remoteId = doc.id;

        if (_localUserId == null) continue;

        await _localDb.upsertDireccion(
          DireccionesCompanion(
            remoteId: Value(remoteId),
            usuarioId: Value(_localUserId!),
            alias: Value(remoteData['alias']),
            calle: Value(remoteData['calle']),
            numeroExt: Value(remoteData['numeroExt']),
            numeroInt: Value(remoteData['numeroInt']),
            colonia: Value(remoteData['colonia']),
            codigoPostal: Value(remoteData['codigoPostal']),
            municipio: Value(remoteData['municipio']),
            estado: Value(remoteData['estado']),
            isSynced: Value(true),
            updatedAt: Value((remoteData['updatedAt'] as Timestamp).toDate()),
            isDeleted: Value(false),
          ),
        );
      }
      print("Pull de datos remoto completado.");
    } catch (e) {
      print("Error en pullRemoteData: $e");
    }
  }

  Future<void> syncPendingData() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) return;

    await _syncPendingUsuarios();
    await _syncPendingDirecciones();
  }

  Future<void> _syncPendingUsuarios() async {
    final pendingUsers = await _localDb.getUnsyncedUsuarios();
    if (pendingUsers.isEmpty) return;
    for (final user in pendingUsers) {
      try {
        final userData = {
          'nombres': user.nombres,
          'apellidoPaterno': user.apellidoPaterno,
          'apellidoMaterno': user.apellidoMaterno,
          'email': user.email,
          'telefono': user.telefono,
          'updatedAt': FieldValue.serverTimestamp(),
        };

        if (user.isDeleted) {
          if (user.remoteId != null) {
            await _firestore.collection('usuarios').doc(user.remoteId).delete();
          }
          await _localDb.deleteUsuarioReal(user.id);
        } else if (user.remoteId != null) {
          await _firestore
              .collection('usuarios')
              .doc(user.remoteId)
              .update(userData);
          await _localDb.updateUsuario(
            user.toCompanion(false).copyWith(isSynced: Value(true)),
          );
        }
      } catch (e) {
        print("Error al sincronizar usuario ${user.id}: $e");
      }
    }
  }

  Future<void> _syncPendingDirecciones() async {
    final pending = await _localDb.getUnsyncedDirecciones();
    if (_userId == null) return;

    final collection = _firestore
        .collection('usuarios')
        .doc(_userId)
        .collection('direcciones');

    for (final direccion in pending) {
      try {
        final data = {
          'alias': direccion.alias,
          'calle': direccion.calle,
          'numeroExt': direccion.numeroExt,
          'numeroInt': direccion.numeroInt,
          'colonia': direccion.colonia,
          'codigoPostal': direccion.codigoPostal,
          'municipio': direccion.municipio,
          'estado': direccion.estado,
          'updatedAt': FieldValue.serverTimestamp(),
        };

        if (direccion.isDeleted) {
          if (direccion.remoteId != null) {
            await collection.doc(direccion.remoteId).delete();
          }
          await _localDb.deleteDireccion(direccion.id);
        } else if (direccion.remoteId == null) {
          final docRef = await collection.add(data);
          await _localDb.updateDireccion(
            direccion
                .toCompanion(false)
                .copyWith(remoteId: Value(docRef.id), isSynced: Value(true)),
          );
        } else {
          await collection.doc(direccion.remoteId).update(data);
          await _localDb.updateDireccion(
            direccion.toCompanion(false).copyWith(isSynced: Value(true)),
          );
        }
      } catch (e) {
        print("Error al sincronizar dirección ${direccion.id}: $e");
      }
    }
  }

  void listenForRemoteChanges() {
    if (_userId == null) return;
    dispose();
    _perfilListener = _firestore
        .collection('usuarios')
        .doc(_userId)
        .snapshots()
        .listen((doc) async {
          if (!doc.exists) return;
          final perfil = doc.data()!;
          await _localDb.upsertUsuario(
            UsuariosCompanion(
              remoteId: Value(_userId!),
              nombres: Value(perfil['nombres']),
              apellidoPaterno: Value(perfil['apellidoPaterno']),
              apellidoMaterno: Value(perfil['apellidoMaterno']),
              email: Value(perfil['email']),
              telefono: Value(perfil['telefono']),
              isSynced: Value(true),
              updatedAt: Value((perfil['updatedAt'] as Timestamp).toDate()),
              isDeleted: Value(false),
            ),
          );
        });

    _direccionesListener = _firestore
        .collection('usuarios')
        .doc(_userId)
        .collection('direcciones')
        .snapshots()
        .listen((snapshot) async {
          if (_localUserId == null) return;

          for (final docChange in snapshot.docChanges) {
            final remoteData = docChange.doc.data();
            final remoteId = docChange.doc.id;
            if (remoteData == null) {
              continue;
            }
            final companion = DireccionesCompanion(
              remoteId: Value(remoteId),
              usuarioId: Value(_localUserId!),
              alias: Value(remoteData['alias']),
              calle: Value(remoteData['calle']),
              numeroExt: Value(remoteData['numeroExt']),
              numeroInt: Value(remoteData['numeroInt']),
              colonia: Value(remoteData['colonia']),
              codigoPostal: Value(remoteData['codigoPostal']),
              municipio: Value(remoteData['municipio']),
              estado: Value(remoteData['estado']),
              isSynced: Value(true),
              updatedAt: Value((remoteData['updatedAt'] as Timestamp).toDate()),
              isDeleted: Value(false),
            );

            switch (docChange.type) {
              case DocumentChangeType.added:
              case DocumentChangeType.modified:
                await _localDb.upsertDireccion(companion);
                break;
              case DocumentChangeType.removed:
                await _localDb.deleteByRemoteIdDireccion(remoteId);
                break;
            }
          }
        });
  }

  void dispose() {
    _perfilListener?.cancel();
    _direccionesListener?.cancel();
  }
}
