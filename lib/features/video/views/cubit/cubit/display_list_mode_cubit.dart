import 'package:bloc/bloc.dart';

class DisplayListModeCubit extends Cubit<bool> {
  DisplayListModeCubit() : super(true);

  void toggleDisplayMode() {
    emit(!state);
  }
}
