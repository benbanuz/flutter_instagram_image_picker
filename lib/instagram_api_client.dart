import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'model/photo_paging.dart';

class InstagramApiClient {
  static const String _endpoint =
      'https://instagram-media-api-2021.herokuapp.com';

  InstagramApiClient();

  Future<Map> signInUser(String username, String password) async {
    String url = "$_endpoint/login?username=$username&password=$password";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      return {};
    }
    return json.decode(response.body);
  }

  Future<PhotoPaging> fetchPhotos({
    @required String sessionKey,
    @required String userId,
  }) async {
    //String url = pagingUrl ?? '$_graphApiEndpoint/?access_token=$_accessToken';

    String url = "$_endpoint/media?sessionKey=$sessionKey&user_id=$userId";

    var response = await http.get(Uri.parse(url));

    Map<String, dynamic> body = {};
    if (response.statusCode == 200) {
      body = json.decode(response.body);
    }

    return PhotoPaging.fromJson(body);
  }
}