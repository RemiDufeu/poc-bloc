import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:poc_blocs/model/post.dart';
import 'package:poc_blocs/widget/custom_chip.dart';

class PostTile extends StatelessWidget {
  final Post post;

  const PostTile({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 0),
                child: PlatformText(post.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: post.tags
                      .map((tag) => Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 2, vertical: 0),
                            child: CustomChip(
                              color: Theme.of(context).primaryColor,
                              label: tag,
                            ),
                          ))
                      .toList(),
                ),
              ),
              PlatformText(
                post.body,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 13),
                maxLines: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
