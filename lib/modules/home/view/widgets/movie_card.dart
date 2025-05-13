import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_app/resources/app_fonts.dart';
import '../../../../resources/app_colors.dart';
import '../../../utils/app_urls.dart';

class MovieCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String releaseDate;

  const MovieCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.releaseDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.themeColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            child: CachedNetworkImage(
              imageUrl: "${AppUrls.imagePrefixUrl}${imageUrl ?? ""}",
              height: MediaQuery.of(context).size.width * 0.5,
              width: double.infinity,
              fit: BoxFit.fill,
              placeholder:
                  (context, url) => Container(
                    height: MediaQuery.of(context).size.width * 0.5,
                    color: Colors.grey[300],
                    child: const Center(child: CircularProgressIndicator()),
                  ),
              errorWidget:
                  (context, url, error) => Container(
                    height: MediaQuery.of(context).size.width * 0.5,
                    color: Colors.grey,
                    child: const Icon(Icons.broken_image),
                  ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              title,
              style: AppFonts.roboto(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              releaseDate,
              style: AppFonts.roboto(color: Colors.white70, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
