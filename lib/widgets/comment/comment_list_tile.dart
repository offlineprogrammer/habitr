import 'package:flutter/material.dart';
import 'package:habitr/models/Comment.dart';
import 'package:habitr/repos/comment_repository.dart';
import 'package:habitr/repos/habit_repository.dart';
import 'package:habitr/screens/habit_details/habit_details_screen.dart';
import 'package:provider/provider.dart';

class CommentListTile extends StatelessWidget {
  const CommentListTile(this.commentId, {Key? key}) : super(key: key);

  final String commentId;

  @override
  Widget build(BuildContext context) {
    return Selector<CommentRepository, Comment>(
      selector: (context, repo) => repo.get(commentId)!,
      builder: (context, comment, child) {
        var habit = Provider.of<HabitRepository>(context, listen: false)
            .get(comment.habitId);
        return ListTile(
          title: Text(habit!.tagline),
          subtitle: Text(
            // TODO
            DateTime.now().toString() + '\n\n' + comment.comment,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: const Icon(Icons.chevron_right),
          isThreeLine: true,
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => HabitDetailsScreen(comment.habitId),
            ));
          },
        );
      },
    );
  }
}
