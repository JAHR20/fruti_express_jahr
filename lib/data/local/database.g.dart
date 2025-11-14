// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $UsuariosTable extends Usuarios with TableInfo<$UsuariosTable, Usuario> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsuariosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nombresMeta = const VerificationMeta(
    'nombres',
  );
  @override
  late final GeneratedColumn<String> nombres = GeneratedColumn<String>(
    'nombres',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 100),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _apellidoPaternoMeta = const VerificationMeta(
    'apellidoPaterno',
  );
  @override
  late final GeneratedColumn<String> apellidoPaterno = GeneratedColumn<String>(
    'apellido_paterno',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 100),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _apellidoMaternoMeta = const VerificationMeta(
    'apellidoMaterno',
  );
  @override
  late final GeneratedColumn<String> apellidoMaterno = GeneratedColumn<String>(
    'apellido_materno',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 100),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _telefonoMeta = const VerificationMeta(
    'telefono',
  );
  @override
  late final GeneratedColumn<String> telefono = GeneratedColumn<String>(
    'telefono',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 10),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
    'remote_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nombres,
    apellidoPaterno,
    apellidoMaterno,
    email,
    telefono,
    remoteId,
    isSynced,
    updatedAt,
    isDeleted,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'usuarios';
  @override
  VerificationContext validateIntegrity(
    Insertable<Usuario> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombres')) {
      context.handle(
        _nombresMeta,
        nombres.isAcceptableOrUnknown(data['nombres']!, _nombresMeta),
      );
    } else if (isInserting) {
      context.missing(_nombresMeta);
    }
    if (data.containsKey('apellido_paterno')) {
      context.handle(
        _apellidoPaternoMeta,
        apellidoPaterno.isAcceptableOrUnknown(
          data['apellido_paterno']!,
          _apellidoPaternoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_apellidoPaternoMeta);
    }
    if (data.containsKey('apellido_materno')) {
      context.handle(
        _apellidoMaternoMeta,
        apellidoMaterno.isAcceptableOrUnknown(
          data['apellido_materno']!,
          _apellidoMaternoMeta,
        ),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('telefono')) {
      context.handle(
        _telefonoMeta,
        telefono.isAcceptableOrUnknown(data['telefono']!, _telefonoMeta),
      );
    } else if (isInserting) {
      context.missing(_telefonoMeta);
    }
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Usuario map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Usuario(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nombres: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombres'],
      )!,
      apellidoPaterno: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}apellido_paterno'],
      )!,
      apellidoMaterno: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}apellido_materno'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      telefono: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}telefono'],
      )!,
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_id'],
      ),
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
    );
  }

  @override
  $UsuariosTable createAlias(String alias) {
    return $UsuariosTable(attachedDatabase, alias);
  }
}

class Usuario extends DataClass implements Insertable<Usuario> {
  final int id;
  final String nombres;
  final String apellidoPaterno;
  final String? apellidoMaterno;
  final String email;
  final String telefono;
  final String? remoteId;
  final bool isSynced;
  final DateTime? updatedAt;
  final bool isDeleted;
  const Usuario({
    required this.id,
    required this.nombres,
    required this.apellidoPaterno,
    this.apellidoMaterno,
    required this.email,
    required this.telefono,
    this.remoteId,
    required this.isSynced,
    this.updatedAt,
    required this.isDeleted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombres'] = Variable<String>(nombres);
    map['apellido_paterno'] = Variable<String>(apellidoPaterno);
    if (!nullToAbsent || apellidoMaterno != null) {
      map['apellido_materno'] = Variable<String>(apellidoMaterno);
    }
    map['email'] = Variable<String>(email);
    map['telefono'] = Variable<String>(telefono);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    map['is_synced'] = Variable<bool>(isSynced);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    map['is_deleted'] = Variable<bool>(isDeleted);
    return map;
  }

  UsuariosCompanion toCompanion(bool nullToAbsent) {
    return UsuariosCompanion(
      id: Value(id),
      nombres: Value(nombres),
      apellidoPaterno: Value(apellidoPaterno),
      apellidoMaterno: apellidoMaterno == null && nullToAbsent
          ? const Value.absent()
          : Value(apellidoMaterno),
      email: Value(email),
      telefono: Value(telefono),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      isSynced: Value(isSynced),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      isDeleted: Value(isDeleted),
    );
  }

  factory Usuario.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Usuario(
      id: serializer.fromJson<int>(json['id']),
      nombres: serializer.fromJson<String>(json['nombres']),
      apellidoPaterno: serializer.fromJson<String>(json['apellidoPaterno']),
      apellidoMaterno: serializer.fromJson<String?>(json['apellidoMaterno']),
      email: serializer.fromJson<String>(json['email']),
      telefono: serializer.fromJson<String>(json['telefono']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombres': serializer.toJson<String>(nombres),
      'apellidoPaterno': serializer.toJson<String>(apellidoPaterno),
      'apellidoMaterno': serializer.toJson<String?>(apellidoMaterno),
      'email': serializer.toJson<String>(email),
      'telefono': serializer.toJson<String>(telefono),
      'remoteId': serializer.toJson<String?>(remoteId),
      'isSynced': serializer.toJson<bool>(isSynced),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'isDeleted': serializer.toJson<bool>(isDeleted),
    };
  }

  Usuario copyWith({
    int? id,
    String? nombres,
    String? apellidoPaterno,
    Value<String?> apellidoMaterno = const Value.absent(),
    String? email,
    String? telefono,
    Value<String?> remoteId = const Value.absent(),
    bool? isSynced,
    Value<DateTime?> updatedAt = const Value.absent(),
    bool? isDeleted,
  }) => Usuario(
    id: id ?? this.id,
    nombres: nombres ?? this.nombres,
    apellidoPaterno: apellidoPaterno ?? this.apellidoPaterno,
    apellidoMaterno: apellidoMaterno.present
        ? apellidoMaterno.value
        : this.apellidoMaterno,
    email: email ?? this.email,
    telefono: telefono ?? this.telefono,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
    isSynced: isSynced ?? this.isSynced,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
    isDeleted: isDeleted ?? this.isDeleted,
  );
  Usuario copyWithCompanion(UsuariosCompanion data) {
    return Usuario(
      id: data.id.present ? data.id.value : this.id,
      nombres: data.nombres.present ? data.nombres.value : this.nombres,
      apellidoPaterno: data.apellidoPaterno.present
          ? data.apellidoPaterno.value
          : this.apellidoPaterno,
      apellidoMaterno: data.apellidoMaterno.present
          ? data.apellidoMaterno.value
          : this.apellidoMaterno,
      email: data.email.present ? data.email.value : this.email,
      telefono: data.telefono.present ? data.telefono.value : this.telefono,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Usuario(')
          ..write('id: $id, ')
          ..write('nombres: $nombres, ')
          ..write('apellidoPaterno: $apellidoPaterno, ')
          ..write('apellidoMaterno: $apellidoMaterno, ')
          ..write('email: $email, ')
          ..write('telefono: $telefono, ')
          ..write('remoteId: $remoteId, ')
          ..write('isSynced: $isSynced, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    nombres,
    apellidoPaterno,
    apellidoMaterno,
    email,
    telefono,
    remoteId,
    isSynced,
    updatedAt,
    isDeleted,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Usuario &&
          other.id == this.id &&
          other.nombres == this.nombres &&
          other.apellidoPaterno == this.apellidoPaterno &&
          other.apellidoMaterno == this.apellidoMaterno &&
          other.email == this.email &&
          other.telefono == this.telefono &&
          other.remoteId == this.remoteId &&
          other.isSynced == this.isSynced &&
          other.updatedAt == this.updatedAt &&
          other.isDeleted == this.isDeleted);
}

class UsuariosCompanion extends UpdateCompanion<Usuario> {
  final Value<int> id;
  final Value<String> nombres;
  final Value<String> apellidoPaterno;
  final Value<String?> apellidoMaterno;
  final Value<String> email;
  final Value<String> telefono;
  final Value<String?> remoteId;
  final Value<bool> isSynced;
  final Value<DateTime?> updatedAt;
  final Value<bool> isDeleted;
  const UsuariosCompanion({
    this.id = const Value.absent(),
    this.nombres = const Value.absent(),
    this.apellidoPaterno = const Value.absent(),
    this.apellidoMaterno = const Value.absent(),
    this.email = const Value.absent(),
    this.telefono = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
  });
  UsuariosCompanion.insert({
    this.id = const Value.absent(),
    required String nombres,
    required String apellidoPaterno,
    this.apellidoMaterno = const Value.absent(),
    required String email,
    required String telefono,
    this.remoteId = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
  }) : nombres = Value(nombres),
       apellidoPaterno = Value(apellidoPaterno),
       email = Value(email),
       telefono = Value(telefono);
  static Insertable<Usuario> custom({
    Expression<int>? id,
    Expression<String>? nombres,
    Expression<String>? apellidoPaterno,
    Expression<String>? apellidoMaterno,
    Expression<String>? email,
    Expression<String>? telefono,
    Expression<String>? remoteId,
    Expression<bool>? isSynced,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isDeleted,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombres != null) 'nombres': nombres,
      if (apellidoPaterno != null) 'apellido_paterno': apellidoPaterno,
      if (apellidoMaterno != null) 'apellido_materno': apellidoMaterno,
      if (email != null) 'email': email,
      if (telefono != null) 'telefono': telefono,
      if (remoteId != null) 'remote_id': remoteId,
      if (isSynced != null) 'is_synced': isSynced,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isDeleted != null) 'is_deleted': isDeleted,
    });
  }

  UsuariosCompanion copyWith({
    Value<int>? id,
    Value<String>? nombres,
    Value<String>? apellidoPaterno,
    Value<String?>? apellidoMaterno,
    Value<String>? email,
    Value<String>? telefono,
    Value<String?>? remoteId,
    Value<bool>? isSynced,
    Value<DateTime?>? updatedAt,
    Value<bool>? isDeleted,
  }) {
    return UsuariosCompanion(
      id: id ?? this.id,
      nombres: nombres ?? this.nombres,
      apellidoPaterno: apellidoPaterno ?? this.apellidoPaterno,
      apellidoMaterno: apellidoMaterno ?? this.apellidoMaterno,
      email: email ?? this.email,
      telefono: telefono ?? this.telefono,
      remoteId: remoteId ?? this.remoteId,
      isSynced: isSynced ?? this.isSynced,
      updatedAt: updatedAt ?? this.updatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombres.present) {
      map['nombres'] = Variable<String>(nombres.value);
    }
    if (apellidoPaterno.present) {
      map['apellido_paterno'] = Variable<String>(apellidoPaterno.value);
    }
    if (apellidoMaterno.present) {
      map['apellido_materno'] = Variable<String>(apellidoMaterno.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (telefono.present) {
      map['telefono'] = Variable<String>(telefono.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsuariosCompanion(')
          ..write('id: $id, ')
          ..write('nombres: $nombres, ')
          ..write('apellidoPaterno: $apellidoPaterno, ')
          ..write('apellidoMaterno: $apellidoMaterno, ')
          ..write('email: $email, ')
          ..write('telefono: $telefono, ')
          ..write('remoteId: $remoteId, ')
          ..write('isSynced: $isSynced, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }
}

class $DireccionesTable extends Direcciones
    with TableInfo<$DireccionesTable, Direccion> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DireccionesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _usuarioIdMeta = const VerificationMeta(
    'usuarioId',
  );
  @override
  late final GeneratedColumn<int> usuarioId = GeneratedColumn<int>(
    'usuario_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES usuarios (id)',
    ),
  );
  static const VerificationMeta _aliasMeta = const VerificationMeta('alias');
  @override
  late final GeneratedColumn<String> alias = GeneratedColumn<String>(
    'alias',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 3,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _calleMeta = const VerificationMeta('calle');
  @override
  late final GeneratedColumn<String> calle = GeneratedColumn<String>(
    'calle',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _numeroExtMeta = const VerificationMeta(
    'numeroExt',
  );
  @override
  late final GeneratedColumn<String> numeroExt = GeneratedColumn<String>(
    'numero_ext',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _numeroIntMeta = const VerificationMeta(
    'numeroInt',
  );
  @override
  late final GeneratedColumn<String> numeroInt = GeneratedColumn<String>(
    'numero_int',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _coloniaMeta = const VerificationMeta(
    'colonia',
  );
  @override
  late final GeneratedColumn<String> colonia = GeneratedColumn<String>(
    'colonia',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _codigoPostalMeta = const VerificationMeta(
    'codigoPostal',
  );
  @override
  late final GeneratedColumn<String> codigoPostal = GeneratedColumn<String>(
    'codigo_postal',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 5,
      maxTextLength: 5,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _municipioMeta = const VerificationMeta(
    'municipio',
  );
  @override
  late final GeneratedColumn<String> municipio = GeneratedColumn<String>(
    'municipio',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<String> estado = GeneratedColumn<String>(
    'estado',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
    'remote_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    usuarioId,
    alias,
    calle,
    numeroExt,
    numeroInt,
    colonia,
    codigoPostal,
    municipio,
    estado,
    remoteId,
    isSynced,
    updatedAt,
    isDeleted,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'direcciones';
  @override
  VerificationContext validateIntegrity(
    Insertable<Direccion> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('usuario_id')) {
      context.handle(
        _usuarioIdMeta,
        usuarioId.isAcceptableOrUnknown(data['usuario_id']!, _usuarioIdMeta),
      );
    } else if (isInserting) {
      context.missing(_usuarioIdMeta);
    }
    if (data.containsKey('alias')) {
      context.handle(
        _aliasMeta,
        alias.isAcceptableOrUnknown(data['alias']!, _aliasMeta),
      );
    } else if (isInserting) {
      context.missing(_aliasMeta);
    }
    if (data.containsKey('calle')) {
      context.handle(
        _calleMeta,
        calle.isAcceptableOrUnknown(data['calle']!, _calleMeta),
      );
    } else if (isInserting) {
      context.missing(_calleMeta);
    }
    if (data.containsKey('numero_ext')) {
      context.handle(
        _numeroExtMeta,
        numeroExt.isAcceptableOrUnknown(data['numero_ext']!, _numeroExtMeta),
      );
    } else if (isInserting) {
      context.missing(_numeroExtMeta);
    }
    if (data.containsKey('numero_int')) {
      context.handle(
        _numeroIntMeta,
        numeroInt.isAcceptableOrUnknown(data['numero_int']!, _numeroIntMeta),
      );
    } else if (isInserting) {
      context.missing(_numeroIntMeta);
    }
    if (data.containsKey('colonia')) {
      context.handle(
        _coloniaMeta,
        colonia.isAcceptableOrUnknown(data['colonia']!, _coloniaMeta),
      );
    } else if (isInserting) {
      context.missing(_coloniaMeta);
    }
    if (data.containsKey('codigo_postal')) {
      context.handle(
        _codigoPostalMeta,
        codigoPostal.isAcceptableOrUnknown(
          data['codigo_postal']!,
          _codigoPostalMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_codigoPostalMeta);
    }
    if (data.containsKey('municipio')) {
      context.handle(
        _municipioMeta,
        municipio.isAcceptableOrUnknown(data['municipio']!, _municipioMeta),
      );
    } else if (isInserting) {
      context.missing(_municipioMeta);
    }
    if (data.containsKey('estado')) {
      context.handle(
        _estadoMeta,
        estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta),
      );
    } else if (isInserting) {
      context.missing(_estadoMeta);
    }
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Direccion map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Direccion(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      usuarioId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}usuario_id'],
      )!,
      alias: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}alias'],
      )!,
      calle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}calle'],
      )!,
      numeroExt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}numero_ext'],
      )!,
      numeroInt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}numero_int'],
      )!,
      colonia: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}colonia'],
      )!,
      codigoPostal: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}codigo_postal'],
      )!,
      municipio: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}municipio'],
      )!,
      estado: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}estado'],
      )!,
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_id'],
      ),
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
    );
  }

  @override
  $DireccionesTable createAlias(String alias) {
    return $DireccionesTable(attachedDatabase, alias);
  }
}

class Direccion extends DataClass implements Insertable<Direccion> {
  final int id;
  final int usuarioId;
  final String alias;
  final String calle;
  final String numeroExt;
  final String numeroInt;
  final String colonia;
  final String codigoPostal;
  final String municipio;
  final String estado;
  final String? remoteId;
  final bool isSynced;
  final DateTime? updatedAt;
  final bool isDeleted;
  const Direccion({
    required this.id,
    required this.usuarioId,
    required this.alias,
    required this.calle,
    required this.numeroExt,
    required this.numeroInt,
    required this.colonia,
    required this.codigoPostal,
    required this.municipio,
    required this.estado,
    this.remoteId,
    required this.isSynced,
    this.updatedAt,
    required this.isDeleted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['usuario_id'] = Variable<int>(usuarioId);
    map['alias'] = Variable<String>(alias);
    map['calle'] = Variable<String>(calle);
    map['numero_ext'] = Variable<String>(numeroExt);
    map['numero_int'] = Variable<String>(numeroInt);
    map['colonia'] = Variable<String>(colonia);
    map['codigo_postal'] = Variable<String>(codigoPostal);
    map['municipio'] = Variable<String>(municipio);
    map['estado'] = Variable<String>(estado);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    map['is_synced'] = Variable<bool>(isSynced);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    map['is_deleted'] = Variable<bool>(isDeleted);
    return map;
  }

  DireccionesCompanion toCompanion(bool nullToAbsent) {
    return DireccionesCompanion(
      id: Value(id),
      usuarioId: Value(usuarioId),
      alias: Value(alias),
      calle: Value(calle),
      numeroExt: Value(numeroExt),
      numeroInt: Value(numeroInt),
      colonia: Value(colonia),
      codigoPostal: Value(codigoPostal),
      municipio: Value(municipio),
      estado: Value(estado),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      isSynced: Value(isSynced),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      isDeleted: Value(isDeleted),
    );
  }

  factory Direccion.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Direccion(
      id: serializer.fromJson<int>(json['id']),
      usuarioId: serializer.fromJson<int>(json['usuarioId']),
      alias: serializer.fromJson<String>(json['alias']),
      calle: serializer.fromJson<String>(json['calle']),
      numeroExt: serializer.fromJson<String>(json['numeroExt']),
      numeroInt: serializer.fromJson<String>(json['numeroInt']),
      colonia: serializer.fromJson<String>(json['colonia']),
      codigoPostal: serializer.fromJson<String>(json['codigoPostal']),
      municipio: serializer.fromJson<String>(json['municipio']),
      estado: serializer.fromJson<String>(json['estado']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'usuarioId': serializer.toJson<int>(usuarioId),
      'alias': serializer.toJson<String>(alias),
      'calle': serializer.toJson<String>(calle),
      'numeroExt': serializer.toJson<String>(numeroExt),
      'numeroInt': serializer.toJson<String>(numeroInt),
      'colonia': serializer.toJson<String>(colonia),
      'codigoPostal': serializer.toJson<String>(codigoPostal),
      'municipio': serializer.toJson<String>(municipio),
      'estado': serializer.toJson<String>(estado),
      'remoteId': serializer.toJson<String?>(remoteId),
      'isSynced': serializer.toJson<bool>(isSynced),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'isDeleted': serializer.toJson<bool>(isDeleted),
    };
  }

  Direccion copyWith({
    int? id,
    int? usuarioId,
    String? alias,
    String? calle,
    String? numeroExt,
    String? numeroInt,
    String? colonia,
    String? codigoPostal,
    String? municipio,
    String? estado,
    Value<String?> remoteId = const Value.absent(),
    bool? isSynced,
    Value<DateTime?> updatedAt = const Value.absent(),
    bool? isDeleted,
  }) => Direccion(
    id: id ?? this.id,
    usuarioId: usuarioId ?? this.usuarioId,
    alias: alias ?? this.alias,
    calle: calle ?? this.calle,
    numeroExt: numeroExt ?? this.numeroExt,
    numeroInt: numeroInt ?? this.numeroInt,
    colonia: colonia ?? this.colonia,
    codigoPostal: codigoPostal ?? this.codigoPostal,
    municipio: municipio ?? this.municipio,
    estado: estado ?? this.estado,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
    isSynced: isSynced ?? this.isSynced,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
    isDeleted: isDeleted ?? this.isDeleted,
  );
  Direccion copyWithCompanion(DireccionesCompanion data) {
    return Direccion(
      id: data.id.present ? data.id.value : this.id,
      usuarioId: data.usuarioId.present ? data.usuarioId.value : this.usuarioId,
      alias: data.alias.present ? data.alias.value : this.alias,
      calle: data.calle.present ? data.calle.value : this.calle,
      numeroExt: data.numeroExt.present ? data.numeroExt.value : this.numeroExt,
      numeroInt: data.numeroInt.present ? data.numeroInt.value : this.numeroInt,
      colonia: data.colonia.present ? data.colonia.value : this.colonia,
      codigoPostal: data.codigoPostal.present
          ? data.codigoPostal.value
          : this.codigoPostal,
      municipio: data.municipio.present ? data.municipio.value : this.municipio,
      estado: data.estado.present ? data.estado.value : this.estado,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Direccion(')
          ..write('id: $id, ')
          ..write('usuarioId: $usuarioId, ')
          ..write('alias: $alias, ')
          ..write('calle: $calle, ')
          ..write('numeroExt: $numeroExt, ')
          ..write('numeroInt: $numeroInt, ')
          ..write('colonia: $colonia, ')
          ..write('codigoPostal: $codigoPostal, ')
          ..write('municipio: $municipio, ')
          ..write('estado: $estado, ')
          ..write('remoteId: $remoteId, ')
          ..write('isSynced: $isSynced, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    usuarioId,
    alias,
    calle,
    numeroExt,
    numeroInt,
    colonia,
    codigoPostal,
    municipio,
    estado,
    remoteId,
    isSynced,
    updatedAt,
    isDeleted,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Direccion &&
          other.id == this.id &&
          other.usuarioId == this.usuarioId &&
          other.alias == this.alias &&
          other.calle == this.calle &&
          other.numeroExt == this.numeroExt &&
          other.numeroInt == this.numeroInt &&
          other.colonia == this.colonia &&
          other.codigoPostal == this.codigoPostal &&
          other.municipio == this.municipio &&
          other.estado == this.estado &&
          other.remoteId == this.remoteId &&
          other.isSynced == this.isSynced &&
          other.updatedAt == this.updatedAt &&
          other.isDeleted == this.isDeleted);
}

class DireccionesCompanion extends UpdateCompanion<Direccion> {
  final Value<int> id;
  final Value<int> usuarioId;
  final Value<String> alias;
  final Value<String> calle;
  final Value<String> numeroExt;
  final Value<String> numeroInt;
  final Value<String> colonia;
  final Value<String> codigoPostal;
  final Value<String> municipio;
  final Value<String> estado;
  final Value<String?> remoteId;
  final Value<bool> isSynced;
  final Value<DateTime?> updatedAt;
  final Value<bool> isDeleted;
  const DireccionesCompanion({
    this.id = const Value.absent(),
    this.usuarioId = const Value.absent(),
    this.alias = const Value.absent(),
    this.calle = const Value.absent(),
    this.numeroExt = const Value.absent(),
    this.numeroInt = const Value.absent(),
    this.colonia = const Value.absent(),
    this.codigoPostal = const Value.absent(),
    this.municipio = const Value.absent(),
    this.estado = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
  });
  DireccionesCompanion.insert({
    this.id = const Value.absent(),
    required int usuarioId,
    required String alias,
    required String calle,
    required String numeroExt,
    required String numeroInt,
    required String colonia,
    required String codigoPostal,
    required String municipio,
    required String estado,
    this.remoteId = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
  }) : usuarioId = Value(usuarioId),
       alias = Value(alias),
       calle = Value(calle),
       numeroExt = Value(numeroExt),
       numeroInt = Value(numeroInt),
       colonia = Value(colonia),
       codigoPostal = Value(codigoPostal),
       municipio = Value(municipio),
       estado = Value(estado);
  static Insertable<Direccion> custom({
    Expression<int>? id,
    Expression<int>? usuarioId,
    Expression<String>? alias,
    Expression<String>? calle,
    Expression<String>? numeroExt,
    Expression<String>? numeroInt,
    Expression<String>? colonia,
    Expression<String>? codigoPostal,
    Expression<String>? municipio,
    Expression<String>? estado,
    Expression<String>? remoteId,
    Expression<bool>? isSynced,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isDeleted,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (usuarioId != null) 'usuario_id': usuarioId,
      if (alias != null) 'alias': alias,
      if (calle != null) 'calle': calle,
      if (numeroExt != null) 'numero_ext': numeroExt,
      if (numeroInt != null) 'numero_int': numeroInt,
      if (colonia != null) 'colonia': colonia,
      if (codigoPostal != null) 'codigo_postal': codigoPostal,
      if (municipio != null) 'municipio': municipio,
      if (estado != null) 'estado': estado,
      if (remoteId != null) 'remote_id': remoteId,
      if (isSynced != null) 'is_synced': isSynced,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isDeleted != null) 'is_deleted': isDeleted,
    });
  }

  DireccionesCompanion copyWith({
    Value<int>? id,
    Value<int>? usuarioId,
    Value<String>? alias,
    Value<String>? calle,
    Value<String>? numeroExt,
    Value<String>? numeroInt,
    Value<String>? colonia,
    Value<String>? codigoPostal,
    Value<String>? municipio,
    Value<String>? estado,
    Value<String?>? remoteId,
    Value<bool>? isSynced,
    Value<DateTime?>? updatedAt,
    Value<bool>? isDeleted,
  }) {
    return DireccionesCompanion(
      id: id ?? this.id,
      usuarioId: usuarioId ?? this.usuarioId,
      alias: alias ?? this.alias,
      calle: calle ?? this.calle,
      numeroExt: numeroExt ?? this.numeroExt,
      numeroInt: numeroInt ?? this.numeroInt,
      colonia: colonia ?? this.colonia,
      codigoPostal: codigoPostal ?? this.codigoPostal,
      municipio: municipio ?? this.municipio,
      estado: estado ?? this.estado,
      remoteId: remoteId ?? this.remoteId,
      isSynced: isSynced ?? this.isSynced,
      updatedAt: updatedAt ?? this.updatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (usuarioId.present) {
      map['usuario_id'] = Variable<int>(usuarioId.value);
    }
    if (alias.present) {
      map['alias'] = Variable<String>(alias.value);
    }
    if (calle.present) {
      map['calle'] = Variable<String>(calle.value);
    }
    if (numeroExt.present) {
      map['numero_ext'] = Variable<String>(numeroExt.value);
    }
    if (numeroInt.present) {
      map['numero_int'] = Variable<String>(numeroInt.value);
    }
    if (colonia.present) {
      map['colonia'] = Variable<String>(colonia.value);
    }
    if (codigoPostal.present) {
      map['codigo_postal'] = Variable<String>(codigoPostal.value);
    }
    if (municipio.present) {
      map['municipio'] = Variable<String>(municipio.value);
    }
    if (estado.present) {
      map['estado'] = Variable<String>(estado.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DireccionesCompanion(')
          ..write('id: $id, ')
          ..write('usuarioId: $usuarioId, ')
          ..write('alias: $alias, ')
          ..write('calle: $calle, ')
          ..write('numeroExt: $numeroExt, ')
          ..write('numeroInt: $numeroInt, ')
          ..write('colonia: $colonia, ')
          ..write('codigoPostal: $codigoPostal, ')
          ..write('municipio: $municipio, ')
          ..write('estado: $estado, ')
          ..write('remoteId: $remoteId, ')
          ..write('isSynced: $isSynced, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsuariosTable usuarios = $UsuariosTable(this);
  late final $DireccionesTable direcciones = $DireccionesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [usuarios, direcciones];
}

typedef $$UsuariosTableCreateCompanionBuilder =
    UsuariosCompanion Function({
      Value<int> id,
      required String nombres,
      required String apellidoPaterno,
      Value<String?> apellidoMaterno,
      required String email,
      required String telefono,
      Value<String?> remoteId,
      Value<bool> isSynced,
      Value<DateTime?> updatedAt,
      Value<bool> isDeleted,
    });
typedef $$UsuariosTableUpdateCompanionBuilder =
    UsuariosCompanion Function({
      Value<int> id,
      Value<String> nombres,
      Value<String> apellidoPaterno,
      Value<String?> apellidoMaterno,
      Value<String> email,
      Value<String> telefono,
      Value<String?> remoteId,
      Value<bool> isSynced,
      Value<DateTime?> updatedAt,
      Value<bool> isDeleted,
    });

final class $$UsuariosTableReferences
    extends BaseReferences<_$AppDatabase, $UsuariosTable, Usuario> {
  $$UsuariosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$DireccionesTable, List<Direccion>>
  _direccionesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.direcciones,
    aliasName: $_aliasNameGenerator(db.usuarios.id, db.direcciones.usuarioId),
  );

  $$DireccionesTableProcessedTableManager get direccionesRefs {
    final manager = $$DireccionesTableTableManager(
      $_db,
      $_db.direcciones,
    ).filter((f) => f.usuarioId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_direccionesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$UsuariosTableFilterComposer
    extends Composer<_$AppDatabase, $UsuariosTable> {
  $$UsuariosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombres => $composableBuilder(
    column: $table.nombres,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get apellidoPaterno => $composableBuilder(
    column: $table.apellidoPaterno,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get apellidoMaterno => $composableBuilder(
    column: $table.apellidoMaterno,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get telefono => $composableBuilder(
    column: $table.telefono,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> direccionesRefs(
    Expression<bool> Function($$DireccionesTableFilterComposer f) f,
  ) {
    final $$DireccionesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.direcciones,
      getReferencedColumn: (t) => t.usuarioId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DireccionesTableFilterComposer(
            $db: $db,
            $table: $db.direcciones,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsuariosTableOrderingComposer
    extends Composer<_$AppDatabase, $UsuariosTable> {
  $$UsuariosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombres => $composableBuilder(
    column: $table.nombres,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get apellidoPaterno => $composableBuilder(
    column: $table.apellidoPaterno,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get apellidoMaterno => $composableBuilder(
    column: $table.apellidoMaterno,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get telefono => $composableBuilder(
    column: $table.telefono,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsuariosTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsuariosTable> {
  $$UsuariosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombres =>
      $composableBuilder(column: $table.nombres, builder: (column) => column);

  GeneratedColumn<String> get apellidoPaterno => $composableBuilder(
    column: $table.apellidoPaterno,
    builder: (column) => column,
  );

  GeneratedColumn<String> get apellidoMaterno => $composableBuilder(
    column: $table.apellidoMaterno,
    builder: (column) => column,
  );

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get telefono =>
      $composableBuilder(column: $table.telefono, builder: (column) => column);

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  Expression<T> direccionesRefs<T extends Object>(
    Expression<T> Function($$DireccionesTableAnnotationComposer a) f,
  ) {
    final $$DireccionesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.direcciones,
      getReferencedColumn: (t) => t.usuarioId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DireccionesTableAnnotationComposer(
            $db: $db,
            $table: $db.direcciones,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsuariosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsuariosTable,
          Usuario,
          $$UsuariosTableFilterComposer,
          $$UsuariosTableOrderingComposer,
          $$UsuariosTableAnnotationComposer,
          $$UsuariosTableCreateCompanionBuilder,
          $$UsuariosTableUpdateCompanionBuilder,
          (Usuario, $$UsuariosTableReferences),
          Usuario,
          PrefetchHooks Function({bool direccionesRefs})
        > {
  $$UsuariosTableTableManager(_$AppDatabase db, $UsuariosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsuariosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsuariosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsuariosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nombres = const Value.absent(),
                Value<String> apellidoPaterno = const Value.absent(),
                Value<String?> apellidoMaterno = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> telefono = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
              }) => UsuariosCompanion(
                id: id,
                nombres: nombres,
                apellidoPaterno: apellidoPaterno,
                apellidoMaterno: apellidoMaterno,
                email: email,
                telefono: telefono,
                remoteId: remoteId,
                isSynced: isSynced,
                updatedAt: updatedAt,
                isDeleted: isDeleted,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nombres,
                required String apellidoPaterno,
                Value<String?> apellidoMaterno = const Value.absent(),
                required String email,
                required String telefono,
                Value<String?> remoteId = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
              }) => UsuariosCompanion.insert(
                id: id,
                nombres: nombres,
                apellidoPaterno: apellidoPaterno,
                apellidoMaterno: apellidoMaterno,
                email: email,
                telefono: telefono,
                remoteId: remoteId,
                isSynced: isSynced,
                updatedAt: updatedAt,
                isDeleted: isDeleted,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$UsuariosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({direccionesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (direccionesRefs) db.direcciones],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (direccionesRefs)
                    await $_getPrefetchedData<
                      Usuario,
                      $UsuariosTable,
                      Direccion
                    >(
                      currentTable: table,
                      referencedTable: $$UsuariosTableReferences
                          ._direccionesRefsTable(db),
                      managerFromTypedResult: (p0) => $$UsuariosTableReferences(
                        db,
                        table,
                        p0,
                      ).direccionesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.usuarioId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$UsuariosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsuariosTable,
      Usuario,
      $$UsuariosTableFilterComposer,
      $$UsuariosTableOrderingComposer,
      $$UsuariosTableAnnotationComposer,
      $$UsuariosTableCreateCompanionBuilder,
      $$UsuariosTableUpdateCompanionBuilder,
      (Usuario, $$UsuariosTableReferences),
      Usuario,
      PrefetchHooks Function({bool direccionesRefs})
    >;
typedef $$DireccionesTableCreateCompanionBuilder =
    DireccionesCompanion Function({
      Value<int> id,
      required int usuarioId,
      required String alias,
      required String calle,
      required String numeroExt,
      required String numeroInt,
      required String colonia,
      required String codigoPostal,
      required String municipio,
      required String estado,
      Value<String?> remoteId,
      Value<bool> isSynced,
      Value<DateTime?> updatedAt,
      Value<bool> isDeleted,
    });
typedef $$DireccionesTableUpdateCompanionBuilder =
    DireccionesCompanion Function({
      Value<int> id,
      Value<int> usuarioId,
      Value<String> alias,
      Value<String> calle,
      Value<String> numeroExt,
      Value<String> numeroInt,
      Value<String> colonia,
      Value<String> codigoPostal,
      Value<String> municipio,
      Value<String> estado,
      Value<String?> remoteId,
      Value<bool> isSynced,
      Value<DateTime?> updatedAt,
      Value<bool> isDeleted,
    });

final class $$DireccionesTableReferences
    extends BaseReferences<_$AppDatabase, $DireccionesTable, Direccion> {
  $$DireccionesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsuariosTable _usuarioIdTable(_$AppDatabase db) =>
      db.usuarios.createAlias(
        $_aliasNameGenerator(db.direcciones.usuarioId, db.usuarios.id),
      );

  $$UsuariosTableProcessedTableManager get usuarioId {
    final $_column = $_itemColumn<int>('usuario_id')!;

    final manager = $$UsuariosTableTableManager(
      $_db,
      $_db.usuarios,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_usuarioIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DireccionesTableFilterComposer
    extends Composer<_$AppDatabase, $DireccionesTable> {
  $$DireccionesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get alias => $composableBuilder(
    column: $table.alias,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get calle => $composableBuilder(
    column: $table.calle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get numeroExt => $composableBuilder(
    column: $table.numeroExt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get numeroInt => $composableBuilder(
    column: $table.numeroInt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get colonia => $composableBuilder(
    column: $table.colonia,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get codigoPostal => $composableBuilder(
    column: $table.codigoPostal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get municipio => $composableBuilder(
    column: $table.municipio,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  $$UsuariosTableFilterComposer get usuarioId {
    final $$UsuariosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuarioId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableFilterComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DireccionesTableOrderingComposer
    extends Composer<_$AppDatabase, $DireccionesTable> {
  $$DireccionesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get alias => $composableBuilder(
    column: $table.alias,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get calle => $composableBuilder(
    column: $table.calle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get numeroExt => $composableBuilder(
    column: $table.numeroExt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get numeroInt => $composableBuilder(
    column: $table.numeroInt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get colonia => $composableBuilder(
    column: $table.colonia,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get codigoPostal => $composableBuilder(
    column: $table.codigoPostal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get municipio => $composableBuilder(
    column: $table.municipio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsuariosTableOrderingComposer get usuarioId {
    final $$UsuariosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuarioId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableOrderingComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DireccionesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DireccionesTable> {
  $$DireccionesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get alias =>
      $composableBuilder(column: $table.alias, builder: (column) => column);

  GeneratedColumn<String> get calle =>
      $composableBuilder(column: $table.calle, builder: (column) => column);

  GeneratedColumn<String> get numeroExt =>
      $composableBuilder(column: $table.numeroExt, builder: (column) => column);

  GeneratedColumn<String> get numeroInt =>
      $composableBuilder(column: $table.numeroInt, builder: (column) => column);

  GeneratedColumn<String> get colonia =>
      $composableBuilder(column: $table.colonia, builder: (column) => column);

  GeneratedColumn<String> get codigoPostal => $composableBuilder(
    column: $table.codigoPostal,
    builder: (column) => column,
  );

  GeneratedColumn<String> get municipio =>
      $composableBuilder(column: $table.municipio, builder: (column) => column);

  GeneratedColumn<String> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  $$UsuariosTableAnnotationComposer get usuarioId {
    final $$UsuariosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuarioId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableAnnotationComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DireccionesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DireccionesTable,
          Direccion,
          $$DireccionesTableFilterComposer,
          $$DireccionesTableOrderingComposer,
          $$DireccionesTableAnnotationComposer,
          $$DireccionesTableCreateCompanionBuilder,
          $$DireccionesTableUpdateCompanionBuilder,
          (Direccion, $$DireccionesTableReferences),
          Direccion,
          PrefetchHooks Function({bool usuarioId})
        > {
  $$DireccionesTableTableManager(_$AppDatabase db, $DireccionesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DireccionesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DireccionesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DireccionesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> usuarioId = const Value.absent(),
                Value<String> alias = const Value.absent(),
                Value<String> calle = const Value.absent(),
                Value<String> numeroExt = const Value.absent(),
                Value<String> numeroInt = const Value.absent(),
                Value<String> colonia = const Value.absent(),
                Value<String> codigoPostal = const Value.absent(),
                Value<String> municipio = const Value.absent(),
                Value<String> estado = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
              }) => DireccionesCompanion(
                id: id,
                usuarioId: usuarioId,
                alias: alias,
                calle: calle,
                numeroExt: numeroExt,
                numeroInt: numeroInt,
                colonia: colonia,
                codigoPostal: codigoPostal,
                municipio: municipio,
                estado: estado,
                remoteId: remoteId,
                isSynced: isSynced,
                updatedAt: updatedAt,
                isDeleted: isDeleted,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int usuarioId,
                required String alias,
                required String calle,
                required String numeroExt,
                required String numeroInt,
                required String colonia,
                required String codigoPostal,
                required String municipio,
                required String estado,
                Value<String?> remoteId = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
              }) => DireccionesCompanion.insert(
                id: id,
                usuarioId: usuarioId,
                alias: alias,
                calle: calle,
                numeroExt: numeroExt,
                numeroInt: numeroInt,
                colonia: colonia,
                codigoPostal: codigoPostal,
                municipio: municipio,
                estado: estado,
                remoteId: remoteId,
                isSynced: isSynced,
                updatedAt: updatedAt,
                isDeleted: isDeleted,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DireccionesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({usuarioId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (usuarioId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.usuarioId,
                                referencedTable: $$DireccionesTableReferences
                                    ._usuarioIdTable(db),
                                referencedColumn: $$DireccionesTableReferences
                                    ._usuarioIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$DireccionesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DireccionesTable,
      Direccion,
      $$DireccionesTableFilterComposer,
      $$DireccionesTableOrderingComposer,
      $$DireccionesTableAnnotationComposer,
      $$DireccionesTableCreateCompanionBuilder,
      $$DireccionesTableUpdateCompanionBuilder,
      (Direccion, $$DireccionesTableReferences),
      Direccion,
      PrefetchHooks Function({bool usuarioId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsuariosTableTableManager get usuarios =>
      $$UsuariosTableTableManager(_db, _db.usuarios);
  $$DireccionesTableTableManager get direcciones =>
      $$DireccionesTableTableManager(_db, _db.direcciones);
}
