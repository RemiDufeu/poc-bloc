import 'package:poc_blocs/model/post.dart';

abstract class PostDetailState {}

class PostDetailInitial extends PostDetailState {}

class PostDetailLoading extends PostDetailState {}

class PostDetailLoaded extends PostDetailState {
  final Post postDetail;

  PostDetailLoaded(this.postDetail);
}

class PostDetailError extends PostDetailState {
  final String errorMessage;

  PostDetailError(this.errorMessage);
}