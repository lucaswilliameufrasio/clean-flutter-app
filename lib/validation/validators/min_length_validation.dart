import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../presentation/protocols/protocols.dart';

import '../protocols/protocols.dart';

class MinLengthValidation extends Equatable implements FieldValidation {
  final String field;
  final int size;

  List<Object> get props => [field, size];

  MinLengthValidation({@required this.field, @required this.size});

  ValidationError validate(String value) {
    return value != null && value.length >= size
        ? null
        : ValidationError.invalidField;
  }
}
