import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_app/modules/reviews/view_model/review_view_model.dart';
import 'package:tmdb_app/resources/app_colors.dart';
import '../../../resources/app_fonts.dart';
import '../../../resources/navigation_extension.dart';
import '../../../utils/app_urls.dart';
import 'detail_review_screen.dart';

class ReviewsList extends StatelessWidget {
  final int productId;
  final String movieName;

  const ReviewsList({super.key, required this.productId, required this.movieName});

  @override
  Widget build(BuildContext context) {
    final _viewModel = Provider.of<ReviewViewModel>(context);
    final reviews = _viewModel.reviews?.results ?? [];

    return SizedBox(
      height: 180,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          final review = reviews[index];
          return GestureDetector(
            onTap: () {
              navigate(
                screen: DetailReviewScreen(
                  movieName: movieName,
                  rating: review.authorDetails?.rating,
                  author: review.authorDetails?.username ?? 'Unknown',
                  content: review.content ?? '',
                ),
                context: context,
              );
            },
            child: Container(
              width: 280,
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.themeColor,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          "${AppUrls.imagePrefixUrl}${review.authorDetails?.avatarPath}",
                          height: 40,
                          width: 40,
                          fit: BoxFit.cover,
                          errorBuilder:
                              (context, error, stackTrace) =>
                                  Icon(Icons.person, color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              review.authorDetails?.username ?? 'Unknown',
                              style: AppFonts.roboto(),
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 18,
                                ),
                                Text(
                                  "${review.authorDetails?.rating ?? 'N/A'}",
                                  style: AppFonts.roboto(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    review.content ?? '',
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: AppFonts.roboto(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
