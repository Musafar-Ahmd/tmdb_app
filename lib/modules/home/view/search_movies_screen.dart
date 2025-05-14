import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_app/modules/home/view/widgets/movie_card.dart';
import 'package:tmdb_app/modules/home/view_model/home_view_model.dart';
import 'package:tmdb_app/resources/navigation_extension.dart';
import 'package:tmdb_app/widgets/custom_app_bar.dart';
import 'package:tmdb_app/widgets/custom_decoration.dart';
import '../../../resources/app_colors.dart';
import '../../../widgets/not_found.dart';
import 'movie_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String search = "";

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);
    final results = viewModel.searchList?.results ?? [];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundColor,
      appBar: commonAppBar(
        context: context,
        title: SizedBox(
          height: 50,
          child: TextFormField(
            onChanged: (v) {
              viewModel.searchMovies(v);
              search = v;
            },
            decoration: customDecoration(),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 28),
          viewModel.isLoading
              ? CircularProgressIndicator(color: Colors.blue)
              : viewModel.searchList?.results?.isNotEmpty ?? false
              ? Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 14.0,
                    right: 14,
                    bottom: 16,
                  ),
                  child: SingleChildScrollView(
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.all(0),
                      shrinkWrap: true,
                      itemCount: results.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.65,
                          ),
                      itemBuilder: (context, index) {
                        final product = results[index];
                        return GestureDetector(
                          onTap: () {
                            navigate(
                              context: context,
                              screen: MovieDetailScreen(id: product?.id ?? 0),
                            );
                          },
                          child: MovieCard(
                            imageUrl: product.posterPath ?? '',
                            title: product.originalTitle ?? '',
                            releaseDate: product.releaseDate ?? '',
                          ),
                        );
                      },
                    ),
                  ),
                ),
              )
              : notFound(
                search.isNotEmpty ? "No movies found" : "Search for movies",
              ),
          if (viewModel.getAllMovies)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Center(
                child: CircularProgressIndicator(color: Colors.blue),
              ),
            ),
        ],
      ),
    );
  }
}
