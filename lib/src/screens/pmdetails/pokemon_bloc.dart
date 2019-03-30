import 'package:bloc/bloc.dart';

import 'package:pokedex/src/screens/pmdetails/pokemon_events.dart';
import 'package:pokedex/src/screens/pmdetails/pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  @override
  PokemonState get initialState => PokemonState.initial();

  @override
  Stream<PokemonState> mapEventToState(PokemonEvent event) async* {
    if (event is FetchPokemonEvent) {
      yield PokemonState.initial();
    }
  }

  void onFetchPokemon() => dispatch(FetchPokemonEvent());
}
