import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather/weather.dart';
import 'package:geolocator/geolocator.dart';

import '../data/data.dart';

part 'weather_bloc_event.dart';
part 'weather_bloc_state.dart';

class WeatherBlocBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
  WeatherBlocBloc() : super(WeatherBlocInitial()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherBlocLoading());
      try {
        WeatherFactory wf = WeatherFactory(apikey, language: Language.ENGLISH);
        // Position position = await Geolocator.getCurrentPosition();
        Weather w = await wf.currentWeatherByLocation(
          event.position.latitude,
          event.position.longitude,
        );
        print(w);
        emit(WeatherBlocSuccess(w));
      } catch (e) {
        emit(WeatherBlocFailure());
      }
    });
  }
}

