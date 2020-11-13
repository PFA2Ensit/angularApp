import 'dart:async';
import 'package:comptabli_blog/app/modules/compte/data/model/compte.dart';
import 'package:comptabli_blog/app/modules/compte/data/repository/compte_repository.dart';
import 'package:flutter/services.dart';
import '../../../../locator.dart';
import 'compte_event.dart';
import 'compte_state.dart';
import 'package:bloc/bloc.dart';




class CompteBloc extends Bloc<CompteEvent, CompteState> {

  CompteRepository repository = locator< CompteRepository>();
  @override
  CompteState get initialState =>  CompteInitial();

  @override
  Stream<CompteState> mapEventToState(
    CompteEvent event,
  ) async* {
    
    if (event is CreateCompte){
      try {
         if(await repository.createCompte(
               event.compte.fullname,event.compte.position,event.compte.expertises,event.compte.interests))
               {
                yield CreateCompleted();}
               else{
                yield AccountExist(message: "account already exists");
               }
        
        
      } on PlatformException catch (error) {
        yield  CreateFailed(error: error);
             
      } catch (ex) {
        yield  CreateFailed(
          error: PlatformException(
            code: ex.toString(),
            message:
                'An error has occued when creating your account, please try again later',
          ),
        );
        
      }
    }
    else if (event is ViewProfileEvent) {
      yield ProfileLoadingState();
      try {
        Compte user = await repository.getUserInfo();
        yield ProfileLoadedState(user: user);
      } catch (e) {
        yield ProfileErrorState(message: e.toString());
      }
    }
     if (event is UpdateProfileEvent){
      try {
        await repository.updateCompte(
               event.compte.fullname,event.compte.position,event.compte.expertises,event.compte.interests,event.compte.photoUrl);
        yield UpdateCompleted();
      } on PlatformException catch (error) {
        yield  CreateFailed(error: error);
      } catch (ex) {
        yield  CreateFailed(
          error: PlatformException(
            code: ex.toString(),
            message:
                'An error has occued when updating your account, please try again later',
          ),
        );
      }
    }

    
  }

  
}
