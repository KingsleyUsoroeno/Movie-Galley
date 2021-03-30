/// Where [M] is the Model class response from the server and [E] is the
/// entity class from your data layer*/

abstract class RemoteModelMapper<M, E> {
  E mapFromModel(M model);

  List<E> mapModelList(List<M> models) {
    return models.map((e) => mapFromModel(e)).toList();
  }
}
