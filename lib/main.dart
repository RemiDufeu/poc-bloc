import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:poc_blocs/bloc/post_create_cubit.dart';
import 'package:poc_blocs/bloc/post_detail_cubit.dart';
import 'package:poc_blocs/bloc/post_list_cubit.dart';
import 'package:poc_blocs/screen/post_list_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  final MaterialColor primaryColor = Colors.deepPurple;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PostListCubit>(
          create: (_) => PostListCubit(),
        ),
        BlocProvider<PostCreateCubit>(
          create: (_) => PostCreateCubit(),
        ),
        BlocProvider<PostDetailCubit>(
          create: (_) => PostDetailCubit(),
        ),
      ],
      child: PlatformApp(
        material: (_, __) => MaterialAppData(
          theme: ThemeData(
            primaryColor: primaryColor,
          ),
        ),
        cupertino: (_, __) => CupertinoAppData(
          theme: CupertinoThemeData(
            primaryColor: primaryColor, // Remplacez par votre couleur primaire
          ),
        ),
        home: PostsListScreen(),
        title: 'Super poc',
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
