import 'package:deutscht/data/repository/requests.dart';
import 'package:deutscht/domain/utils.dart';

class DeleteWordsUseCase {
  Future<void> deleteWordsPress(
      int idOfGroup,
      Function(void) onResponse,
      Future<void> Function(String) onError
      )async{
    requestdDeleteWords() async{
      await deleteWords(idGroup: idOfGroup);
    }
    await requests(requestdDeleteWords, onResponse, onError);

  }
}