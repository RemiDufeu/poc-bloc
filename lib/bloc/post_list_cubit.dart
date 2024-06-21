import 'package:bloc/bloc.dart';
import 'package:poc_blocs/bloc/post_list_states.dart';
import 'package:poc_blocs/data/http_api_helper.dart';
import 'package:poc_blocs/model/post.dart';


class PostListCubit extends Cubit<PostListState> {
  
  PostListCubit() : super(PostListInitial());

  final HttpApiHelper helper = HttpApiHelper();
  
  Future<void> refreshAll(String query) async {
    emit(PostListLoading());
    try {
      var postList = await helper.getPostsLists(query);
      emit(PostListLoaded(postList));
    } catch (e) {
      emit(PostListError('Failed to fetch posts: ${e.toString()}'));
    }
  }
}