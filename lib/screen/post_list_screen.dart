import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:poc_blocs/bloc/post_detail_cubit.dart';
import 'package:poc_blocs/bloc/post_list_cubit.dart';
import 'package:poc_blocs/bloc/post_list_states.dart';
import 'package:poc_blocs/screen/post_create_screen.dart';
import 'package:poc_blocs/screen/post_detail_screen.dart';
import 'package:poc_blocs/widget/post_tile.dart';

class PostsListScreen extends StatelessWidget {
  PostsListScreen({super.key});

  final queryTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text(
          "Remmit",
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        trailingActions: [
          PlatformIconButton(
            padding: EdgeInsets.zero,
            cupertino: (context, platform) => CupertinoIconButtonData(
              icon: Icon(
                context.platformIcons.addCircledSolid,
                color: Theme.of(context).primaryColor,
              ),
            ),
            icon: Icon(
              context.platformIcons.add,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              Navigator.of(context).push(
                platformPageRoute(
                  context: context,
                  builder: (context) => PostCreateScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: Row(children: [
                Expanded(
                  flex: 4,
                  child: PlatformTextField(
                    controller: queryTextController,
                    hintText: 'Rechercher',
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: PlatformIconButton(
                    icon: Icon(
                      PlatformIcons(context).refresh,
                    ),
                    onPressed: () {
                      final query = queryTextController.text;
                      context.read<PostListCubit>().refreshAll(query);
                      FocusScope.of(context).unfocus();
                    },
                  ),
                ),
              ]),
            ),
            Expanded(
              child: BlocBuilder<PostListCubit, PostListState>(
                builder: (context, state) {
                  if (state is PostListError) {
                    return Text("Erreur : ${state.errorMessage}");
                  }
                  if (state is PostListLoading) {
                    return Center(child: PlatformCircularProgressIndicator());
                  }
                  if (state is PostListLoaded) {
                    return ListView.builder(
                      itemCount: state.posts.length,
                      itemBuilder: (context, index) {
                        final post = state.posts[index];
                        return GestureDetector(
                            onTap: () {
                              context
                                  .read<PostDetailCubit>()
                                  .getDetails(post.id);
                              Navigator.of(context).push(
                                platformPageRoute(
                                  context: context,
                                  builder: (context) =>
                                      const PostDetailScreen(),
                                ),
                              );
                            },
                            child: PostTile(post: post));
                      },
                    );
                  }
                  return PlatformText("Lancez une recherche");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
