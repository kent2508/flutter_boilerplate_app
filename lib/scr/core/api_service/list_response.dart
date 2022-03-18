class ListResponse<T> {
  ListResponse(dynamic json, T Function(dynamic itemJson) itemConverter) {
    if (json is List) {
      items = json.map(itemConverter).toList();
    } else if (json is Map) {
      items = json.values.map(itemConverter).toList();
    }
  }

  List<T> items = [];

  @override
  String toString() {
    return items.map((f) => f.toString()).toString();
  }
}
