import 'package:deutscht/domain/utils.dart';

import '../data/repository/requests.dart';

class AddNewGroupUseCase {
  Future<void> pressButtonDone(
      String nameofGroup,
      Function(dynamic) onResponse,
      Future<void> Function(String) onError
      )async{
    requestAddNewGroup() async{
      return await addNewGroup(nameofGroup: nameofGroup);
    }
    await requests(requestAddNewGroup, onResponse, onError);

  }
}
