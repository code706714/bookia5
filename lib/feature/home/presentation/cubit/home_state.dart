class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {
  String? message;

  HomeSuccessState({this.message});
}

class HomeErrorState extends HomeState {}
