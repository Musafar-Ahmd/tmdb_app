import 'package:flutter/material.dart';
import 'package:tmdb_app/resources/app_colors.dart';
import 'package:tmdb_app/resources/app_fonts.dart';
import 'package:tmdb_app/widgets/custom_app_bar.dart';
import '../../../resources/app_strings.dart';

class DetailReviewScreen extends StatelessWidget {
  final String author;
  final String content;
  final dynamic rating;
  final String? movieName;

  const DetailReviewScreen({
    super.key,
    required this.author,
    required this.content,
    this.rating,
    this.movieName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: commonAppBar(
        title: Text(
          "${AppStrings.userReview} : $movieName",
          style: AppFonts.roboto(fontSize: 18),
        ), context: context,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.star, color: Colors.yellow),
                  Text("${rating ?? 0.0}", style: AppFonts.roboto(fontSize: 16)),
                  SizedBox(width: 10,),
                  Text(author, style: AppFonts.roboto(fontSize: 16)),
                ],
              ),
              SizedBox(height: 10,),
              Text(content, style: AppFonts.roboto(fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }
}
