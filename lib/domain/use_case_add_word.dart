import 'package:deutscht/domain/utils.dart';

import '../data/repository/requests.dart';

class AddNewWordUseCase {
  Future<void> pressAddNewWord(
      int idOfGroup,
      String germanWord,
      String russianWord,
      Function(void) onResponse,
      Future<void> Function(String) onError
      )async{
    requestAddNewWord() async{
      await addNewWord(idOfGroup: idOfGroup, germanWord: germanWord, russianWord: russianWord);
    }
    await requests(requestAddNewWord, onResponse, onError);

  }
}
