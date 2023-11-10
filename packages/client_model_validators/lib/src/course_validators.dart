import 'package:general_utilities/general_utilities.dart';
import 'package:hwdb_models/hwdb_models.dart';

const haiwaiCreatedIn = 1999;

extension CourseValidators on Course {
  static final _fields = [
    Field(name: 'id', validator: idValidator, getValue: (Course m) => m.id),
    Field(name: 'teacherID', validator: idValidator, getValue: (Course m) => m.teacherID),
    Field(name: 'studentIDs', validator: batchIdValidator, getValue: (Course m) => m.detail?.studentIDs),
    Field(name: 'name', validator: nameValidator, getValue: (Course m) => m.name),
    Field(name: 'description', validator: nonEmptyValidator, getValue: (Course m) => m.description),
    Field(
      name: 'grade',
      validator: nonEmptyValidator.that([Ensures(ValueIs.inRange(1, 12))]),
      getValue: (Course m) => m.grade,
    ),
    Field(
      name: 'startYear',
      validator: nonEmptyValidator.that([Ensures(ValueIs.inRange(haiwaiCreatedIn, DateTime.now().year))]),
      getValue: (Course m) => m.startYear,
    ),
    Field(name: 'assignmentIDs', validator: batchIdValidator, getValue: (Course m) => m.detail?.assignmentIDs),
  ];

  void validate() => validateObject(this, _fields);

  List<Field<Object?, Course>> get fields => _fields;

  List<Field<String, Course>> get searchedFields => _fields.where((field) => ['name', 'description'].contains(field.name)).toList() as List<Field<String, Course>>;
}
