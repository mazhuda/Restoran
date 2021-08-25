import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restoran/data/remote/datasource/api_constant.dart';
import 'package:restoran/data/remote/datasource/remote_data_source.dart';
import 'package:restoran/data/remote/repository/restoran_repo_impl.dart';
import 'package:restoran/domain/router/restoran_router.dart';
import 'package:restoran/domain/usecase/get_list_restoran_usecase.dart';
import 'package:restoran/external/custom_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restoran/external/custom_screen_utils.dart';
import 'package:restoran/external/image_strings.dart';
import 'package:restoran/presentation/bloc/restoran_list_bloc/get_list_restoran_bloc.dart';
import 'package:restoran/presentation/widget/card/restoran_card.dart';
import 'package:restoran/presentation/widget/info/custom_error_widget.dart';
import 'package:restoran/presentation/widget/loading/custom_loading_progress.dart';

class RestoranListScreen extends StatelessWidget {
  final RestoranRouter _restoranListRouter = RestoranRouterImpl();

  @override
  Widget build(BuildContext context) {
    CustomScreenUtils.initScreenUtils(context);
    return BlocProvider(
      create: (context) => GetListRestoranBloc(
        getListRestoranUseCase: GetListRestoranUseCaseImpl(
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
      )..add(GetListRestoran()),
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
                "Restoran",
                style: TextStyle(color: CustomColors.white, fontSize: 30.sp),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () => _restoranListRouter.goToSearchRestoran(),
              icon: Icon(
                Icons.search,
                color: CustomColors.white,
              ),
            ),
          ],
        ),
        body: BlocBuilder<GetListRestoranBloc, GetListRestoranState>(
          builder: (context, state) {
            if (state is GetListRestoranLoadedState) {
              if (state.listRestoran.isEmpty) {
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
                    errorMessage: "Data tidak ditemukan",
                  ),
                );
              } else {
                return SingleChildScrollView(
                  child: Container(
                      margin: EdgeInsets.only(top: 16.w),
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
                          itemCount: state.listRestoran.length,
                          itemBuilder: (context, index) {
                            return RestoranCard(
                              restoranEntity: state.listRestoran[index],
                              restoranTableData: null,
                            );
                          })),
                );
              }
            } else if (state is GetListRestoranFailedState) {
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
                  errorMessage: "Terjadi kesalahan, coba lagi nanti",
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
