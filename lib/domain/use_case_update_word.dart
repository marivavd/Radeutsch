import 'package:deutscht/domain/utils.dart';

import '../data/repository/requests.dart';

class UpdateWordUseCase {
  Future<void> pressUpdateWord(
      int idOfWord,
      String germanWord,
      String russianWord,
      Function(void) onResponse,
      Future<void> Function(String) onError
      )async{
    requestUpdateWord() async{
      await updateWord(idOfWord: idOfWord, germanWord: germanWord, russianWord: russianWord);
    }
    await requests(requestUpdateWord, onResponse, onError);

  }
}