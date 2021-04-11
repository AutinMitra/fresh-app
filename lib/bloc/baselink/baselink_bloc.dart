import 'dart:async';

import 'package:bloc/bloc.dart';
import 'baselink_event.dart';
import 'baselink_state.dart';

class BaseLinkBloc extends Bloc<BaseLinkEvent, BaseLinkState> {

  @override
  Stream<BaseLinkState> mapEventToState(BaseLinkEvent event) async* {
    if (event is BaseLinkChangeEvent) {
      yield BaseLinkExistsState((event as BaseLinkChangeEvent).uriBase);
    }
  }

  BaseLinkBloc(BaseLinkState initialState) : super(initialState);
}