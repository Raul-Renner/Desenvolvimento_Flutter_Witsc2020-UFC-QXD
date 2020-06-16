import 'dart:convert';

import 'package:flutter_Wtisc/data/models/users.dart';
import 'package:http/http.dart' as http;

class UserRepository{
  final client = http.Client();
  Future<Users> getUsers() async {
    final response  = await client.get('https://reqres.in/api/users');

    if(response.statusCode == 200){
      final json = jsonDecode(response.body);
      return Users.fromJson(json);
    }else{
      throw Exception("Não foi possivel carregar os usuarios.");
    }
  }
}