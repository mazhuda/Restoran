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
import 'package:restoran/presentation/widget/card/restoran_card.dart';
import 'package:restoran/presentation/widget/info/custom_error_widget.dart';
import 'package:restoran/presentation/widget/loading/custom_loading_progress.dart';

class FavoriteRestoranListScreen extends StatelessWidget {
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
      )..add(GetListFavoriteRestoran()),
      child: Scaffold(
        backgroundColor: Colors.green,
        appBar: AppBar(
          backgroundColor: Colors.green,
          elevation: 0.0,
          centerTitle: false,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Restoran Favorit",
                style: TextStyle(color: CustomColors.white, fontSize: 30.sp),
              ),
            ],
          ),
        ),
        body: BlocBuilder<FavoriteRestoranBloc, FavoriteRestoranState>(
          builder: (context, state) {
            if (state is FavoriteRestoranSuccessGetListState) {
              if (state.listRestoranTableData.isEmpty) {
                return Container(
                  margin: EdgeInsets.only(top: 16.w),
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: CustomColors.light,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                    ),
                  ),
                  child: CustomErrorWidget(
                    errorImage: ImageStrings.kosong,
                    errorMessage: "Anda tidak memiliki restoran favorit",
                  ),
                );
              } else {
                return Container(
                  margin: EdgeInsets.only(top: 16.w),
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: CustomColors.light,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: CustomColors.light,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.0),
                          topRight: Radius.circular(40.0),
                        ),
                      ),
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: state.listRestoranTableData.length,
                          itemBuilder: (context, index) {
                            return RestoranCard(
                              restoranTableData:
                                  state.listRestoranTableData[index],
                              restoranEntity: null,
                            );
                          }),
                    ),
                  ),
                );
              }
            } else if (state is FavoriteRestoranFailedState) {
              return Container(
                margin: EdgeInsets.only(top: 16.w),
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: CustomColors.light,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                ),
                child: CustomErrorWidget(
                  errorImage: ImageStrings.salah,
                  errorMessage: "Anda tidak memiliki restoran favorit",
                ),
              );
            } else {
              return Container(
                margin: EdgeInsets.only(top: 16.w),
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: CustomColors.light,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                ),
                child: CustomLoadingProgress(),
              );
            }
          },
        ),
      ),
    );
  }
}
