import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restoran/data/remote/datasource/api_constant.dart';
import 'package:restoran/data/remote/datasource/remote_data_source.dart';
import 'package:restoran/data/remote/repository/restoran_repo_impl.dart';
import 'package:restoran/domain/usecase/search_restoran_usecase.dart';
import 'package:restoran/external/custom_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restoran/external/custom_screen_utils.dart';
import 'package:restoran/external/image_strings.dart';
import 'package:restoran/presentation/bloc/search_restoran_bloc/search_restoran_bloc.dart';
import 'package:restoran/presentation/widget/card/restoran_card.dart';
import 'package:restoran/presentation/widget/info/custom_error_widget.dart';
import 'package:restoran/presentation/widget/loading/custom_loading_progress.dart';

class SearchRestoranScreen extends StatefulWidget {
  @override
  _SearchRestoranScreenState createState() => _SearchRestoranScreenState();
}

class _SearchRestoranScreenState extends State<SearchRestoranScreen> {
  @override
  Widget build(BuildContext context) {
    CustomScreenUtils.initScreenUtils(context);
    return BlocProvider(
        create: (context) => SearchRestoranBloc(
              searchRestoranUseCase: SearchRestoranUseCaseImpl(
                restoranRepository: RestoranRepositoryImpl(
                  remoteDataSource: RemoteDataSourceImpl(
                    dio: Dio(
                      BaseOptions(
                          baseUrl: ApiConstant.baseUrl,
                          receiveDataWhenStatusError: true,
                          connectTimeout: 15 * 1000,
                          receiveTimeout: 15 * 1000),
                    ),
                  ),
                ),
              ),
            )..add(
                SearchRestoran(searchText: ""),
              ),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            elevation: 0.0,
            iconTheme: IconThemeData(color: CustomColors.white),
            title: BlocBuilder<SearchRestoranBloc, SearchRestoranState>(
                builder: (context, state) {
              return Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.search,
                        color: CustomColors.darkGrey,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 20.w,
                        child: TextFormField(
                          autofocus: true,
                          maxLines: 1,
                          style: TextStyle(color: CustomColors.darkGrey),
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(8.w, 15.w, 8.w, 5.w),
                              border: InputBorder.none,
                              hintText: "Cari restoran",
                              hintStyle: TextStyle(color: CustomColors.grey)),
                          onChanged: (value) {
                            BlocProvider.of<SearchRestoranBloc>(context).add(
                                SearchRestoran(searchText: value.toString()));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: CustomColors.white,
                ),
              );
            }),
          ),
          body: BlocBuilder<SearchRestoranBloc, SearchRestoranState>(
            builder: (context, state) {
              if (state is SearchRestoranLoadedState) {
                if (state.listRestoran.isEmpty) {
                  return Center(
                    child: CustomErrorWidget(
                      errorImage: ImageStrings.kosong,
                      errorMessage: "Data tidak ditemukan",
                    ),
                  );
                } else {
                  return Container(
                    padding: EdgeInsets.fromLTRB(16.w, 0.w, 16.w, 0.w),
                    decoration: BoxDecoration(
                      color: CustomColors.light,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      ),
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.listRestoran.length,
                      itemBuilder: (context, index) {
                        return RestoranCard(
                          restoranEntity: state.listRestoran[index],
                          restoranTableData: null,
                        );
                      },
                    ),
                  );
                }
              } else if (state is SearchRestoranFailedState) {
                return CustomErrorWidget(
                  errorImage: ImageStrings.salah,
                  errorMessage: "Terjadi kesalahan, coba lagi nanti",
                );
              } else {
                return CustomLoadingProgress();
              }
            },
          ),
        ));
  }
}
