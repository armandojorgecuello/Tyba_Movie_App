import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/core/dependencies/movie_provider.dart';
import 'package:movie_app/styles/styles.dart';
import 'package:movie_app/ui/screen/home_screen/logic/get_movies_provider.dart';
import 'package:movie_app/ui/screen/movie_details_screen/movie_details_screen.dart';
import 'package:movie_app/ui/utils/constants.dart';
import 'package:movie_app/ui/utils/responsive.dart';

class HomeScreen extends ConsumerStatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenConsumerState();
}

class _HomeScreenConsumerState extends ConsumerState<HomeScreen> {

  final controller = TextEditingController();

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      ref.read(getMoviesNotifierProvider.notifier).movies();
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final state = ref.watch(getMoviesNotifierProvider);
    final filterMovies = ref.watch(movieFilterProvider);
    final responsive = Responsive(context);
    return Scaffold(
      body: state.isLoading 
      ? Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            CircularProgressIndicator(),
            Text('Fetching data...')
          ],
        ),
      )  
      : state.data != null ? SafeArea(
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(kDimens15),
                child: TextField(
                  controller: controller,
                  decoration:  InputDecoration(
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(width: kDimens5)
                    ),
                    label: const Text('Search by name'),
                    suffixIcon: controller.text.isNotEmpty ?  GestureDetector(
                      onTap: () {
                        controller.clear();
                        ref.read(movieFilterProvider.notifier).state = state.data!.results!; 
                        FocusScope.of(context).unfocus();
                      },
                      child: const Icon(Icons.clear, color: kBlack)) : const SizedBox()
                  ),
                  onChanged: (value) {
                    ref.read(movieFilterProvider.notifier).state = state.data!.results!.where((movie) => movie.title!.toLowerCase().contains(value.toLowerCase())).toList();
                  },
                ),
              )
            ),
            Flexible(
              flex: 10,
              child:  ListView.builder(
                shrinkWrap: true,
                itemCount: filterMovies.isNotEmpty ? filterMovies.length : state.data!.results!.length,
                itemBuilder: (_, int index){
                  final movie = filterMovies.isNotEmpty ? filterMovies[index] : state.data!.results![index];
                  return  Padding(
                    padding: const EdgeInsets.all(kDimens10),
                    child: Hero(
                      tag: 'id${movie.id}',
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kDimens10)),
                        child: ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            GestureDetector(
                              onTap:() {
                                Navigator.push(
                                  context, 
                                  MaterialPageRoute(builder: (_) => MovieDetailsScreen(movieId: movie.id.toString(), posterImage: movie.posterPath!, titleMovie: movie.title!,) ,)
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(kDimens10),
                                child: Image.network(
                                  imagePath + movie.backdropPath!,
                                  height: responsive.hp(kDimens30),
                                  width: responsive.wp(kDimens90),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: kDimens10,),
                            _items('Title: ${movie.title!}'),
                            _items('Votes: ${movie.voteCount!}'),
                            const SizedBox(height: kDimens10,),
                          ],
                        )
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ) : const Align(
        child: Text(
          'Not data to show',
          style: Styles.h1,
        ),
      ),
    );
  }

  Padding _items(String info) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        info,
        style: Styles.h1,
      ),
    );
  }
}