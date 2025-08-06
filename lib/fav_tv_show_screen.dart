import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vnt_app3_series_api/tv_show_grid.dart';
import 'package:vnt_app3_series_api/tv_show_model.dart';

class FavTvShowScreen extends StatefulWidget {
  const FavTvShowScreen({super.key});

  @override
  State<FavTvShowScreen> createState() => _FavTvShowScreenState();
}

class _FavTvShowScreenState extends State<FavTvShowScreen> {
  @override
  Widget build(BuildContext context) {
    var tvShows = context.watch<TvShowModel>().tvShows;
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            tvShows.isEmpty ? 'Nenhuma série favorita!' : 'Favoritas',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Expanded(child: TvShowGrid(tvShows: tvShows)),
        ],
      ),
    );
  }
}
