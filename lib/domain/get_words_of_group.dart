import 'package:deutscht/data/models/word_model.dart';
import '../data/repository/requests.dart';

Future<List<WordModel>> getWordsOfGroup({required int groupId})async{
  final data = await getWords(groupId: groupId);
  List<WordModel> sp = [];
  for (int i = 0; i < data.length; i++){
    sp.add(WordModel(wordId: data[i]['id'], word: data[i]['word'], translate: data[i]['translate'], groupId: data[i]['group_id']));
  }
  return sp;
}