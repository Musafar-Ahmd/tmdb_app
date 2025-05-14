import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_app/modules/reviews/view/reviews_list.dart';
import 'package:tmdb_app/modules/reviews/view_model/review_view_model.dart';
import 'package:tmdb_app/resources/app_colors.dart';
import 'package:tmdb_app/resources/app_strings.dart';
import 'package:tmdb_app/widgets/custom_app_bar.dart';
import '../../../resources/app_fonts.dart';
import '../../../utils/app_urls.dart';
import '../view_model/home_view_model.dart';

class MovieDetailScreen extends StatefulWidget {
  final int id;

  const MovieDetailScreen({super.key, required this.id});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late HomeViewModel _homeViewModel;
  late ReviewViewModel _reviewViewModel;

  @override
  void initState() {
    super.initState();
    _reviewViewModel = Provider.of<ReviewViewModel>(context, listen: false);
    _homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    _homeViewModel.movieDetail(widget.id);
    _reviewViewModel.getMovies(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    _homeViewModel = Provider.of<HomeViewModel>(context);
    _reviewViewModel = Provider.of<ReviewViewModel>(context);
    final product = _homeViewModel.detail;

    return Scaffold(
      appBar: commonAppBar(
        toolbarHeight: 70,
        context: context,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product?.title ?? '', style: AppFonts.roboto(fontSize: 18)),
            Text(
              "${AppStrings.releaseOn} ${product?.releaseDate ?? ''}",
              style: AppFonts.roboto(fontSize: 14),
            ),
          ],
        ),
      ),
      backgroundColor: AppColors.backgroundColor,
      body:
          _homeViewModel.isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    CachedNetworkImage(
                      imageUrl:
                          "${AppUrls.imagePrefixUrl}${product?.posterPath ?? ""}",
                      height: MediaQuery.of(context).size.width * 0.6,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder:
                          (context, url) => Container(
                            height: MediaQuery.of(context).size.width * 0.6,
                            color: Colors.grey[300],
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                      errorWidget:
                          (context, url, error) => Container(
                            height: MediaQuery.of(context).size.width * 0.6,
                            color: Colors.grey,
                            child: const Icon(Icons.broken_image),
                          ),
                    ),
                    const SizedBox(height: 24),
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            width: 120,
                            alignment: Alignment.center,
                            child: CachedNetworkImage(
                              imageUrl:
                                  "${AppUrls.imagePrefixUrl}${product?.backdropPath ?? ""}",
                              height: 180,
                              width: 120,
                              fit: BoxFit.cover,
                              placeholder:
                                  (context, url) => Container(
                                    height: 180,
                                    width: 120,
                                    color: Colors.grey[300],
                                    child: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                              errorWidget:
                                  (context, url, error) => Container(
                                    height: 180,
                                    width: 120,
                                    color: Colors.grey,
                                    child: const Icon(Icons.broken_image),
                                  ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product?.title ?? '',
                                  style: AppFonts.roboto(fontSize: 14),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  product?.overview ?? '',
                                  style: AppFonts.roboto(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Divider(thickness: 1),
                    const SizedBox(height: 8),
                    if (_reviewViewModel.reviews?.results?.isNotEmpty ?? false)
                      Text(
                        AppStrings.reviews,
                        style: AppFonts.roboto(fontSize: 16),
                      ),
                    const SizedBox(height: 12),
                    if (_reviewViewModel.reviews?.results?.isNotEmpty ?? false)
                      ReviewsList(
                        productId: widget.id,
                        movieName: product?.title ?? '',
                      ),
                  ],
                ),
              ),
    );
  }
}
