import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/constants/api_servers.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/server/header_server.dart';

abstract class SPSRemoteDataSource {
  Future<List<SparePart>> getAllData(String partId);
}

class SPSRemoteImplWithHttp extends SPSRemoteDataSource {
  final http.Client client;
  SPSRemoteImplWithHttp({required this.client});

  @override
  Future<List<SparePart>> getAllData(String partId) async {
    final response = await client.get(
        Uri.parse("${BASE_URL}api/SparePart/getSparePart?partId=$partId"),
        headers: HeaderServer.headerWithToken);
    // if (response.statusCode == 200 || response.statusCode == 201) {
    //   final decodeJson = json.decode(response.body);
    //   return (decodeJson as List<dynamic>?)
    //           ?.map((e) => SparePart.fromJson(e as Map<String, dynamic>))
    //           .toList() ??
    //       [];
    // } else {
    //   throw ServerExecption();
    // }

    return List<SparePart>.empty();

  }
}

class SparePart {
  static fromJson(Map<String, dynamic> e) {}
}
