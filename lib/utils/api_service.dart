import 'dart:convert';
import 'dart:developer';
import 'package:dha_cleaning_app/model/login_request.dart';
import 'package:dha_cleaning_app/model/login_response.dart';
import 'package:dha_cleaning_app/utils/shared_service.dart';
import 'package:http/http.dart' as http;
import '../model/sector_model.dart';
import '../utils/api_constants.dart';
import '../model/phase_model.dart';
import '../model/clients_record.dart';

class ApiService {
  static var client = http.Client();
  Future<List<PhaseRecord>?> getPhases() async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'x-access-token': loginDetails!.token
    };
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.phaseEndpoint);
      var response = await client.get(url, headers: requestHeaders);
      // var respone = await http.get(url);
      if (response.statusCode == 200) {
        List<PhaseRecord> model = phaseRecordFromJson(response.body.toString());
        return model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<Welcome>?> getClients() async {
    try {
      var url = Uri.parse('https://jsonplaceholder.typicode.com/users');
      var response = await client.get(url);
      if (response.statusCode == 200) {
        List<Welcome> model = welcomeFromJson(response.body.toString());
        return model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<SectorRecord>?> getSectors() async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'x-access-token': loginDetails!.token
    };
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.sectorEndpoint);
      var respone = await http.get(url, headers: requestHeaders);
      if (respone.statusCode == 200) {
        List<SectorRecord> model =
            sectorRecordFromJson(respone.body.toString());
        return model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  static Future<bool> login(LoginRequest model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.loginEndpoint);
    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model.toJson()));
    if (response.statusCode == 200) {
      // Shared
      await SharedService.setLoginDetails(loginResponseJson(response.body));
      return true;
    } else {
      return false;
    }
  }

  static Future<String> getUserProfile() async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails!.token}'
    };

    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.userEndpoint);

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "";
    }
  }
}
