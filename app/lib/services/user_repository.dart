import 'package:app/models/ticket.dart';
import 'package:app/models/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserRepository {
  final Dio _dio = Dio();
  final FlutterSecureStorage localStorage = new FlutterSecureStorage();
  final baseUrl = "https://museum-booking.ew.r.appspot.com";

  Future<bool> isLoggedIn() async {
    return await localStorage.read(key: 'token') != null;
  }

  Future<void> persistToken(String token) async {
    await localStorage.write(key: 'token', value: token);
  }

  Future<void> deleteToken() async {
    localStorage.delete(key: 'token');
  }

  Future<String> login(String username, String password) async {
    try {
      Response response = await _dio.post(baseUrl + '/users/login',
          data: {"username": username, "password": password});
      return response.data["token"].toString();
    } catch (err) {
      return "";
    }
  }

  Future<dynamic> signUp(User user) async {
    Response response =
        await _dio.post(baseUrl + '/users/signup', data: User.toJson(user));
    return response.data;
  }

  Future<List<Ticket>> getUserTickets() async {
    if (await isLoggedIn()) {
      Response response = await _dio.get(baseUrl + "/tickets",
          options: Options(headers: {
            "Authorization":
                "Bearer " + localStorage.read(key: 'token').toString()
          }));
      return response.data.map<Ticket>((json) => User.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  createNewUserTicket(Ticket ticket) async {
    if (await isLoggedIn()) {
      try {
        await _dio.post(baseUrl + "/tickets",
            data: Ticket.toJson(ticket),
            options: Options(headers: {
              "Authorization":
                  "Bearer " + localStorage.read(key: 'token').toString()
            }));
      } catch (err) {
        throw ErrorDescription(err.toString());
      }
    }
  }

  cancelTicket(String id) async {
    if (await isLoggedIn()) {
      try {
        await _dio.post(baseUrl + "/tickets/$id/cancel",
            options: Options(headers: {
              "Authorization":
                  "Bearer " + localStorage.read(key: 'token').toString()
            }));
      } catch (err) {
        throw ErrorDescription(err.toString());
      }
    }
  }
}
