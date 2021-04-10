import 'dart:collection';

class TrashList {
  static List<String> isTrashGetLabel(List<dynamic> labels) {
    List<String> res = [];

    labels.forEach((label) {
      for (int i = 0; i < _filter.length; i++) {
        if (label['label'].contains(_filter[i]))
          res.add(_filter[i]);
      }
    });
    return res;
  }

  static const _filter = ["plastic bag", "bottlecap", "bottle", "cup", "plate"];
  static var _filterSet = HashSet.from(_filter);
  static List<String> get filter => _filter;
  static HashSet<String> get filterSet => _filterSet;
}