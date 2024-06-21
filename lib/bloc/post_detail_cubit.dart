import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poc_blocs/bloc/post_detail_states.dart';
import 'package:poc_blocs/data/http_api_helper.dart';

class PostDetailCubit extends Cubit<PostDetailState> {
  PostDetailCubit() : super(PostDetailInitial());
  
  final HttpApiHelper helper = HttpApiHelper();
  
  Future<void> getDetails(int id) async {
    emit(PostDetailLoading());
    try {
      var post = await helper.getPost(id);
      emit(PostDetailLoaded(post));
    } catch (e) {
      emit(PostDetailError("Erreur de chargement $e"));
    }
  }
}