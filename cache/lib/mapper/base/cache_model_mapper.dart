/// Where [M] is the Model class response from your cache module or more
/// specifically the data class in which you save to the databse and [E] is the
/// entity class from your data layer*/

abstract class CacheModelMapper<M, E> {
  M mapToModel(E entity);

  E mapToEntity(M model);

  List<E> mapToEntityList(List<M> models) {
    return models.map((e) => mapToEntity(e)).toList();
  }

  List<M> mapFromEntityList(List<E> models) {
    return models.map((e) => mapToModel(e)).toList();
  }
}
