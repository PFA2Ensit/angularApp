part of 'notifications_bloc.dart';
abstract class NotificationsState extends Equatable {
  const NotificationsState();
  
  @override
  List<Object> get props => [];
}

class NotificationsInitial extends NotificationsState {}

class NotifLoadingState extends NotificationsState {
  @override
  List<Object> get props => [];
}

class NotifLoadedState extends NotificationsState {

  final List<Notifications> notif;
  
    NotifLoadedState({this.notif});
  
    @override
    List<Object> get props => [notif];
  }
  
  

class NotifFetchErrorState extends  NotificationsState {

  final String message;

   NotifFetchErrorState({ this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}
