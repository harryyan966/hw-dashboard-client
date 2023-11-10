abstract class CRUDRepository<T> {
  const CRUDRepository();

  Future<void> create(T object);

  Future<T?> read(String id);

  Future<List<T>> readAll({int? amount, bool detailed = false});

  Future<void> update(String id, T object);

  Future<void> delete(String id);
}
