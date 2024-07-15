import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../model/api_model.dart';

enum Method { post, get, delete, put, patch }

class APIManager {
  static final APIManager apiManagerInstanace = APIManager._internal();

  factory APIManager() => apiManagerInstanace;

  APIManager._internal();

  Future<bool> _checkConnection() async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      return connectivityResult != ConnectivityResult.none;
    } catch (e) {
      print('Error checking connection: $e');
      return false; // Handle error scenario
    }
  }

  Future<ApiResponseModel> request(
      String webUrl,
      Method method,
      Map<String, dynamic> param,
      ) async {
    log("Api Web URL .. $webUrl");
    final bool connectionStatus = await _checkConnection();
    late ApiResponseModel apiResponse;
    late ErrorModel error;
    if (!connectionStatus) {
      error = ErrorModel(
        "No Internet",
        "No internet connection.",
        503,
      );
      Fluttertoast.showToast(
          msg: 'No internet connection.'
              .toString()
              .replaceFirst("HttpException: ", "")
              .replaceAll("\\", ''));
      return apiResponse = ApiResponseModel(null, error, false);
    }

    Dio dio = Dio();
    late Response response;
    Map<String, String> headers = {};
    // final String? token = await localStorage.getValue("token");
    // final String? languageKey = await localStorage.getValue("lang");
    // log('Auth Token -----> $token');
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // if (token != null) headers['Authorization'] = "Bearer $token";
    headers["Content-Type"] = "application/json";
    // headers["Accept-Language"] = languageKey ?? "en";
    String? encodedData = json.encode(param);
    log('Encode Param Data -----> $encodedData');
    log("header -----> $headers");
    log(method.toString());
    try {
      if (method == Method.get) {
        log("Get API Calling");
        response = await dio.get(webUrl,
            options: Options(
              headers: headers,
            ),
            queryParameters: param);
        // log('Get API Calling ----> ${response.toString()}');
      }
      // else if (method == Method.post) {
      //   response = await dio.post(webUrl,
      //       options: Options(headers: headers),
      //       queryParameters: param); //data: encodedData);
      //   log('response ----->');
      //   log(response.toString());
      // } else if (method == Method.put) {
      //   response = await dio.put(webUrl,
      //       options: Options(headers: headers), data: encodedData);
      // } else if (method == Method.delete) {
      //   response =
      //   await dio.delete(webUrl, options: Options(headers: headers));
      // } else if (method == Method.patch) {
      //   response = await dio.patch(webUrl,
      //       options: Options(headers: headers), data: encodedData);
      // }

      final responseData = response.data;

      if (responseData['message'] == "jwt expired" ||
          responseData['message'] == "wt malformed") {
        error = ErrorModel(
          "Unauthorized",
          "Token Expired, Please login again.",
          responseData['statusCode'],
        );
        apiResponse = ApiResponseModel(null, error, false);
      }

      if (response.statusCode! >= 200 && response.statusCode! < 401) {
        if (response.data != null && response.data.isNotEmpty) {
          log('sdaafgsdsffdsf ${responseData['status']}');
          if (responseData['status'].runtimeType != Null ? responseData['status'] : true) {
            apiResponse = ApiResponseModel(responseData, null, true);
          } else {
            error = ErrorModel(
              "Error",
              "${responseData['message']}",
              responseData['responsecode'],
            );
            apiResponse = ApiResponseModel(null, error, false);
          }
        }
      } else if (response.statusCode == 401) {
        ErrorModel(
          "Unauthorized",
          "Token Expired, Please login again.",
          responseData['statusCode'],
        );
        apiResponse = ApiResponseModel(null, error, false);
      } else if (response.statusCode == 500) {
        apiResponse = ApiResponseModel(
            null,
            ErrorModel(
              '',
              'Internal server error',
              responseData['statusCode'],
            ),
            false);
      } else {
        log("ahsvdjhas ");
        if (response.data != null && response.data.isNotEmpty) {
          error = ErrorModel(
            "",
            responseData['message'],
            responseData['responsecode'],
          );
          apiResponse = ApiResponseModel(null, error, false);
        } else {
          error = ErrorModel(
            "Something went wrong!",
            "Looks like there was an error in reaching our servers. Press Refresh to try again or come back after some time.",
            504,
          );
          apiResponse = ApiResponseModel(null, error, false);
        }
      }
    } on DioException catch (e) {

      log('E----- > ${e.message}');
      if(e.response!.data['error'] == 'Token is Expired' || e.response!.data['error'] == 'Authorization Token not found'){
        // await localStorage.clearStorage();
        // WidgetsBinding.instance.addPostFrameCallback((_) {
        //   get_x.Get.offAndToNamed(RouteName.loginScreen);
        // });
        error = ErrorModel(
          "Something went wrong!",
          e.response!.statusMessage.toString(),
          e.response!.statusCode!,
        );
        apiResponse = ApiResponseModel(null, error, false);
      } else if (e.response != null) {
        // Handle server error response
        log('Server error...: $e');
        log('Server error...: ${e.response!.statusCode}');
        log('Server error: ${e.response!.statusMessage}');
        log('Error Model... ${e.response!.statusCode}');
        error = ErrorModel(
          "Something went wrong!",
          e.response!.data['message'],
          e.response!.statusCode!,
        );
        apiResponse = ApiResponseModel(null, error, false);
      } else {
        log('Network error: ${e.message}');
        log('Server error: ${e.response!.statusCode}');
        log('Server error: ${e.response!.statusMessage}');
        // Handle network error
        log('Network error: ${e.message}');
        error = ErrorModel(
          "Something went wrong!",
          "Something went wrong. Please try again.",
          e.response?.statusCode ?? 400,
        );
        apiResponse = ApiResponseModel(null, error, false);
      }
    } catch (e) {
      log("asjdajshdfsj");
      log("$e");
      error = ErrorModel(
        "Something went wrong!",
        "Something went wrong. Please try again.",
        504,
      );
      apiResponse = ApiResponseModel(null, error, false);
    }
    log('Return Api Response.... $apiResponse');
    return apiResponse;
  }
}