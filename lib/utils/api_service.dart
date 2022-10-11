import 'dart:convert';
import 'dart:developer';
import 'package:dha_cleaning_app/model/login_request.dart';
import 'package:dha_cleaning_app/model/login_response.dart';
import 'package:dha_cleaning_app/utils/shared_service.dart';
import 'package:http/http.dart' as http;
import '../model/sector_model.dart';
import '../utils/api_constants.dart';
import '../model/phase_model.dart';

class ApiService {
  static var client = http.Client();
  Future<List<PhaseRecord>?> getPhases() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.phaseEndpoint);
      var respone = await http.get(url);
      if (respone.statusCode == 200) {
        List<PhaseRecord> model = phaseRecordFromJson(respone.body);
        return model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<SectorRecord>?> getSectors() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.sectorEndpoint);
      var respone = await http.get(url);
      if (respone.statusCode == 200) {
        List<SectorRecord> model = sectorRecordFromJson(respone.body);
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
    var url = Uri.http(ApiConstants.baseUrl, ApiConstants.loginEndpoint);
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

    var url = Uri.http(ApiConstants.baseUrl, ApiConstants.userEndpoint);

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
