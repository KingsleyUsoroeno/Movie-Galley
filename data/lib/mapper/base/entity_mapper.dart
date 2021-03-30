abstract class EntityMapper<E, D> {
  D mapFromEntity(E entity);

  E mapToEntity(D domain);

  List<E> mapToEntityList(List<D> models) {
    return models.map((e) => mapToEntity(e)).toList();
  }

  List<D> mapFromEntityList(List<E> models) {
    return models.map((e) => mapFromEntity(e)).toList();
  }
}
