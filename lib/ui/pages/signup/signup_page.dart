import 'package:flutter/material.dart';

import '../../components/components.dart';
import '../../helpers/helpers.dart';
import 'components/components.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage();

  @override
  Widget build(BuildContext context) {
    void _hideKeyBoard() {
      final currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    }

    return Scaffold(
      body: Builder(
        builder: (context) {
          return GestureDetector(
            onTap: _hideKeyBoard,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LoginHeader(),
                  Headline1(text: R.strings.addAccount),
                  Padding(
                    padding: EdgeInsets.all(32),
                    child: Form(
                      child: Column(
                        children: [
                          NameInput(),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: EmailInput(),
                          ),
                          PasswordInput(),
                          Padding(
                            padding: EdgeInsets.only(top: 8, bottom: 32),
                            child: PasswordConfirmationInput(),
                          ),
                          SignUpButton(),
                          FlatButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.exit_to_app),
                            label: Text(R.strings.login),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}