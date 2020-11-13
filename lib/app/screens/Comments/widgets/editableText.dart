import 'package:comptabli_blog/app/modules/comment/bloc/comment_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditableTextField extends StatefulWidget {
  String comment;
  String postId;
  String commentId;
  EditableTextField({this.comment, this.postId, this.commentId});
  @override
  _EditableTextFieldState createState() => _EditableTextFieldState();
}

class _EditableTextFieldState extends State<EditableTextField> {
  bool _isEditingText = false;
  CommentBloc bloc;

  TextEditingController _editingController;
  @override
  Widget build(BuildContext context) {
    if (_isEditingText)
      return Center(
        child: TextField(
          onTap: () {
            _isEditingText = false;
          },
          onSubmitted: (newValue) {
            setState(() {
              widget.comment = newValue;
              _isEditingText = false;
            });
            bloc = BlocProvider.of<CommentBloc>(context);
            bloc.add(CommentUpdateEvent(
                comment: newValue,
                id: widget.postId,
                commentId: widget.commentId));
          },
          autofocus: true,
          controller: _editingController,
        ),
      );
    return InkWell(
        onTap: () {
          setState(() {
            _isEditingText = !_isEditingText;
          });
        },
        child: Text(
          widget.comment,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
          ),
        ));
  }
}
