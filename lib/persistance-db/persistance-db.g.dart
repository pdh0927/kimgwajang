// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'persistance-db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Account extends DataClass implements Insertable<Account> {
  final String id;
  final String username;
  final String password;
  final String role;
  Account(
      {required this.id,
      required this.username,
      required this.password,
      required this.role});
  factory Account.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Account(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      username: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}username'])!,
      password: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}password'])!,
      role: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}role'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['username'] = Variable<String>(username);
    map['password'] = Variable<String>(password);
    map['role'] = Variable<String>(role);
    return map;
  }

  AccountsCompanion toCompanion(bool nullToAbsent) {
    return AccountsCompanion(
      id: Value(id),
      username: Value(username),
      password: Value(password),
      role: Value(role),
    );
  }

  factory Account.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Account(
      id: serializer.fromJson<String>(json['id']),
      username: serializer.fromJson<String>(json['username']),
      password: serializer.fromJson<String>(json['password']),
      role: serializer.fromJson<String>(json['role']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'username': serializer.toJson<String>(username),
      'password': serializer.toJson<String>(password),
      'role': serializer.toJson<String>(role),
    };
  }

  Account copyWith(
          {String? id, String? username, String? password, String? role}) =>
      Account(
        id: id ?? this.id,
        username: username ?? this.username,
        password: password ?? this.password,
        role: role ?? this.role,
      );
  @override
  String toString() {
    return (StringBuffer('Account(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('role: $role')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, username, password, role);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Account &&
          other.id == this.id &&
          other.username == this.username &&
          other.password == this.password &&
          other.role == this.role);
}

class AccountsCompanion extends UpdateCompanion<Account> {
  final Value<String> id;
  final Value<String> username;
  final Value<String> password;
  final Value<String> role;
  const AccountsCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.password = const Value.absent(),
    this.role = const Value.absent(),
  });
  AccountsCompanion.insert({
    required String id,
    required String username,
    required String password,
    required String role,
  })  : id = Value(id),
        username = Value(username),
        password = Value(password),
        role = Value(role);
  static Insertable<Account> custom({
    Expression<String>? id,
    Expression<String>? username,
    Expression<String>? password,
    Expression<String>? role,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (username != null) 'username': username,
      if (password != null) 'password': password,
      if (role != null) 'role': role,
    });
  }

  AccountsCompanion copyWith(
      {Value<String>? id,
      Value<String>? username,
      Value<String>? password,
      Value<String>? role}) {
    return AccountsCompanion(
      id: id ?? this.id,
      username: username ?? this.username,
      password: password ?? this.password,
      role: role ?? this.role,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountsCompanion(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('role: $role')
          ..write(')'))
        .toString();
  }
}

class $AccountsTable extends Accounts with TableInfo<$AccountsTable, Account> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccountsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _usernameMeta = const VerificationMeta('username');
  @override
  late final GeneratedColumn<String?> username = GeneratedColumn<String?>(
      'username', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _passwordMeta = const VerificationMeta('password');
  @override
  late final GeneratedColumn<String?> password = GeneratedColumn<String?>(
      'password', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String?> role = GeneratedColumn<String?>(
      'role', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, username, password, role];
  @override
  String get aliasedName => _alias ?? 'accounts';
  @override
  String get actualTableName => 'accounts';
  @override
  VerificationContext validateIntegrity(Insertable<Account> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password']!, _passwordMeta));
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
          _roleMeta, role.isAcceptableOrUnknown(data['role']!, _roleMeta));
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  Account map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Account.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $AccountsTable createAlias(String alias) {
    return $AccountsTable(attachedDatabase, alias);
  }
}

class Complaint extends DataClass implements Insertable<Complaint> {
  final String id;
  final String title;
  final String content;
  final String? reply;
  final String imagePath;
  final int? evaluation;
  final String category;

  Complaint(
      {required this.id,
      required this.title,
      required this.content,
      this.reply,
      required this.imagePath,
      this.evaluation,
      required this.category});
  factory Complaint.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Complaint(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      content: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}content'])!,
      reply: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}reply']),
      imagePath: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}image_path'])!,
      evaluation: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}evaluation']),
      category: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}category'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['content'] = Variable<String>(content);
    if (!nullToAbsent || reply != null) {
      map['reply'] = Variable<String?>(reply);
    }
    map['image_path'] = Variable<String>(imagePath);
    if (!nullToAbsent || evaluation != null) {
      map['evaluation'] = Variable<int?>(evaluation);
    }
    map['category'] = Variable<String>(category);
    return map;
  }

  ComplaintsCompanion toCompanion(bool nullToAbsent) {
    return ComplaintsCompanion(
      id: Value(id),
      title: Value(title),
      content: Value(content),
      reply:
          reply == null && nullToAbsent ? const Value.absent() : Value(reply),
      imagePath: Value(imagePath),
      evaluation: evaluation == null && nullToAbsent
          ? const Value.absent()
          : Value(evaluation),
      category: Value(category),
    );
  }

  factory Complaint.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Complaint(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      content: serializer.fromJson<String>(json['content']),
      reply: serializer.fromJson<String?>(json['reply']),
      imagePath: serializer.fromJson<String>(json['imagePath']),
      evaluation: serializer.fromJson<int?>(json['evaluation']),
      category: serializer.fromJson<String>(json['category']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'content': serializer.toJson<String>(content),
      'reply': serializer.toJson<String?>(reply),
      'imagePath': serializer.toJson<String>(imagePath),
      'evaluation': serializer.toJson<int?>(evaluation),
      'category': serializer.toJson<String>(category),
    };
  }

  Complaint copyWith(
          {String? id,
          String? title,
          String? content,
          String? reply,
          String? imagePath,
          int? evaluation,
          String? category}) =>
      Complaint(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        reply: reply ?? this.reply,
        imagePath: imagePath ?? this.imagePath,
        evaluation: evaluation ?? this.evaluation,
        category: category ?? this.category,
      );
  @override
  String toString() {
    return (StringBuffer('Complaint(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('reply: $reply, ')
          ..write('imagePath: $imagePath, ')
          ..write('evaluation: $evaluation, ')
          ..write('category: $category')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, content, reply, imagePath, evaluation, category);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Complaint &&
          other.id == this.id &&
          other.title == this.title &&
          other.content == this.content &&
          other.reply == this.reply &&
          other.imagePath == this.imagePath &&
          other.evaluation == this.evaluation &&
          other.category == this.category);
}

class ComplaintsCompanion extends UpdateCompanion<Complaint> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> content;
  final Value<String?> reply;
  final Value<String> imagePath;
  final Value<int?> evaluation;
  final Value<String> category;
  const ComplaintsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.reply = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.evaluation = const Value.absent(),
    this.category = const Value.absent(),
  });
  ComplaintsCompanion.insert({
    required String id,
    required String title,
    required String content,
    this.reply = const Value.absent(),
    required String imagePath,
    this.evaluation = const Value.absent(),
    required String category,
  })  : id = Value(id),
        title = Value(title),
        content = Value(content),
        imagePath = Value(imagePath),
        category = Value(category);
  static Insertable<Complaint> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? content,
    Expression<String?>? reply,
    Expression<String>? imagePath,
    Expression<int?>? evaluation,
    Expression<String>? category,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (content != null) 'content': content,
      if (reply != null) 'reply': reply,
      if (imagePath != null) 'image_path': imagePath,
      if (evaluation != null) 'evaluation': evaluation,
      if (category != null) 'category': category,
    });
  }

  ComplaintsCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String>? content,
      Value<String?>? reply,
      Value<String>? imagePath,
      Value<int?>? evaluation,
      Value<String>? category}) {
    return ComplaintsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      reply: reply ?? this.reply,
      imagePath: imagePath ?? this.imagePath,
      evaluation: evaluation ?? this.evaluation,
      category: category ?? this.category,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (reply.present) {
      map['reply'] = Variable<String?>(reply.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (evaluation.present) {
      map['evaluation'] = Variable<int?>(evaluation.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ComplaintsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('reply: $reply, ')
          ..write('imagePath: $imagePath, ')
          ..write('evaluation: $evaluation, ')
          ..write('category: $category')
          ..write(')'))
        .toString();
  }
}

class $ComplaintsTable extends Complaints
    with TableInfo<$ComplaintsTable, Complaint> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ComplaintsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _contentMeta = const VerificationMeta('content');
  @override
  late final GeneratedColumn<String?> content = GeneratedColumn<String?>(
      'content', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _replyMeta = const VerificationMeta('reply');
  @override
  late final GeneratedColumn<String?> reply = GeneratedColumn<String?>(
      'reply', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _imagePathMeta = const VerificationMeta('imagePath');
  @override
  late final GeneratedColumn<String?> imagePath = GeneratedColumn<String?>(
      'image_path', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _evaluationMeta = const VerificationMeta('evaluation');
  @override
  late final GeneratedColumn<int?> evaluation = GeneratedColumn<int?>(
      'evaluation', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _categoryMeta = const VerificationMeta('category');
  @override
  late final GeneratedColumn<String?> category = GeneratedColumn<String?>(
      'category', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, content, reply, imagePath, evaluation, category];
  @override
  String get aliasedName => _alias ?? 'complaints';
  @override
  String get actualTableName => 'complaints';
  @override
  VerificationContext validateIntegrity(Insertable<Complaint> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('reply')) {
      context.handle(
          _replyMeta, reply.isAcceptableOrUnknown(data['reply']!, _replyMeta));
    }
    if (data.containsKey('image_path')) {
      context.handle(_imagePathMeta,
          imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta));
    } else if (isInserting) {
      context.missing(_imagePathMeta);
    }
    if (data.containsKey('evaluation')) {
      context.handle(
          _evaluationMeta,
          evaluation.isAcceptableOrUnknown(
              data['evaluation']!, _evaluationMeta));
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  Complaint map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Complaint.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ComplaintsTable createAlias(String alias) {
    return $ComplaintsTable(attachedDatabase, alias);
  }
}

abstract class _$PersistanceDb extends GeneratedDatabase {
  _$PersistanceDb(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $AccountsTable accounts = $AccountsTable(this);
  late final $ComplaintsTable complaints = $ComplaintsTable(this);
  late final AccountsDao accountsDao = AccountsDao(this as PersistanceDb);
  late final ComplaintsDao complaintsDao = ComplaintsDao(this as PersistanceDb);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [accounts, complaints];
}
