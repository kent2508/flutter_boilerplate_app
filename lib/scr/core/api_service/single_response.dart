
class SingleResponse<T> {
  SingleResponse(
    Map<String, dynamic> json,
    T Function(dynamic itemJson) itemConverter,
  ) {
    try {
      item = itemConverter(json);
    } catch (e) {
      print('Error when map single response');
    }
  }
  late T item;
}
