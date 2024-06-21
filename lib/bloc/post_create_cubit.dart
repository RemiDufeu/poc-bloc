import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poc_blocs/bloc/post_create_states.dart';
import 'package:poc_blocs/data/http_api_helper.dart';
import 'package:poc_blocs/model/post.dart';

class PostCreateCubit extends Cubit<PostCreateState> {
  PostCreateCubit() : super(PostCreateEdition(Post.defaultPost()));

  final HttpApiHelper helper = HttpApiHelper();

  void createPost(Post newPost) async {
    emit(PostCreatePending());
    try {
      await helper.createPost(newPost);
      emit(PostCreateSuccess());
    } catch (e) {
      emit(PostCreateError('Failed to create post: ${e.toString()}'));
    }
  }

  void editPost(Post newPost) {
    emit(PostCreateEdition(newPost));
  }

  void goBackToEdition(Post newPost) {
    emit(PostCreateEdition(newPost));
  }
}