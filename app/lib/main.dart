import 'package:app/cubit/museum_cubit/museum_cubit.dart';
import 'package:app/cubit/ticket_cubit/ticket_cubit.dart';
import 'package:app/cubit/user_cubit/user_cubit.dart';
import 'package:app/screens/home_screen.dart';
import 'package:app/services/museum_repository.dart';
import 'package:app/services/user_repository.dart';
import 'package:app/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MultiBlocProvider(providers: [
    BlocProvider<MuseumCubit>(
      create: (context) => MuseumCubit(MuseumRepository()),
    ),
    BlocProvider<UserCubit>(
      create: (context) => UserCubit(UserRepository()),
    ),
    BlocProvider<TicketCubit>(
      create: (context) => TicketCubit(UserRepository()),
    )
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeClass.theme,
      home: HomePage(),
    );
  }
}
