part of 'time_range_cubit.dart';

@JsonSerializable()
final class TimeRangeState extends Equatable {
  final String? startTime;
  final String? endTime;
  final String buttonName;

  // ignore: prefer_const_constructors_in_immutables
  TimeRangeState({
    this.startTime,
    this.endTime,
    this.buttonName = "This Month",
  });

  factory TimeRangeState.fromJson(Map<String, dynamic> json) =>
      _$TimeRangeStateFromJson(json);
  Map<String, dynamic> toJson() => _$TimeRangeStateToJson(this);

  TimeRangeState copyWith({
    String? startTime,
    String? endTime,
    String? buttonName,
  }) {
    return TimeRangeState(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      buttonName: buttonName ?? this.buttonName,
    );
  }

  @override
  List<Object?> get props => [startTime, endTime, buttonName];
}
