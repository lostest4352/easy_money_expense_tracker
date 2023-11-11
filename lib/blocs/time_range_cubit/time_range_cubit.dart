import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';

part 'time_range_state.dart';

part 'time_range_cubit.g.dart';

class TimeRangeCubit extends HydratedCubit<TimeRangeState> {
  TimeRangeCubit() : super(TimeRangeState());

  @override
  TimeRangeState? fromJson(Map<String, dynamic> json) {
    return TimeRangeState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(TimeRangeState state) {
    return state.toJson();
  }
}
