import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restoran/data/local/datasource/local_data_source.dart';
import 'package:restoran/data/local/model/restoran_table.dart';
import 'package:restoran/data/local/repository/local_restoran_repo_impl.dart';
import 'package:restoran/data/remote/datasource/api_constant.dart';
import 'package:restoran/data/remote/datasource/remote_data_source.dart';
import 'package:restoran/data/remote/repository/restoran_repo_impl.dart';
import 'package:restoran/domain/entity/detail_restoran_entity.dart';
import 'package:restoran/domain/entity/restoran_entity.dart';
import 'package:restoran/domain/router/restoran_router.dart';
import 'package:restoran/domain/usecase/favorite_restoran_usecase.dart';
import 'package:restoran/domain/usecase/get_restoran_detail_usecase.dart';
import 'package:restoran/external/custom_colors.dart';
import 'package:restoran/external/custom_screen_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restoran/external/image_strings.dart';
import 'package:restoran/presentation/bloc/detail_restoran_bloc/get_detail_restoran_bloc.dart';
import 'package:restoran/presentation/bloc/favorite_restoran_bloc/favorite_restoran_bloc.dart';
import 'package:restoran/presentation/widget/button/custom_button.dart';
import 'package:restoran/presentation/widget/info/custom_error_widget.dart';
import 'package:restoran/presentation/widget/loading/custom_loading_progress.dart';

part 'description_screen.dart';

part 'drinks_screen.dart';

part 'foods_screen.dart';

part 'reviews_screen.dart';

class DetailRestoranScreen extends StatefulWidget {
  final RestoranEntity restoranEntity;

  DetailRestoranScreen({@required this.restoranEntity});

  @override
  _DetailRestoranScreenState createState() => _DetailRestoranScreenState();
}

class _DetailRestoranScreenState extends State<DetailRestoranScreen> {
  RestoranTableData _restoranTableData;

  @override
  Widget build(BuildContext context) {
    CustomScreenUtils.initScreenUtils(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetDetailRestoranBloc(
            getRestoranDetailUseCase: GetRestoranDetailUseCaseImpl(
              restoranRepository: RestoranRepositoryImpl(
                remoteDataSource: RemoteDataSourceImpl(
                  dio: Dio(
                    BaseOptions(
                      baseUrl: ApiConstant.baseUrl,
                    ),
                  ),
                ),
              ),
            ),
          )..add(
              GetDetailRestoran(restoranId: widget.restoranEntity.id),
            ),
        ),
        BlocProvider(
          create: (context) => FavoriteRestoranBloc(
            favoriteRestoranUseCase: FavoriteRestoranUseCaseImpl(
              localRestoranRepository: LocalRestoranRepositoryImpl(
                localDataSource: LocalDataSourceImpl(
                  appDatabase: AppDatabase(),
                ),
              ),
            ),
          )..add(GetListFavoriteRestoranById(id: widget.restoranEntity.id)),
        ),
      ],
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (context, isScrolled) {
              return [
                SliverAppBar(
                  backgroundColor: Colors.green,
                  pinned: true,
                  expandedHeight: 200.w,
                  iconTheme: IconThemeData(color: CustomColors.white),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Hero(
                      tag: widget.restoranEntity.name,
                      child: Material(
                        color: Colors.transparent,
                        child: Image.network(
                          widget.restoranEntity.pictureId,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ),
                  centerTitle: false,
                  title: Text(
                    widget.restoranEntity.name,
                    style: TextStyle(
                        color: CustomColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp),
                  ),
                  actions: [
                    BlocBuilder<FavoriteRestoranBloc, FavoriteRestoranState>(
                      builder: (context, state) {
                        if (state is FavoriteRestoranSuccessGetListByIdState) {
                          return IconButton(
                            icon: Icon(Icons.favorite),
                            onPressed: () =>
                                BlocProvider.of<FavoriteRestoranBloc>(context)
                                    .add(
                              DeleteFavoriteRestoran(
                                  restoranTableData: _restoranTableData),
                            ),
                          );
                        } else if (state
                            is FavoriteRestoranSuccessInsertState) {
                          return IconButton(
                            icon: Icon(Icons.favorite),
                            onPressed: () =>
                                BlocProvider.of<FavoriteRestoranBloc>(context)
                                    .add(
                              DeleteFavoriteRestoran(
                                  restoranTableData: _restoranTableData),
                            ),
                          );
                        } else {
                          return IconButton(
                            icon: Icon(Icons.favorite_border),
                            onPressed: () =>
                                BlocProvider.of<FavoriteRestoranBloc>(context)
                                    .add(
                              InsertFavoriteRestoran(
                                  restoranTableData: _restoranTableData),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                  bottom: TabBar(
                    isScrollable: true,
                    labelColor: CustomColors.white,
                    indicatorColor: CustomColors.light,
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    tabs: [
                      Tab(
                        text: "Deskripsi",
                      ),
                      Tab(
                        text: "Makanan",
                      ),
                      Tab(
                        text: "Minuman",
                      ),
                      Tab(
                        text: "Saran",
                      ),
                    ],
                  ),
                ),
              ];
            },
            body: BlocBuilder<GetDetailRestoranBloc, GetDetailRestoranState>(
                builder: (context, state) {
              if (state is GetDetailRestoranLoadedState) {
                _restoranTableData = RestoranTableData(
                  id: state.detailRestoran.id,
                  name: state.detailRestoran.name,
                  description: state.detailRestoran.description,
                  pictureId: state.detailRestoran.pictureId,
                  city: state.detailRestoran.city,
                  address: state.detailRestoran.address,
                  rating: state.detailRestoran.rating,
                );
                return TabBarView(
                  children: [
                    DescriptionScreen(
                      restoranEntity: state.detailRestoran,
                    ),
                    FoodsScreen(
                      foods: state.detailRestoran.menus.foods,
                    ),
                    DrinksScreen(
                      drinks: state.detailRestoran.menus.drinks,
                    ),
                    ReviewsScreen(
                      consumerReviews: state.detailRestoran.consumerReviews,
                      restoranId: state.detailRestoran.id,
                    )
                  ],
                );
              } else if (state is GetDetailRestoranFailedState) {
                return Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.green,
                    iconTheme: IconThemeData(color: CustomColors.white),
                  ),
                  body: CustomErrorWidget(
                    errorImage: ImageStrings.salah,
                    errorMessage: "Terjadi kesalahan, coba lagi nanti",
                  ),
                );
              } else {
                return CustomLoadingProgress();
              }
            }),
          ),
        ),
      ),
    );
  }
}
