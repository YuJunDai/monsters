// ignore_for_file: file_names

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:monsters_front_end/main.dart';

import '../API/annoyanceAPI.dart';
import '../model/annoyanceModel.dart';
import 'package:http/http.dart' as http;

// const String domain = "http://10.0.2.2:8080";
const String domain = "http://220.132.124.140:5000";

class AnnoyanceRepository implements AnnoyanceApiDataSource {
  final client = http.Client();
  @override
  Future<Map<String, dynamic>?> createAnnoyance(Annoyance annoyance) {
    return _createAnnoyance(Uri.parse('$domain/annoyance/create'), annoyance);
  }

  @override
  Future<Map<String, dynamic>?> searchAnnoyanceByAccount(String account) {
    return _searchAnnoyanceByAccount(
        Uri.parse('$domain/annoyance/search/$userAccount'));
  }

  @override
  Future<String> modifyAnnoyance(int id, Annoyance annoyance) {
    return _modifyAnnoyance(
        Uri.parse('$domain/annoyance/modify/$id/$userAccount'), annoyance);
  }

  Future<Map<String, dynamic>?> _createAnnoyance(
    Uri url,
    Annoyance annoyance,
  ) async {
    try {
      var body = json.encode(annoyance);
      var request = await client.post(url,
          headers: {'Content-type': 'application/json'}, body: body);

      log("dev_annoyanceChat");
      log("annoyance BODY: \n" + annoyance.toString());
      log("statue: " + request.statusCode.toString());
      log("body: " + request.body.toString());

      if (request.statusCode == 201) {
        Map<String, dynamic> annoyance = jsonDecode(request.body);
        return Future.value(annoyance);
      } else {
        Map<String, dynamic> annoyance = jsonDecode(request.body);
        return annoyance;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<Map<String, dynamic>?> _searchAnnoyanceByAccount(Uri url) async {
    try {
      final request =
          await client.get(url, headers: {'Content-type': 'application/json'});
      if (request.statusCode == 200) {
        Map<String, dynamic> annoyance = jsonDecode(request.body);
        return Future.value(annoyance);
      } else {
        Map<String, dynamic> annoyance = jsonDecode(request.body);
        return annoyance;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<String> _modifyAnnoyance(
    Uri url,
    Annoyance annoyance,
  ) async {
    log(json.encode(annoyance).toString());
    try {
      final request = await client.patch(
        url,
        headers: {'Content-type': 'application/json'},
        body: json.encode(annoyance),
      );
      log("modify statusCode: " + request.statusCode.toString());
      log("modify body: " + request.body.toString());
      if (request.statusCode == 200) {
        return request.body;
      } else {
        return Future.value(request.body);
      }
    } catch (e) {
      return e.toString();
    }
  }
}
