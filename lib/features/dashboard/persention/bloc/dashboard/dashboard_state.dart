part of 'dashboard_bloc.dart';



abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

class DashboardInitial extends DashboardState {}

//!loading
class LoadingDashboardState extends DashboardState {
  const LoadingDashboardState();
}

//!Error
class ErrorDashboardState extends DashboardState {
  final String message;
  const ErrorDashboardState({required this.message});
}


class GetDashboardSuccessfulState extends DashboardState {
  const GetDashboardSuccessfulState();
}


class LoadedCoursesState extends DashboardState{
  const LoadedCoursesState( {required this.courses});
  final List<Course> courses;
  @override
  List<Object> get props => [courses];
}
