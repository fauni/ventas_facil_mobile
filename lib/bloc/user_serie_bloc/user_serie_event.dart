abstract class UserSerieEvent {
  const UserSerieEvent();
}

class GetUserSerieByUser extends UserSerieEvent{
  final String idUsuario;

  GetUserSerieByUser(this.idUsuario);
}