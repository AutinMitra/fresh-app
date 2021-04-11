import 'package:flutter/material.dart';

@immutable
abstract class BaseLinkEvent {}

class BaseLinkChangeEvent extends BaseLinkEvent {
  final String uriBase;

  BaseLinkChangeEvent(this.uriBase);
}