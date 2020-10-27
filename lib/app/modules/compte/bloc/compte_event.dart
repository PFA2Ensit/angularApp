import 'package:comptabli_blog/app/modules/compte/data/model/compte.dart';
import 'package:equatable/equatable.dart';


abstract class CompteEvent extends Equatable {
  const CompteEvent();

  @override
  List<Object> get props => [];
}

class CreateCompte extends CompteEvent {
  final Compte compte;

  CreateCompte({
    this.compte,
  });

}


class ViewProfileEvent extends CompteEvent{
  
}

class UpdateProfileEvent extends CompteEvent{
  final Compte compte;

  UpdateProfileEvent({this.compte});
  
}
