library tv;

// data -> datasources
export 'data/datasources/db/database_tv_helper.dart';
export 'data/datasources/tv_local_data_source.dart';
export 'data/datasources/tv_remote_data_source.dart';

// data -> models
export 'data/models/tv_detail_model.dart';
export 'data/models/tv_model.dart';
export 'data/models/tv_response.dart';
export 'data/models/tv_table.dart';

// data -> repositories
export 'data/repositories/tv_repository_impl.dart';

// domain -> entities
export 'domain/entities/tv.dart';
export 'domain/entities/tv_detail.dart';

// domain -> repositories
export 'domain/repositories/tv_repository.dart';

// domain -> usecases
export 'domain/usecases/get_tv_detail.dart';
export 'domain/usecases/get_tv_recommendations.dart';
export 'domain/usecases/get_on_the_air_tvs.dart';
export 'domain/usecases/get_popular_tvs.dart';
export 'domain/usecases/get_top_rated_tvs.dart';
export 'domain/usecases/get_watchlist_tv.dart';
export 'domain/usecases/get_watchlist_status_tv.dart';
export 'domain/usecases/remove_watchlist_tv.dart';
export 'domain/usecases/save_watchlist_tv.dart';
export 'domain/usecases/search_tvs.dart';

// presentation -> pages
export 'presentation/pages/home_tv_page.dart';
export 'presentation/pages/tv_detail_page.dart';
export 'presentation/pages/popular_tvs_page.dart';
export 'presentation/pages/search_tv_page.dart';
export 'presentation/pages/top_rated_tvs_page.dart';
export 'presentation/pages/watchlist_tvs_page.dart';

// presentation -> provider
export 'presentation/provider/tv_detail_notifier.dart';
export 'presentation/provider/tv_list_notifier.dart';
export 'presentation/provider/tv_search_notifier.dart';
export 'presentation/provider/popular_tvs_notifier.dart';
export 'presentation/provider/top_rated_tvs_notifier.dart';
export 'presentation/provider/watchlist_tvs_notifier.dart';

// presentation -> bloc
export 'presentation/bloc/search_tvs_bloc/search_tvs_bloc.dart';

// presentation -> widgets
export 'presentation/widgets/tv_card_list.dart';
