// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dbModel.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSysConfigCollection on Isar {
  IsarCollection<SysConfig> get sysConfigs => this.collection();
}

const SysConfigSchema = CollectionSchema(
  name: r'SysConfig',
  id: 3507946124670994995,
  properties: {
    r'encryptStr': PropertySchema(
      id: 0,
      name: r'encryptStr',
      type: IsarType.string,
    ),
    r'passwordVersion': PropertySchema(
      id: 1,
      name: r'passwordVersion',
      type: IsarType.long,
    ),
    r'userId': PropertySchema(
      id: 2,
      name: r'userId',
      type: IsarType.long,
    ),
    r'userRsaPri': PropertySchema(
      id: 3,
      name: r'userRsaPri',
      type: IsarType.string,
    ),
    r'userRsaPub': PropertySchema(
      id: 4,
      name: r'userRsaPub',
      type: IsarType.string,
    ),
    r'webRsaPub': PropertySchema(
      id: 5,
      name: r'webRsaPub',
      type: IsarType.string,
    )
  },
  estimateSize: _sysConfigEstimateSize,
  serialize: _sysConfigSerialize,
  deserialize: _sysConfigDeserialize,
  deserializeProp: _sysConfigDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _sysConfigGetId,
  getLinks: _sysConfigGetLinks,
  attach: _sysConfigAttach,
  version: '3.1.0+1',
);

int _sysConfigEstimateSize(
  SysConfig object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.encryptStr.length * 3;
  bytesCount += 3 + object.userRsaPri.length * 3;
  bytesCount += 3 + object.userRsaPub.length * 3;
  bytesCount += 3 + object.webRsaPub.length * 3;
  return bytesCount;
}

void _sysConfigSerialize(
  SysConfig object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.encryptStr);
  writer.writeLong(offsets[1], object.passwordVersion);
  writer.writeLong(offsets[2], object.userId);
  writer.writeString(offsets[3], object.userRsaPri);
  writer.writeString(offsets[4], object.userRsaPub);
  writer.writeString(offsets[5], object.webRsaPub);
}

SysConfig _sysConfigDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SysConfig();
  object.encryptStr = reader.readString(offsets[0]);
  object.id = id;
  object.passwordVersion = reader.readLong(offsets[1]);
  object.userId = reader.readLong(offsets[2]);
  object.userRsaPri = reader.readString(offsets[3]);
  object.userRsaPub = reader.readString(offsets[4]);
  object.webRsaPub = reader.readString(offsets[5]);
  return object;
}

P _sysConfigDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _sysConfigGetId(SysConfig object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _sysConfigGetLinks(SysConfig object) {
  return [];
}

void _sysConfigAttach(IsarCollection<dynamic> col, Id id, SysConfig object) {
  object.id = id;
}

extension SysConfigQueryWhereSort
    on QueryBuilder<SysConfig, SysConfig, QWhere> {
  QueryBuilder<SysConfig, SysConfig, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SysConfigQueryWhere
    on QueryBuilder<SysConfig, SysConfig, QWhereClause> {
  QueryBuilder<SysConfig, SysConfig, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension SysConfigQueryFilter
    on QueryBuilder<SysConfig, SysConfig, QFilterCondition> {
  QueryBuilder<SysConfig, SysConfig, QAfterFilterCondition> encryptStrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'encryptStr',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterFilterCondition>
      encryptStrGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'encryptStr',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterFilterCondition> encryptStrLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'encryptStr',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterFilterCondition> encryptStrBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'encryptStr',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterFilterCondition>
      encryptStrStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'encryptStr',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterFilterCondition> encryptStrEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'encryptStr',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterFilterCondition> encryptStrContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'encryptStr',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterFilterCondition> encryptStrMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'encryptStr',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterFilterCondition>
      encryptStrIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'encryptStr',
        value: '',
      ));
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterFilterCondition>
      encryptStrIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'encryptStr',
        value: '',
      ));
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterFilterCondition>
      passwordVersionEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'passwordVersion',
        value: value,
      ));
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterFilterCondition>
      passwordVersionGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'passwordVersion',
        value: value,
      ));
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterFilterCondition>
      passwordVersionLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'passwordVersion',
        value: value,
      ));
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterFilterCondition>
      passwordVersionBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'passwordVersion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterFilterCondition> userIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: value,
      ));
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterFilterCondition> userIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userId',
        value: value,
      ));
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterFilterCondition> userIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userId',
        value: value,
      ));
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterFilterCondition> userIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterFilterCondition> userRsaPriEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userRsaPri',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterFilterCondition>
      userRsaPriGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userRsaPri',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterFilterCondition> userRsaPriLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userRsaPri',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterFilterCondition> userRsaPriBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userRsaPri',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterFilterCondition>
      userRsaPriStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'userRsaPri',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterFilterCondition> userRsaPriEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'userRsaPri',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterFilterCondition> userRsaPriContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'userRsaPri',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterFilterCondition> userRsaPriMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'userRsaPri',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterFilterCondition>
      userRsaPriIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userRsaPri',
        value: '',
      ));
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterFilterCondition>
      userRsaPriIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userRsaPri',
        value: '',
      ));
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterFilterCondition> userRsaPubEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userRsaPub',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterFilterCondition>
      userRsaPubGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userRsaPub',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterFilterCondition> userRsaPubLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userRsaPub',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterFilterCondition> userRsaPubBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userRsaPub',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterFilterCondition>
      userRsaPubStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'userRsaPub',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterFilterCondition> userRsaPubEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'userRsaPub',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterFilterCondition> userRsaPubContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'userRsaPub',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterFilterCondition> userRsaPubMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'userRsaPub',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterFilterCondition>
      userRsaPubIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userRsaPub',
        value: '',
      ));
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterFilterCondition>
      userRsaPubIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userRsaPub',
        value: '',
      ));
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterFilterCondition> webRsaPubEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'webRsaPub',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterFilterCondition>
      webRsaPubGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'webRsaPub',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterFilterCondition> webRsaPubLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'webRsaPub',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterFilterCondition> webRsaPubBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'webRsaPub',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterFilterCondition> webRsaPubStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'webRsaPub',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterFilterCondition> webRsaPubEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'webRsaPub',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterFilterCondition> webRsaPubContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'webRsaPub',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterFilterCondition> webRsaPubMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'webRsaPub',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterFilterCondition> webRsaPubIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'webRsaPub',
        value: '',
      ));
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterFilterCondition>
      webRsaPubIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'webRsaPub',
        value: '',
      ));
    });
  }
}

extension SysConfigQueryObject
    on QueryBuilder<SysConfig, SysConfig, QFilterCondition> {}

extension SysConfigQueryLinks
    on QueryBuilder<SysConfig, SysConfig, QFilterCondition> {}

extension SysConfigQuerySortBy on QueryBuilder<SysConfig, SysConfig, QSortBy> {
  QueryBuilder<SysConfig, SysConfig, QAfterSortBy> sortByEncryptStr() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'encryptStr', Sort.asc);
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterSortBy> sortByEncryptStrDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'encryptStr', Sort.desc);
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterSortBy> sortByPasswordVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'passwordVersion', Sort.asc);
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterSortBy> sortByPasswordVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'passwordVersion', Sort.desc);
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterSortBy> sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterSortBy> sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterSortBy> sortByUserRsaPri() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userRsaPri', Sort.asc);
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterSortBy> sortByUserRsaPriDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userRsaPri', Sort.desc);
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterSortBy> sortByUserRsaPub() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userRsaPub', Sort.asc);
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterSortBy> sortByUserRsaPubDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userRsaPub', Sort.desc);
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterSortBy> sortByWebRsaPub() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'webRsaPub', Sort.asc);
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterSortBy> sortByWebRsaPubDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'webRsaPub', Sort.desc);
    });
  }
}

extension SysConfigQuerySortThenBy
    on QueryBuilder<SysConfig, SysConfig, QSortThenBy> {
  QueryBuilder<SysConfig, SysConfig, QAfterSortBy> thenByEncryptStr() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'encryptStr', Sort.asc);
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterSortBy> thenByEncryptStrDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'encryptStr', Sort.desc);
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterSortBy> thenByPasswordVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'passwordVersion', Sort.asc);
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterSortBy> thenByPasswordVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'passwordVersion', Sort.desc);
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterSortBy> thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterSortBy> thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterSortBy> thenByUserRsaPri() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userRsaPri', Sort.asc);
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterSortBy> thenByUserRsaPriDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userRsaPri', Sort.desc);
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterSortBy> thenByUserRsaPub() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userRsaPub', Sort.asc);
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterSortBy> thenByUserRsaPubDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userRsaPub', Sort.desc);
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterSortBy> thenByWebRsaPub() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'webRsaPub', Sort.asc);
    });
  }

  QueryBuilder<SysConfig, SysConfig, QAfterSortBy> thenByWebRsaPubDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'webRsaPub', Sort.desc);
    });
  }
}

extension SysConfigQueryWhereDistinct
    on QueryBuilder<SysConfig, SysConfig, QDistinct> {
  QueryBuilder<SysConfig, SysConfig, QDistinct> distinctByEncryptStr(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'encryptStr', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SysConfig, SysConfig, QDistinct> distinctByPasswordVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'passwordVersion');
    });
  }

  QueryBuilder<SysConfig, SysConfig, QDistinct> distinctByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId');
    });
  }

  QueryBuilder<SysConfig, SysConfig, QDistinct> distinctByUserRsaPri(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userRsaPri', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SysConfig, SysConfig, QDistinct> distinctByUserRsaPub(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userRsaPub', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SysConfig, SysConfig, QDistinct> distinctByWebRsaPub(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'webRsaPub', caseSensitive: caseSensitive);
    });
  }
}

extension SysConfigQueryProperty
    on QueryBuilder<SysConfig, SysConfig, QQueryProperty> {
  QueryBuilder<SysConfig, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SysConfig, String, QQueryOperations> encryptStrProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'encryptStr');
    });
  }

  QueryBuilder<SysConfig, int, QQueryOperations> passwordVersionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'passwordVersion');
    });
  }

  QueryBuilder<SysConfig, int, QQueryOperations> userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }

  QueryBuilder<SysConfig, String, QQueryOperations> userRsaPriProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userRsaPri');
    });
  }

  QueryBuilder<SysConfig, String, QQueryOperations> userRsaPubProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userRsaPub');
    });
  }

  QueryBuilder<SysConfig, String, QQueryOperations> webRsaPubProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'webRsaPub');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetWebSiteCollection on Isar {
  IsarCollection<WebSite> get webSites => this.collection();
}

const WebSiteSchema = CollectionSchema(
  name: r'WebSite',
  id: -7945561397567868082,
  properties: {
    r'icon': PropertySchema(
      id: 0,
      name: r'icon',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 1,
      name: r'name',
      type: IsarType.string,
    ),
    r'url': PropertySchema(
      id: 2,
      name: r'url',
      type: IsarType.string,
    ),
    r'webKey': PropertySchema(
      id: 3,
      name: r'webKey',
      type: IsarType.string,
    )
  },
  estimateSize: _webSiteEstimateSize,
  serialize: _webSiteSerialize,
  deserialize: _webSiteDeserialize,
  deserializeProp: _webSiteDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _webSiteGetId,
  getLinks: _webSiteGetLinks,
  attach: _webSiteAttach,
  version: '3.1.0+1',
);

int _webSiteEstimateSize(
  WebSite object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.icon.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.url.length * 3;
  bytesCount += 3 + object.webKey.length * 3;
  return bytesCount;
}

void _webSiteSerialize(
  WebSite object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.icon);
  writer.writeString(offsets[1], object.name);
  writer.writeString(offsets[2], object.url);
  writer.writeString(offsets[3], object.webKey);
}

WebSite _webSiteDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = WebSite(
    reader.readStringOrNull(offsets[0]) ?? '',
    reader.readStringOrNull(offsets[1]) ?? '',
    reader.readStringOrNull(offsets[2]) ?? '',
    reader.readStringOrNull(offsets[3]) ?? '',
  );
  object.id = id;
  return object;
}

P _webSiteDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 1:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 2:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 3:
      return (reader.readStringOrNull(offset) ?? '') as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _webSiteGetId(WebSite object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _webSiteGetLinks(WebSite object) {
  return [];
}

void _webSiteAttach(IsarCollection<dynamic> col, Id id, WebSite object) {
  object.id = id;
}

extension WebSiteQueryWhereSort on QueryBuilder<WebSite, WebSite, QWhere> {
  QueryBuilder<WebSite, WebSite, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension WebSiteQueryWhere on QueryBuilder<WebSite, WebSite, QWhereClause> {
  QueryBuilder<WebSite, WebSite, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension WebSiteQueryFilter
    on QueryBuilder<WebSite, WebSite, QFilterCondition> {
  QueryBuilder<WebSite, WebSite, QAfterFilterCondition> iconEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'icon',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterFilterCondition> iconGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'icon',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterFilterCondition> iconLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'icon',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterFilterCondition> iconBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'icon',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterFilterCondition> iconStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'icon',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterFilterCondition> iconEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'icon',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterFilterCondition> iconContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'icon',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterFilterCondition> iconMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'icon',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterFilterCondition> iconIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'icon',
        value: '',
      ));
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterFilterCondition> iconIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'icon',
        value: '',
      ));
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterFilterCondition> urlEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterFilterCondition> urlGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterFilterCondition> urlLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterFilterCondition> urlBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'url',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterFilterCondition> urlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterFilterCondition> urlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterFilterCondition> urlContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterFilterCondition> urlMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'url',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterFilterCondition> urlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'url',
        value: '',
      ));
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterFilterCondition> urlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'url',
        value: '',
      ));
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterFilterCondition> webKeyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'webKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterFilterCondition> webKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'webKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterFilterCondition> webKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'webKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterFilterCondition> webKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'webKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterFilterCondition> webKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'webKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterFilterCondition> webKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'webKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterFilterCondition> webKeyContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'webKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterFilterCondition> webKeyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'webKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterFilterCondition> webKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'webKey',
        value: '',
      ));
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterFilterCondition> webKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'webKey',
        value: '',
      ));
    });
  }
}

extension WebSiteQueryObject
    on QueryBuilder<WebSite, WebSite, QFilterCondition> {}

extension WebSiteQueryLinks
    on QueryBuilder<WebSite, WebSite, QFilterCondition> {}

extension WebSiteQuerySortBy on QueryBuilder<WebSite, WebSite, QSortBy> {
  QueryBuilder<WebSite, WebSite, QAfterSortBy> sortByIcon() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'icon', Sort.asc);
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterSortBy> sortByIconDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'icon', Sort.desc);
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterSortBy> sortByUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'url', Sort.asc);
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterSortBy> sortByUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'url', Sort.desc);
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterSortBy> sortByWebKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'webKey', Sort.asc);
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterSortBy> sortByWebKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'webKey', Sort.desc);
    });
  }
}

extension WebSiteQuerySortThenBy
    on QueryBuilder<WebSite, WebSite, QSortThenBy> {
  QueryBuilder<WebSite, WebSite, QAfterSortBy> thenByIcon() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'icon', Sort.asc);
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterSortBy> thenByIconDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'icon', Sort.desc);
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterSortBy> thenByUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'url', Sort.asc);
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterSortBy> thenByUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'url', Sort.desc);
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterSortBy> thenByWebKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'webKey', Sort.asc);
    });
  }

  QueryBuilder<WebSite, WebSite, QAfterSortBy> thenByWebKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'webKey', Sort.desc);
    });
  }
}

extension WebSiteQueryWhereDistinct
    on QueryBuilder<WebSite, WebSite, QDistinct> {
  QueryBuilder<WebSite, WebSite, QDistinct> distinctByIcon(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'icon', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<WebSite, WebSite, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<WebSite, WebSite, QDistinct> distinctByUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'url', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<WebSite, WebSite, QDistinct> distinctByWebKey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'webKey', caseSensitive: caseSensitive);
    });
  }
}

extension WebSiteQueryProperty
    on QueryBuilder<WebSite, WebSite, QQueryProperty> {
  QueryBuilder<WebSite, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<WebSite, String, QQueryOperations> iconProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'icon');
    });
  }

  QueryBuilder<WebSite, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<WebSite, String, QQueryOperations> urlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'url');
    });
  }

  QueryBuilder<WebSite, String, QQueryOperations> webKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'webKey');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPassWordCollection on Isar {
  IsarCollection<PassWord> get passWords => this.collection();
}

const PassWordSchema = CollectionSchema(
  name: r'PassWord',
  id: 8121996108529604997,
  properties: {
    r'isEncryption': PropertySchema(
      id: 0,
      name: r'isEncryption',
      type: IsarType.bool,
    ),
    r'isModify': PropertySchema(
      id: 1,
      name: r'isModify',
      type: IsarType.bool,
    ),
    r'value': PropertySchema(
      id: 2,
      name: r'value',
      type: IsarType.string,
    ),
    r'version': PropertySchema(
      id: 3,
      name: r'version',
      type: IsarType.long,
    ),
    r'webKey': PropertySchema(
      id: 4,
      name: r'webKey',
      type: IsarType.string,
    )
  },
  estimateSize: _passWordEstimateSize,
  serialize: _passWordSerialize,
  deserialize: _passWordDeserialize,
  deserializeProp: _passWordDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _passWordGetId,
  getLinks: _passWordGetLinks,
  attach: _passWordAttach,
  version: '3.1.0+1',
);

int _passWordEstimateSize(
  PassWord object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.value.length * 3;
  bytesCount += 3 + object.webKey.length * 3;
  return bytesCount;
}

void _passWordSerialize(
  PassWord object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.isEncryption);
  writer.writeBool(offsets[1], object.isModify);
  writer.writeString(offsets[2], object.value);
  writer.writeLong(offsets[3], object.version);
  writer.writeString(offsets[4], object.webKey);
}

PassWord _passWordDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PassWord(
    reader.readStringOrNull(offsets[4]) ?? '',
    reader.readStringOrNull(offsets[2]) ?? '',
    reader.readLongOrNull(offsets[3]) ?? 0,
    reader.readBoolOrNull(offsets[1]) ?? false,
    reader.readBoolOrNull(offsets[0]) ?? false,
  );
  object.id = id;
  return object;
}

P _passWordDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 1:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 2:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 3:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 4:
      return (reader.readStringOrNull(offset) ?? '') as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _passWordGetId(PassWord object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _passWordGetLinks(PassWord object) {
  return [];
}

void _passWordAttach(IsarCollection<dynamic> col, Id id, PassWord object) {
  object.id = id;
}

extension PassWordQueryWhereSort on QueryBuilder<PassWord, PassWord, QWhere> {
  QueryBuilder<PassWord, PassWord, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PassWordQueryWhere on QueryBuilder<PassWord, PassWord, QWhereClause> {
  QueryBuilder<PassWord, PassWord, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<PassWord, PassWord, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<PassWord, PassWord, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PassWord, PassWord, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PassWord, PassWord, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension PassWordQueryFilter
    on QueryBuilder<PassWord, PassWord, QFilterCondition> {
  QueryBuilder<PassWord, PassWord, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PassWord, PassWord, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PassWord, PassWord, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PassWord, PassWord, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PassWord, PassWord, QAfterFilterCondition> isEncryptionEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isEncryption',
        value: value,
      ));
    });
  }

  QueryBuilder<PassWord, PassWord, QAfterFilterCondition> isModifyEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isModify',
        value: value,
      ));
    });
  }

  QueryBuilder<PassWord, PassWord, QAfterFilterCondition> valueEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PassWord, PassWord, QAfterFilterCondition> valueGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PassWord, PassWord, QAfterFilterCondition> valueLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PassWord, PassWord, QAfterFilterCondition> valueBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'value',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PassWord, PassWord, QAfterFilterCondition> valueStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PassWord, PassWord, QAfterFilterCondition> valueEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PassWord, PassWord, QAfterFilterCondition> valueContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PassWord, PassWord, QAfterFilterCondition> valueMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'value',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PassWord, PassWord, QAfterFilterCondition> valueIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'value',
        value: '',
      ));
    });
  }

  QueryBuilder<PassWord, PassWord, QAfterFilterCondition> valueIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'value',
        value: '',
      ));
    });
  }

  QueryBuilder<PassWord, PassWord, QAfterFilterCondition> versionEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'version',
        value: value,
      ));
    });
  }

  QueryBuilder<PassWord, PassWord, QAfterFilterCondition> versionGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'version',
        value: value,
      ));
    });
  }

  QueryBuilder<PassWord, PassWord, QAfterFilterCondition> versionLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'version',
        value: value,
      ));
    });
  }

  QueryBuilder<PassWord, PassWord, QAfterFilterCondition> versionBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'version',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PassWord, PassWord, QAfterFilterCondition> webKeyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'webKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PassWord, PassWord, QAfterFilterCondition> webKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'webKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PassWord, PassWord, QAfterFilterCondition> webKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'webKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PassWord, PassWord, QAfterFilterCondition> webKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'webKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PassWord, PassWord, QAfterFilterCondition> webKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'webKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PassWord, PassWord, QAfterFilterCondition> webKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'webKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PassWord, PassWord, QAfterFilterCondition> webKeyContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'webKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PassWord, PassWord, QAfterFilterCondition> webKeyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'webKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PassWord, PassWord, QAfterFilterCondition> webKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'webKey',
        value: '',
      ));
    });
  }

  QueryBuilder<PassWord, PassWord, QAfterFilterCondition> webKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'webKey',
        value: '',
      ));
    });
  }
}

extension PassWordQueryObject
    on QueryBuilder<PassWord, PassWord, QFilterCondition> {}

extension PassWordQueryLinks
    on QueryBuilder<PassWord, PassWord, QFilterCondition> {}

extension PassWordQuerySortBy on QueryBuilder<PassWord, PassWord, QSortBy> {
  QueryBuilder<PassWord, PassWord, QAfterSortBy> sortByIsEncryption() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEncryption', Sort.asc);
    });
  }

  QueryBuilder<PassWord, PassWord, QAfterSortBy> sortByIsEncryptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEncryption', Sort.desc);
    });
  }

  QueryBuilder<PassWord, PassWord, QAfterSortBy> sortByIsModify() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isModify', Sort.asc);
    });
  }

  QueryBuilder<PassWord, PassWord, QAfterSortBy> sortByIsModifyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isModify', Sort.desc);
    });
  }

  QueryBuilder<PassWord, PassWord, QAfterSortBy> sortByValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'value', Sort.asc);
    });
  }

  QueryBuilder<PassWord, PassWord, QAfterSortBy> sortByValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'value', Sort.desc);
    });
  }

  QueryBuilder<PassWord, PassWord, QAfterSortBy> sortByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.asc);
    });
  }

  QueryBuilder<PassWord, PassWord, QAfterSortBy> sortByVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.desc);
    });
  }

  QueryBuilder<PassWord, PassWord, QAfterSortBy> sortByWebKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'webKey', Sort.asc);
    });
  }

  QueryBuilder<PassWord, PassWord, QAfterSortBy> sortByWebKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'webKey', Sort.desc);
    });
  }
}

extension PassWordQuerySortThenBy
    on QueryBuilder<PassWord, PassWord, QSortThenBy> {
  QueryBuilder<PassWord, PassWord, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PassWord, PassWord, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PassWord, PassWord, QAfterSortBy> thenByIsEncryption() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEncryption', Sort.asc);
    });
  }

  QueryBuilder<PassWord, PassWord, QAfterSortBy> thenByIsEncryptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEncryption', Sort.desc);
    });
  }

  QueryBuilder<PassWord, PassWord, QAfterSortBy> thenByIsModify() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isModify', Sort.asc);
    });
  }

  QueryBuilder<PassWord, PassWord, QAfterSortBy> thenByIsModifyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isModify', Sort.desc);
    });
  }

  QueryBuilder<PassWord, PassWord, QAfterSortBy> thenByValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'value', Sort.asc);
    });
  }

  QueryBuilder<PassWord, PassWord, QAfterSortBy> thenByValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'value', Sort.desc);
    });
  }

  QueryBuilder<PassWord, PassWord, QAfterSortBy> thenByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.asc);
    });
  }

  QueryBuilder<PassWord, PassWord, QAfterSortBy> thenByVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.desc);
    });
  }

  QueryBuilder<PassWord, PassWord, QAfterSortBy> thenByWebKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'webKey', Sort.asc);
    });
  }

  QueryBuilder<PassWord, PassWord, QAfterSortBy> thenByWebKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'webKey', Sort.desc);
    });
  }
}

extension PassWordQueryWhereDistinct
    on QueryBuilder<PassWord, PassWord, QDistinct> {
  QueryBuilder<PassWord, PassWord, QDistinct> distinctByIsEncryption() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isEncryption');
    });
  }

  QueryBuilder<PassWord, PassWord, QDistinct> distinctByIsModify() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isModify');
    });
  }

  QueryBuilder<PassWord, PassWord, QDistinct> distinctByValue(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'value', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PassWord, PassWord, QDistinct> distinctByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'version');
    });
  }

  QueryBuilder<PassWord, PassWord, QDistinct> distinctByWebKey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'webKey', caseSensitive: caseSensitive);
    });
  }
}

extension PassWordQueryProperty
    on QueryBuilder<PassWord, PassWord, QQueryProperty> {
  QueryBuilder<PassWord, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PassWord, bool, QQueryOperations> isEncryptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isEncryption');
    });
  }

  QueryBuilder<PassWord, bool, QQueryOperations> isModifyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isModify');
    });
  }

  QueryBuilder<PassWord, String, QQueryOperations> valueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'value');
    });
  }

  QueryBuilder<PassWord, int, QQueryOperations> versionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'version');
    });
  }

  QueryBuilder<PassWord, String, QQueryOperations> webKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'webKey');
    });
  }
}
