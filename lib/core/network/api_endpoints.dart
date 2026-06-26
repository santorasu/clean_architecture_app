class ApiEndpoints {
  static const String baseUrl = "https://reqres.in/api";

  static  String users(String? page, String? perPage) => "users?page=$page&per_page=$perPage";
}
