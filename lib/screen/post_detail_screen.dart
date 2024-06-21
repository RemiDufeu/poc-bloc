import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:poc_blocs/bloc/post_detail_cubit.dart';
import 'package:poc_blocs/bloc/post_detail_states.dart';
import 'package:poc_blocs/widget/custom_chip.dart';
import 'package:poc_blocs/widget/post_tile.dart';

class PostDetailScreen extends StatelessWidget {
  
  const PostDetailScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
  
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: PlatformText('Post Detail'),
      ),
      body: SafeArea(
        child: BlocBuilder<PostDetailCubit, PostDetailState>(
          builder: (context, state) {
            if(state is PostDetailLoading) {
              return Center(
                child: PlatformCircularProgressIndicator(),
              );
            }

            if(state is PostDetailError) {
              return Center(
                child: PlatformText(state.errorMessage),
              );
            }

            if(state is PostDetailLoaded) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PlatformText(
                          state.postDetail.title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: state.postDetail.tags
                            .map((tag) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 4),
                                  child: CustomChip(
                                    color: Theme.of(context).primaryColor,
                                    label: tag,
                                  ),
                                ))
                            .toList(),
                        ),
                        const SizedBox(height: 12),
                        PlatformText(
                          state.postDetail.body,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            return PlatformText("Lancez la recherche");
          }
        )
      )
    );
  }
}