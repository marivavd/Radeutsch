import 'package:deutscht/domain/utils.dart';

import '../data/repository/requests.dart';

class ChangeNameOfGroupUseCase {
  Future<void> pressChangeNameOfGroup(
      int idOfGroup,
      String nameOfGroup,
      Function(void) onResponse,
      Future<void> Function(String) onError
      )async{
    requestChangeNameOfGroup() async{
      await changeNameOfGroup(idOfGroup: idOfGroup, nameOfGroup: nameOfGroup);
    }
    await requests(requestChangeNameOfGroup, onResponse, onError);

  }
}