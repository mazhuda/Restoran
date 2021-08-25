import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restoran/data/remote/datasource/api_constant.dart';
import 'package:restoran/data/remote/datasource/remote_data_source.dart';
import 'package:restoran/data/remote/repository/restoran_repo_impl.dart';
import 'package:restoran/domain/usecase/add_review_usecase.dart';
import 'package:restoran/external/custom_colors.dart';
import 'package:restoran/external/custom_screen_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restoran/presentation/bloc/add_review/add_review_bloc.dart';
import 'package:restoran/presentation/widget/button/custom_button.dart';
import 'package:restoran/presentation/widget/text_field/custom_text_field.dart';

class AddReviewScreen extends StatelessWidget {
  final String restoranId;
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();
  final FocusNode _reviewFocusNode = FocusNode();

  AddReviewScreen({@required this.restoranId});

  @override
  Widget build(BuildContext context) {
    CustomScreenUtils.initScreenUtils(context);
    return BlocProvider(
      create: (context) => AddReviewBloc(
          addReviewUseCase: AddReviewUseCaseImpl(
              restoranRepository: RestoranRepositoryImpl(
                  remoteDataSource: RemoteDataSourceImpl(
                      dio: Dio(BaseOptions(
                          baseUrl: ApiConstant.baseUrl,
                          receiveDataWhenStatusError: true,
                          connectTimeout: 15 * 1000,
                          receiveTimeout: 15 * 1000)))))),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          iconTheme: IconThemeData(color: CustomColors.white),
          title: Text(
            "Tambah Saran",
            style: TextStyle(
                color: CustomColors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.sp),
          ),
        ),
        body: BlocListener<AddReviewBloc, AddReviewState>(
          listener: (context, state) {
            if (state is AddReviewSuccessState) {
              Navigator.pop(context);
            } else if (state is AddReviewFailedState) {
              errorMessage(context, "Terjadi kesalahan, coba lagi nanti");
            } else if (state is AddReviewNameEmptyState) {
              errorMessage(context, "Nama tidak boleh kosong");
            } else if (state is AddReviewReviewEmptyState) {
              errorMessage(context, "Saran tidak boleh kosong");
            }
          },
          child: ListView(
            children: [
              CustomTextField(
                controller: _userNameController,
                hint: "Nama",
                onFieldSubmitted: (v) =>
                    FocusScope.of(context).requestFocus(_reviewFocusNode),
                keyboardType: TextInputType.name,
                focusNode: null,
              ),
              CustomTextField(
                controller: _reviewController,
                hint: "Saran",
                keyboardType: TextInputType.multiline,
                maxLines: null,
                focusNode: _reviewFocusNode,
                onFieldSubmitted: (String value) {},
              ),
              Padding(
                padding: EdgeInsets.all(16.w),
                child: BlocBuilder<AddReviewBloc, AddReviewState>(
                    builder: (context, state) {
                  if (state is AddReviewLoadingState) {
                    return Stack(
                      children: [
                        CustomButton(
                          borderRadius: 10.0,
                          text: "Tambah Saran",
                          onTap: () => {},
                        ),
                        Center(
                          child: CircularProgressIndicator(
                            valueColor: new AlwaysStoppedAnimation<Color>(
                                CustomColors.darkGrey),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return CustomButton(
                      borderRadius: 10.0,
                      text: "Tambah Saran",
                      onTap: () => BlocProvider.of<AddReviewBloc>(context).add(
                          AddReview(
                              restoranId: restoranId,
                              userName: _userNameController.text,
                              review: _reviewController.text)),
                    );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void errorMessage(context, String message) {
    final _snackBar = SnackBar(
      duration: const Duration(seconds: 1),
      backgroundColor: Colors.red,
      content: Text(
        message,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16.sp,
          color: Colors.white,
        ),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(_snackBar);
  }
}
