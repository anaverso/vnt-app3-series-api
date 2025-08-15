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
  void initState() {
    // TODO: implement initState
    super.initState();
    // garantir que o contexto está disponível, modelo vai ser incializado após a construção do widget
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TvShowModel>().initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TvShowModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isLoading) {
          return Center(
            child: SizedBox(
              height: 96,
              width: 96,
              child: CircularProgressIndicator(strokeWidth: 12),
            ),
          );
        } else if (viewModel.errorMessage != null) {
          return Center(
            child: Container(
              padding: EdgeInsets.all(32),
              child: Column(
                spacing: 32,
                children: [
                  Text(
                    'Erro: ${viewModel.errorMessage}',
                    style: TextStyle(fontSize: 24),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      viewModel.load();
                    },
                    child: Text('TENTAR NOVAMENTE'),
                  ),
                ],
              ),
            ),
          );
        }
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              if (viewModel.hasFavorites) ...[
                const SizedBox(height: 8),
                Text(
                  '${viewModel.favTvShows.length} séries favoritas',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
              const SizedBox(height: 16),
              Expanded(
                child: viewModel.hasFavorites
                    ? TvShowGrid(tvShows: viewModel.favTvShows)
                    : Center(
                        child: Column(
                          children: [
                            const SizedBox(height: 64),
                            Icon(
                              Icons.favorite,
                              size: 96,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(height: 32),
                            Text(
                              'Adicione suas séries favoritas',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
