import 'package:equatable/equatable.dart';

class AccountEntity extends Equatable {
  final String token;

  List get props => [token];

  AccountEntity(this.token);
}
