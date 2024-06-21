import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:poc_blocs/bloc/post_create_cubit.dart';
import 'package:poc_blocs/bloc/post_create_states.dart';
import 'package:poc_blocs/bloc/post_list_cubit.dart';
import 'package:poc_blocs/model/post.dart';

class PostCreateScreen extends StatelessWidget {
  const PostCreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final initialState = context.read<PostCreateCubit>().state;
    var initialTitle = "";
    var intitialBody = "";

    if (initialState is PostCreateEdition) {
      initialTitle = initialState.newPost.title;
      intitialBody = initialState.newPost.body;
    }

    final titleController = TextEditingController(text: initialTitle);
    final bodyController = TextEditingController(text: intitialBody);

    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: PlatformText('Create Post'),
      ),
      body: SafeArea(
        child: BlocBuilder<PostCreateCubit, PostCreateState>(
          builder: (context, state) {
            if (state is PostCreateError) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.errorMessage,
                      style: const TextStyle(color: Colors.white),
                    ),
                    showCloseIcon: true,
                    backgroundColor: Colors.red,
                    duration: const Duration(seconds: 5),
                  ),
                );
                context.read<PostCreateCubit>().goBackToEdition(
                    Post(0, titleController.text, bodyController.text, []));
              });
            }
            if (state is PostCreateSuccess) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Le post a été publié",
                      style: TextStyle(color: Colors.white),
                    ),
                    showCloseIcon: true,
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 5),
                  ),
                );
                context.read<PostListCubit>().refreshAll("");
                Navigator.of(context).pop(context);
                context
                    .read<PostCreateCubit>()
                    .goBackToEdition(Post.defaultPost());
              });
            }
            if (state is PostCreatePending) {
              return Center(
                child: PlatformCircularProgressIndicator(),
              );
            }
            if (state is PostCreateEdition) {
              return Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Theme.of(context).dividerColor),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: PlatformTextField(
                        controller: titleController,
                        hintText: 'Titre du post',
                        onChanged: (value) {
                          context
                              .read<PostCreateCubit>()
                              .editPost(state.newPost.copyWith(title: value));
                        },
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Theme.of(context).dividerColor),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: PlatformTextField(
                        controller: bodyController,
                        hintText: 'Contenu du post',
                        onChanged: (value) {
                          context
                              .read<PostCreateCubit>()
                              .editPost(state.newPost.copyWith(body: value));
                        },
                        maxLines: 4,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    PlatformElevatedButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        context
                            .read<PostCreateCubit>()
                            .createPost(state.newPost);
                      },
                      child: PlatformText('Create'),
                    ),
                  ],
                ),
              );
            }
            return const Center(
              child: Text(""),
            );
          },
        ),
      ),
    );
  }
}
