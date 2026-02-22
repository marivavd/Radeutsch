import 'package:deutscht/data/repository/requests.dart';
import 'package:deutscht/domain/utils.dart';

class DeleteGroupUseCase {
  Future<void> deleteGroupPress(
      int idOfGroup,
      Function(void) onResponse,
      Future<void> Function(String) onError
      )async{
    requestdDeleteGroup() async{
      await deleteGroup(idGroup: idOfGroup);
    }
    await requests(requestdDeleteGroup, onResponse, onError);

  }
}