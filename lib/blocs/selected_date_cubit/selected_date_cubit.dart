import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'selected_date_state.dart';

class SelectedDateCubit extends Cubit<SelectedDateState> {
  SelectedDateCubit() : super(SelectedDateInitial());
}
