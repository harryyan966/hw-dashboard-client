import 'package:client_model_validators/client_model_validators.dart';
import 'package:general_utilities/general_utilities.dart';
import 'package:hwdb_models/hwdb_models.dart';

void main() {
  final user = User(id: newID(), name: 'harry', profile: 'file.txt', role: Role.admin);
  print(user.fields);
}
