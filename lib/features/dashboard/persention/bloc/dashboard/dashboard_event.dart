part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

class LoadingDashboardEvent extends DashboardEvent {
  const LoadingDashboardEvent();
}


class GetAllDashboardCoursesEvent extends DashboardEvent {
  const GetAllDashboardCoursesEvent();
}


