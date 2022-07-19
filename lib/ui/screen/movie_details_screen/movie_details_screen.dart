import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/styles/styles.dart';
import 'package:movie_app/ui/screen/movie_details_screen/logic/get_movie_details_provider.dart';
import 'package:movie_app/ui/utils/constants.dart';
import 'package:movie_app/ui/utils/responsive.dart';

class MovieDetailsScreen extends ConsumerStatefulWidget {
  final String movieId;
  final String posterImage;
  final String titleMovie;
  MovieDetailsScreen({ required this.posterImage, required this.titleMovie, required this.movieId, Key? key}) : super(key: key);

  @override
  ConsumerState<MovieDetailsScreen> createState() => _HomeScreenConsumerState();
}

class _HomeScreenConsumerState extends ConsumerState<MovieDetailsScreen> {

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      ref.read(getMovieNotifierProvider.notifier).movieDetail(widget.movieId);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(getMovieNotifierProvider);
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
      : state.data != null ? Column(
        children: [
          Flexible(
            flex: 2,
            child: Stack(
              children: [
                ClipRRect(
                  child: Image.network(
                    imagePath + widget.posterImage,
                    width: responsive.wp(100),
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: kDimens30,
                  left: kDimens10,
                  child: IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    }, 
                    icon: const Icon(Icons.arrow_back_ios, color: kWhite),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: ListView(
              shrinkWrap: true,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(kDimens10),
                      child: Hero(
                        tag: 'id${widget.movieId}',
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            imagePath +  state.data!.posterPath!,
                            height: responsive.hp(20),
                            width: responsive.wp(25),
                            fit: BoxFit.cover
                          ),
                        ),
                      ),
                    ),
                    _items('Title: ${widget.titleMovie}'),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(kDimens10),
                  child: Expanded(
                    flex: 4,
                    child: Text(
                      state.data!.overview!,
                      style: Styles.h2,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ) : const Align(
        child: Text(
          'Not data to show',
          style: Styles.h1,
        ),
      ),
    );
  }

  _items(String info) {
    return Flexible(
      flex: 1,
      child: Text(
        info,
        maxLines: 4,
        style: Styles.appbar,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}