import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_app/modules/home/view/movie_detail_screen.dart';
import 'package:tmdb_app/modules/home/view/search_movies_screen.dart';
import 'package:tmdb_app/modules/home/view/widgets/movie_card.dart';
import 'package:tmdb_app/modules/home/view_model/home_view_model.dart';
import 'package:tmdb_app/resources/app_colors.dart';
import 'package:tmdb_app/resources/app_strings.dart';
import 'package:tmdb_app/widgets/custom_decoration.dart';
import '../../../resources/navigation_extension.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeViewModel _viewModel;
  final _scrollController = ScrollController();

  @override
  void initState() {
    _viewModel = Provider.of<HomeViewModel>(context, listen: false);
    super.initState();
    Future.microtask(() {
      _viewModel.page = 1;
      _viewModel.getMovies();
      _scrollController.addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          _viewModel.loadAllMovies();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);
    final results = viewModel.movies?.results ?? [];

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: ListView(
        controller: _scrollController,
        padding: const EdgeInsets.only(top: 50),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              onTap: () {
                navigate(screen: SearchScreen(), context: context);
              },
              readOnly: true,
              decoration: customDecoration(),
            ),
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              AppStrings.popularMovies,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.yellow,
              ),
            ),
          ),

          results.isEmpty
              ? const Center(
                child: CircularProgressIndicator(color: Colors.blue),
              )
              : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: results.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.65,
                  ),
                  itemBuilder: (context, index) {
                    final movies = results[index];
                    return GestureDetector(
                      onTap: () {
                        navigate(
                          screen: MovieDetailScreen(id: movies?.id ?? 0),
                          context: context,
                        );
                      },
                      child: MovieCard(
                        imageUrl: movies.posterPath ?? '',
                        title: movies.originalTitle ?? '',
                        releaseDate: movies.releaseDate ?? '',
                      ),
                    );
                  },
                ),
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
