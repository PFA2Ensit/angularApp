import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app/modules/auth/bloc/auth_bloc.dart';
import 'app/modules/auth/bloc/auth_event.dart';
import 'app/modules/blog/bloc/blog_bloc.dart';
import 'app/modules/blog/bloc/blog_event.dart';
import 'app/modules/comment/bloc/comment_bloc.dart';
import 'app/modules/compte/bloc/compte_bloc.dart';
import 'app/modules/compte/bloc/compte_event.dart';
import 'app/modules/notifications/bloc/notifications_bloc.dart';
import 'app/themes/constants.dart';
import 'app_routes.dart';
import 'core/i18n/translations_delegate.dart';
import 'locator.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  setupLocator();
  //firebaseFirestore.instance.settings(timestampsInSnapshotsEnabled:true);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     
    return MaterialApp(
      title: "Comptabli",
      theme: generatecomptabliTheme(context),
      localizationsDelegates: [
        const TranslationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: kSupportedLocales.toList(growable: false).map(
            (lang) => Locale(lang, ''),
          ),
      localeResolutionCallback:
          (Locale locale, Iterable<Locale> supportedLocales) {
        final localByDefault =
            supportedLocales.where((Locale l) => l.languageCode == 'en').first;

        if (locale == null) {
          return localByDefault;
        }
        for (Locale supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode ||
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return localByDefault;
      },
      
       builder: (_, widget) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<AuthenticationBloc>(
              create: (context) {
                return AuthenticationBloc()..add(AppStarted());
              },
            ),
            BlocProvider<CompteBloc>(
              create: (context) {
                return CompteBloc()..add(CreateCompte());
              },
            ),
             BlocProvider<BlogBloc>(
              create: (context) {
                return BlogBloc()..add(AddPost());
              },
            ),
             BlocProvider<CommentBloc>(
              create: (context) {
                return CommentBloc()..add(FetchComments());
              },
            ),
             BlocProvider<NotificationsBloc>(
              create: (context) {
                return NotificationsBloc()..add(RetrieveNotifications());
              },
            ),
          ],
          child: widget,

        );
      },
      initialRoute: kMainRoute,
      onGenerateRoute: Router.generateRoute,
      //home: Scaffold(body:BlocProvider(create:(_) => AuthenticationBloc(),
      //child:LoginScreen())
        );
    
  }
}



