import 'package:deutscht/domain/utils.dart';

import '../data/repository/requests.dart';

class SignInUseCase {
  Future<void> pressButtonSignIn(
      String email,
      String password,
      Function(void) onResponse,
      Future<void> Function(String) onError
      )async{
      requestSignIn() async{
        await signIn(email: email, password: password);
      }
      await requests(requestSignIn, onResponse, onError);

  }
}
