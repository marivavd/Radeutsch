import 'package:deutscht/domain/utils.dart';

import '../data/repository/requests.dart';

class SignUpUseCase {
  Future<void> pressButtonSignUp(
      String username,
      String email,
      String password,
      String confPassword,
      Function(void) onResponse,
      Future<void> Function(String) onError
      )async{
    if (password != confPassword){
      onError('Passwords do not match');
    }
    else{
      requestSignUp() async{
        await signUp(username: username, email: email, password: password);
      }
      await requests(requestSignUp, onResponse, onError);
    }

  }
}
