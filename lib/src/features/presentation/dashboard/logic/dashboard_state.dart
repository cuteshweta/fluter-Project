part of 'dashboard_bloc.dart';

class DashboardState extends Equatable {
  const DashboardState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {
  @override
  List<Object> get props => [];
}

class DashboardError extends DashboardState {
  final String msg;

  DashboardError({required this.msg});

  @override
  List<Object?> get props => [msg];
}


class DashboardLogoutSuccess extends DashboardState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
