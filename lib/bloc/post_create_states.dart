import 'package:poc_blocs/model/post.dart';

abstract class PostCreateState {}

class PostCreateEdition extends PostCreateState {
  final Post newPost;
  PostCreateEdition(this.newPost);
}

class PostCreatePending extends PostCreateState {}

class PostCreateSuccess extends PostCreateState {}


class PostCreateError extends PostCreateState {
  final String errorMessage;
  PostCreateError(this.errorMessage);
}