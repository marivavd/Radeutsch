

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../main.dart';

Future<void> signUp({
  required String username,
  required String email,
  required String password})async{
  final AuthResponse _ = await supabase.auth.signUp(
    email: email,
    password: password);
  await supabase.from('profiles').insert(
    {'username': username, 'id_user': supabase.auth.currentUser!.id}
  );

}

Future<void> signIn({
  required String email,
  required String password})async{
  final AuthResponse _ = await supabase.auth.signInWithPassword(
    email: email,
    password: password,
  );
}


Future<List<Map<String, dynamic>>> getGroups()async{
  final data = await supabase
      .from('groups_of_words')
      .select().eq("id_user", supabase.auth.currentUser!.id).order('created_at', ascending: false);;
  return data;
}

Future<void> deleteWords({
  required int idGroup
})async{
  await supabase
      .from('words')
      .delete()
      .eq('group_id', idGroup);
}

Future<void> deleteGroup({
  required int idGroup
})async{
  await supabase
      .from('groups_of_words')
      .delete()
      .eq('id', idGroup);
}

Future<List<Map<String, dynamic>>> getWords({
  required int groupId
})async{
  final data = await supabase
      .from('words')
      .select().eq("group_id", groupId);
  return data;
}


Future<void> changeNameOfGroup({
  required int idOfGroup,
  required String nameOfGroup
})async{
  await supabase
      .from('groups_of_words')
      .update({'group_name': nameOfGroup }).eq("id", idOfGroup);
}

Future<int> addNewGroup({
  required String nameofGroup
})async{
  final data = await supabase
      .from('groups_of_words')
      .insert({'id_user': supabase.auth.currentUser!.id, 'group_name': nameofGroup}).select()
      .single();
  return data['id'];

}


Future<void> addNewWord({
  required dynamic idOfGroup,
  required String germanWord,
  required String russianWord
})async{
  await supabase
      .from('words')
      .insert({'user_id': supabase.auth.currentUser!.id, 'word': germanWord, 'translate': russianWord, 'group_id': idOfGroup});
}

Future<void> updateWord({
  required dynamic idOfWord,
  required String germanWord,
  required String russianWord
})async{
  await supabase
      .from('words')
      .update({'word': germanWord, 'translate': russianWord})
      .eq('id', idOfWord);
}