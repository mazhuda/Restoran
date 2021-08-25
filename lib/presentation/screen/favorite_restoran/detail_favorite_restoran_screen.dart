import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restoran/data/local/datasource/local_data_source.dart';
import 'package:restoran/data/local/model/restoran_table.dart';
import 'package:restoran/data/local/repository/local_restoran_repo_impl.dart';
import 'package:restoran/domain/usecase/favorite_restoran_usecase.dart';
import 'package:restoran/external/custom_colors.dart';
import 'package:restoran/external/custom_screen_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restoran/external/image_strings.dart';
import 'package:restoran/presentation/bloc/favorite_restoran_bloc/favorite_restoran_bloc.dart';
import 'package:restoran/presentation/widget/info/custom_error_widget.dart';
import 'package:restoran/presentation/widget/loading/custom_loading_progress.dart';

class DetailFavoriteRestoranScreen extends StatefulWidget {
  final String restoranId;
  final String restoranName;
  final String restoranImage;

  DetailFavoriteRestoranScreen({
    @required this.restoranId,
    @required this.restoranName,
    @required this.restoranImage,
  });

  @override
  _DetailFavoriteRestoranScreenState createState() =>
      _DetailFavoriteRestoranScreenState();
}

class _DetailFavoriteRestoranScreenState
    extends State<DetailFavoriteRestoranScreen> {
  RestoranTableData _restoranTableData;

  @override
  Widget build(BuildContext context) {
    CustomScreenUtils.initScreenUtils(context);
    return BlocProvider(
      create: (context) => FavoriteRestoranBloc(
        favoriteRestoranUseCase: FavoriteRestoranUseCaseImpl(
          localRestoranRepository: LocalRestoranRepositoryImpl(
            localDataSource: LocalDataSourceImpl(
              appDatabase: AppDatabase(),
            ),
          ),
        ),
      )..add(GetListFavoriteRestoranById(id: widget.restoranId)),
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
                    tag: widget.restoranName,
                    child: Material(
                      color: Colors.transparent,
                      child: Image.network(
                        widget.restoranImage,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
                centerTitle: false,
                title: Text(
                  widget.restoranName,
                  style: TextStyle(
                      color: CustomColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp),
                ),
                actions: [
                  BlocBuilder<FavoriteRestoranBloc, FavoriteRestoranState>(
                    builder: (context, state) {
                      if (state is FavoriteRestoranSuccessGetListByIdState) {
                        _restoranTableData = state.restoranTableData;
                        return IconButton(
                          icon: Icon(Icons.favorite),
                          onPressed: () =>
                              BlocProvider.of<FavoriteRestoranBloc>(context)
                                  .add(
                            DeleteFavoriteRestoran(
                                restoranTableData: _restoranTableData),
                          ),
                        );
                      } else if (state is FavoriteRestoranSuccessInsertState) {
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
              ),
            ];
          },
          body: BlocBuilder<FavoriteRestoranBloc, FavoriteRestoranState>(
              builder: (context, state) {
            if (state is FavoriteRestoranSuccessGetListByIdState) {
              return _buildDetailBody(state.restoranTableData);
            } else if (state is FavoriteRestoranFailedState) {
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
              // ignore: unnecessary_null_comparison
            } else if (_restoranTableData != null) {
              return _buildDetailBody(_restoranTableData);
            } else {
              return CustomLoadingProgress();
            }
          }),
        ),
      ),
    );
  }

  Widget _buildDetailBody(RestoranTableData restoranTableData) => Container(
        color: CustomColors.light,
        padding: EdgeInsets.only(left: 16.w, right: 16.w),
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 20.w,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.w),
                  child: Text(restoranTableData.rating,
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: CustomColors.darkGrey,
                          fontSize: 18.sp)),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.pin_drop,
                  color: CustomColors.grey,
                  size: 20.w,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.w),
                  child: Text(
                      "${restoranTableData.address}, ${restoranTableData.city}",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: CustomColors.darkGrey,
                          fontSize: 16.sp)),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 16.w),
              child: Text(
                "Kategori",
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16.w),
              child: Text(
                "Deskripsi",
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.w),
              child: Text(
                restoranTableData.description,
                style: TextStyle(
                    color: CustomColors.darkGrey,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.normal),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      );
}
