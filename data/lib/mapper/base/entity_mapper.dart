abstract class EntityMapper<E, D> {
  D mapFromEntity(E entity);

  E mapToEntity(D domain);
}
