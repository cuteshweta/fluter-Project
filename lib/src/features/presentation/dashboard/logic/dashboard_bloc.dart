import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:haritashr/src/core/utils/shared_preference/app_shared_preference.dart';
import 'package:haritashr/src/features/domain/usecases/login/logout_usecase.dart';

part 'dashboard_event.dart';

part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  LogoutUseCase useCase;

  DashboardBloc(this.useCase) : super(DashboardState()) {
    on<LogoutRequestedEvent>(_onDashboardLogout);
  }

  Future<void> _onDashboardLogout(
    LogoutRequestedEvent event,
    Emitter<DashboardState> state,
  ) async {
    state(DashboardInitial());

    final result = await useCase.call(AppSharedPreference.instance?.getUserId() ?? "");

    result.fold((l){
      state(DashboardError(msg: l.errorMessage));
    }, (r){
      state(DashboardLogoutSuccess());
    });
  }
}
