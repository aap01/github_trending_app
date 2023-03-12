import 'package:github_favs/core/data/exception/app_exception.dart';
import 'package:github_favs/core/data/model/model.dart';

abstract class LocalDataSource<TModel> {
  void addAll({
    required List<TModel> modelList,
  });
  List<TModel> getAll();
  TModel getById({
    required int id,
  });
  void clear();
}

abstract class LocalDataSourceImpl<TModel extends Model>
    implements LocalDataSource<TModel> {
  final Map<int, TModel> _map;
  LocalDataSourceImpl({
    required Map<int, TModel> map,
  }) : _map = map;
  @override
  void addAll({required List<TModel> modelList}) {
    _map.clear();
    for (var e in modelList) {
      _map.putIfAbsent(e.id, () => e);
    }
  }

  @override
  List<TModel> getAll() {
    return _map.values.toList();
  }

  @override
  TModel getById({required int id}) {
    try {
      return _map[id]!;
    } on Exception {
      throw AppException.mappingException();
    }
  }

  @override
  void clear() {
    _map.clear();
  }
}
