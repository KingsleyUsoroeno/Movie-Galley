abstract class CacheModelMapper<M, E> {
  M mapToModel(E entity);

  E mapToEntity(M model);
}
