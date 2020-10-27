import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../locator.dart';
import 'package:comptabli_blog/app/modules/notifications/data/repository/notif_repository.dart';
import 'package:comptabli_blog/app/modules/notifications/data/model/notifications.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {

   NotificationsRepository repository = locator<NotificationsRepository>();

  @override
  NotificationsState get initialState => NotificationsInitial();

  @override
  Stream<NotificationsState> mapEventToState(
    NotificationsEvent event,
  ) async* {

    if (event is RetrieveNotifications) {
      yield NotifLoadingState();
      try {
        List<Notifications> comments = await repository.getNotifications();
        yield NotifLoadedState(notif: comments);
      } catch (e) {
        yield NotifFetchErrorState(message: e.toString());
      }
    }


    
  }

}
