import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class BaseLinkState extends Equatable {
  final List _props;

  BaseLinkState([this._props]) : super();

  @override
  List<Object> get props => _props;
}

class BaseLinkNoneState extends BaseLinkState {}

class BaseLinkExistsState extends BaseLinkState {
  final String baseUrl;

  BaseLinkExistsState(this.baseUrl) : super([baseUrl]);
}