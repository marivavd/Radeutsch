import '../data/models/group_model.dart';
import '../data/repository/requests.dart';

Future<List<GroupModel>> getGroupsForUser()async{
  final data = await get_groups();
  List<GroupModel> sp = [];
  for (int i = 0; i < data.length; i++){
    sp.add(GroupModel(groupId: data[i]['id'], groupName: data[i]['group_name'], userId: data[i]['id_user']));
  }
  return sp;
}