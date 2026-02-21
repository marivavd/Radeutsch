

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../main.dart';

Future<void> signUp({
  required String username,
  required String email,
  required String password})async{
  final AuthResponse res = await supabase.auth.signUp(
    email: email,
    password: password);
  await supabase.from('profiles').insert(
    {'username': username, 'id_user': supabase.auth.currentUser!.id}
  );

}

Future<void> signIn({
  required String email,
  required String password})async{
  final AuthResponse res = await supabase.auth.signInWithPassword(
    email: email,
    password: password,
  );
}


Future<List<Map<String, dynamic>>> get_groups()async{
  final data = await supabase
      .from('groups_of_words')
      .select().eq("id_user", supabase.auth.currentUser!.id);
  return data;
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