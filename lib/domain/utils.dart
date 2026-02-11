import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> requests<T>(
    Future<T> Function() request,
    Function(T) onResponse,
    Future<void> Function(String) onError
    )async{
  try{
    var response = await request();
    onResponse(response);
  }
  on PostgrestException catch(e){
    await onError(e.message);
  }
  on AuthException catch(e){
    await onError(e.message);
  }
  catch(e){
    await onError(e.toString());
  }

}

