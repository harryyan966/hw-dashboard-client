import 'package:general_utilities/general_utilities.dart';
import 'package:hwdb_models/hwdb_models.dart';

extension UserValidators on User {
  static final _fields = [
    Field(name: 'id,', validator: idValidator, getValue: (User m) => m.id),
    Field(name: 'name,', validator: nameValidator, getValue: (User m) => m.name),
    Field(name: 'profile', validator: localFileValidator, getValue: (User m) => m.profile),
  ];

  void validate() => validateObject(this, _fields);

  List<Field<Object, User>> get fields => _fields;
}
