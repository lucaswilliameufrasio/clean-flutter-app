import 'package:test/test.dart';

import 'package:ForDev/main/factories/factories.dart';
import 'package:ForDev/validation/validators/validators.dart';

void main() {
  test('Should return the correct validations', () {
    final validations = makeSignUpValidations();

    expect(validations, [
      RequiredFieldValidation('name'),
      MinLengthValidation(field: 'name', size: 2),
      RequiredFieldValidation('email'),
      EmailValidation('email'),
      RequiredFieldValidation('password'),
      MinLengthValidation(field: 'password', size: 5),
      RequiredFieldValidation('passwordConfirmation'),
      CompareFieldsValidation(
        field: 'passwordConfirmation',
        fieldToCompare: 'password',
      ),
    ]);
  });
}
