import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class CustomSearchField extends StatelessWidget {}

class MovieSearchField extends CustomSearchField {
  MovieSearchField({required this.onSearchFieldTapped});

  final VoidCallback onSearchFieldTapped;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      height: 52.0,
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(40.0), color: Colors.grey[300]),
      child: TextFormField(
        maxLines: 1,
        onTap: onSearchFieldTapped,
        autofocus: false,
        readOnly: true,
        inputFormatters: [LengthLimitingTextInputFormatter(30)],
        decoration: InputDecoration(
          hintText: 'Search movies/tv series',
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          suffixIcon: IconButton(icon: Icon(Icons.search), onPressed: () {}),
          hintStyle: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
