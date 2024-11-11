import 'package:dio/dio.dart';

final dio = Dio();

const APIBASEURL = "https://api.tvmaze.com";

void getHttp() async {
  final response = await dio.get('https://dart.dev');
  print(response);
}

dynamic getHomeItems() async {
  final response = await dio.get("$APIBASEURL/search/shows?q=all");
  return response.data;
}

dynamic getSearchResults(String query) async {
  final response = await dio.get("$APIBASEURL/search/shows?q=$query");
  return response.data;
}
