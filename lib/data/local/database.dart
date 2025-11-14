import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

class Usuarios extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombres => text().withLength(max: 100)();
  TextColumn get apellidoPaterno => text().withLength(max: 100)();
  TextColumn get apellidoMaterno => text().withLength(max: 100).nullable()();
  TextColumn get email => text().unique()();
  TextColumn get telefono => text().withLength(max: 10)();
  TextColumn get remoteId => text().nullable()();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
}

@DataClassName('Direccion')
class Direcciones extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get usuarioId => integer().references(Usuarios, #id)();
  TextColumn get alias => text().withLength(min: 3, max: 50)();
  TextColumn get calle => text()();
  TextColumn get numeroExt => text()();
  TextColumn get numeroInt => text()();
  TextColumn get colonia => text()();
  TextColumn get codigoPostal => text().withLength(min: 5, max: 5)();
  TextColumn get municipio => text()();
  TextColumn get estado => text()();
  TextColumn get remoteId => text().nullable()();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [Usuarios, Direcciones])
class AppDatabase extends _$AppDatabase {
  AppDatabase._internal() : super(_openConnection());

  static final AppDatabase instance = AppDatabase._internal();

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) => m.createAll(),
      onUpgrade: (m, from, to) async {},
    );
  }

  Future<Usuario?> getUsuarioPorRemoteId(String remoteId) {
    return (select(
      usuarios,
    )..where((t) => t.remoteId.equals(remoteId))).getSingleOrNull();
  }

  Stream<Usuario> watchUsuarioActual(int idLocal) {
    return (select(usuarios)..where((t) => t.id.equals(idLocal))).watchSingle();
  }

  Future<int> insertUsuario(UsuariosCompanion usuario) {
    final companionConSync = usuario.copyWith(
      isSynced: const Value(false),
      updatedAt: Value(DateTime.now()),
    );
    return into(usuarios).insert(companionConSync);
  }

  Future<bool> updateUsuario(UsuariosCompanion usuario) {
    final companionConSync = usuario.copyWith(
      isSynced: const Value(false),
      updatedAt: Value(DateTime.now()),
    );
    return update(usuarios).replace(companionConSync);
  }

  Future<List<Usuario>> getUnsyncedUsuarios() {
    return (select(usuarios)..where((tbl) => tbl.isSynced.equals(false))).get();
  }

  Future<void> upsertUsuario(UsuariosCompanion companion) async {
    final remoteId = companion.remoteId.value;
    if (remoteId == null) return;

    final existingUser = await (select(
      usuarios,
    )..where((tbl) => tbl.remoteId.equals(remoteId))).getSingleOrNull();

    if (existingUser != null) {
      await (update(
        usuarios,
      )..where((tbl) => tbl.remoteId.equals(remoteId))).write(companion);
    } else {
      await into(usuarios).insert(companion);
    }
  }

  Future<int> deleteUsuarioReal(int id) {
    return (delete(usuarios)..where((t) => t.id.equals(id))).go();
  }

  Future<void> deleteByRemoteId(String remoteId) {
    return (delete(
      usuarios,
    )..where((tbl) => tbl.remoteId.equals(remoteId))).go();
  }

  Future<void> markAsDeleted(int id) {
    return (update(usuarios)..where((tbl) => tbl.id.equals(id))).write(
      const UsuariosCompanion(isDeleted: Value(true), isSynced: Value(false)),
    );
  }

  Stream<List<Direccion>> watchDireccionesDelUsuario(int idUsuario) {
    return (select(direcciones)
          ..where((t) => t.usuarioId.equals(idUsuario))
          ..where((t) => t.isDeleted.equals(false)))
        .watch();
  }

  Future<int> insertDireccion(DireccionesCompanion direccion) {
    final companionConSync = direccion.copyWith(
      isSynced: const Value(false),
      updatedAt: Value(DateTime.now()),
    );
    return into(direcciones).insert(companionConSync);
  }

  Future<bool> updateDireccion(DireccionesCompanion direccion) {
    final companionConSync = direccion.copyWith(
      isSynced: const Value(false),
      updatedAt: Value(DateTime.now()),
    );
    return update(direcciones).replace(companionConSync);
  }

  Future<void> markDireccionAsDeleted(int id) {
    return (update(direcciones)..where((tbl) => tbl.id.equals(id))).write(
      DireccionesCompanion(
        isDeleted: Value(true),
        isSynced: Value(false),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<List<Direccion>> getUnsyncedDirecciones() {
    return (select(direcciones)..where((t) => t.isSynced.equals(false))).get();
  }

  Future<void> upsertDireccion(DireccionesCompanion companion) async {
    final remoteId = companion.remoteId.value;
    if (remoteId == null) return;

    final existing = await (select(
      direcciones,
    )..where((t) => t.remoteId.equals(remoteId))).getSingleOrNull();

    if (existing != null) {
      await (update(
        direcciones,
      )..where((t) => t.remoteId.equals(remoteId))).write(companion);
    } else {
      await into(direcciones).insert(companion);
    }
  }

  Future<int> deleteDireccion(int id) {
    return (delete(direcciones)..where((t) => t.id.equals(id))).go();
  }

  Future<void> deleteByRemoteIdDireccion(String remoteId) {
    return (delete(
      direcciones,
    )..where((t) => t.remoteId.equals(remoteId))).go();
  }
}
