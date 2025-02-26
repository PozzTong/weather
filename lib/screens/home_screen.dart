import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:whether_bloc/bloc/weather_bloc_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget gerWeatherIcon(int code) {
    switch (code) {
      case >= 200 && < 300:
        return Image.asset('assets/images/storm.png');
      case >= 300 && < 400:
        return Image.asset('assets/images/rainy.png');
      case >= 500 && < 600:
        return Image.asset('assets/images/light_rain.png');
      case >= 600 && < 700:
        return Image.asset('assets/images/snow.png');
      case >= 700 && < 800:
        return Image.asset('assets/images/smokey.png');
      case == 800:
        return Image.asset('assets/images/sunny.png');
      case > 800 && < 884:
        return Image.asset('assets/images/cloudy.png');

      default:
        return Image.asset('assets/images/windy.png');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          20,
          1.2 * kToolbarHeight,
          20,
          20,
        ),
        child: SizedBox(
          height: size.height,
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(3, -0.3),
                child: Container(
                    height: 300,
                    width: 270,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.deepPurple,
                    )),
              ),
              Align(
                alignment: AlignmentDirectional(-3, -0.3),
                child: Container(
                    height: 300,
                    width: 270,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.deepPurple,
                    )),
              ),
              Align(
                alignment: AlignmentDirectional(0, -1.2),
                child: Container(
                  height: 300,
                  width: 600,
                  decoration: BoxDecoration(color: Color(0xFFFFAB40)),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                child: Container(
                  decoration: BoxDecoration(color: Colors.transparent),
                ),
              ),
              BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
                builder: (context, state) {
                  if (state is WeatherBlocSuccess) {
                    return SizedBox(
                      height: size.height,
                      width: size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Icon(
                                  FontAwesomeIcons.mapPin,
                                  size: 12,
                                  color: Colors.red,
                                ),
                              ),
                              Text(
                                state.weather.areaName!,
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Good Morning',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // Image.asset('assets/icons/few_cloud.png'),
                          gerWeatherIcon(state.weather.weatherConditionCode!),
                          Center(
                            child: Text(
                              '${state.weather.temperature!.celsius!.round()}°C',
                              style: TextStyle(
                                fontSize: 55,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              '${state.weather.weatherMain}'.toUpperCase(),
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Center(
                            child: Text(
                              // old style
                              // DateFormat('EEEE, d · hh:mm a')
                              DateFormat('EEEE dd ·')
                                  .add_jm()
                                  .format(state.weather.date!),
                              // 'Friday, 16 · 09:41am',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              hourWidget(
                                asset: 'assets/images/sunny.png',
                                title: 'Sunrise',
                                hour: state.weather.sunrise!,
                              ),
                              hourWidget(
                                asset: 'assets/images/moon.png',
                                title: 'Sunset',
                                hour: state.weather.sunset!,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Divider(
                              color: Colors.grey,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              maxWidget(
                                asset: 'assets/images/thermometer.png',
                                title: 'Temp Max',
                                temp:
                                    '${state.weather.tempMax!.celsius!.round()}°C',
                              ),
                              maxWidget(
                                asset: 'assets/images/cold_thermometer.png',
                                title: 'Temp Min',
                                temp:
                                    '${state.weather.tempMin!.celsius!.round()}°C',
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget hourWidget({
    required String asset,
    required String title,
    required DateTime hour,
  }) {
    return Row(
      children: [
        Image.asset(
          asset,
          scale: 8,
        ),
        SizedBox(
          width: 5,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              DateFormat('hh:mm a').format(hour),
              style: TextStyle(fontWeight: FontWeight.w700),
            )
          ],
        )
      ],
    );
  }

  Widget maxWidget({
    required String asset,
    required String title,
    required String temp,
  }) {
    return Row(
      children: [
        Image.asset(
          asset,
          scale: 8,
        ),
        SizedBox(
          width: 5,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              temp,
              style: TextStyle(fontWeight: FontWeight.w700),
            )
          ],
        )
      ],
    );
  }
}
// 20:30
