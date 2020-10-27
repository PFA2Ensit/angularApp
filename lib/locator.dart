import 'package:get_it/get_it.dart';

import 'app/modules/auth/data/repository/user_repository.dart';
import 'app/modules/blog/data/repository/post_repository.dart';
import 'app/modules/comment/data/repository/comment_repository.dart';
import 'app/modules/compte/data/repository/compte_repository.dart';
import 'app/modules/notifications/data/repository/notif_repository.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
    locator.registerLazySingleton(() => UserRepository());
    locator.registerLazySingleton(() => CompteRepository());
    locator.registerLazySingleton(() => PostRepository());
    locator.registerLazySingleton(() => CommentRepository());
    locator.registerLazySingleton(() => NotificationsRepository());



}
