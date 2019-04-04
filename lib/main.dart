import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/src/blocs/transaction_supervisor.dart';
import 'src/app.dart';

void main() {
  BlocSupervisor().delegate = SimpleStateTransitionSupervisor();
  runApp(App());
}
