class Result<TModel> {
  List<TModel> rowsAsModels = [];
  List<Map<String, dynamic>> rowsAsMaps = [];

  Result({required this.rowsAsMaps, required this.rowsAsModels});
}
