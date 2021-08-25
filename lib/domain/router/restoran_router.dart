import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restoran/domain/entity/restoran_entity.dart';
import 'package:restoran/domain/router/route_path.dart';
import 'package:restoran/external/navigation.dart';
import 'package:restoran/presentation/bloc/detail_restoran_bloc/get_detail_restoran_bloc.dart';
import 'package:restoran/presentation/bloc/favorite_restoran_bloc/favorite_restoran_bloc.dart';
import 'package:restoran/presentation/screen/add_review_screen.dart';
import 'package:restoran/presentation/screen/favorite_restoran/detail_favorite_restoran_screen.dart';

abstract class RestoranRouter {
  goToHome();

  goToDetailListRestoran(RestoranEntity restoranEntity);

  goToSearchRestoran();

  goToAddReview(context, String restoranId);

  goToDetailFavoriteRestoran(
      context, String restoranId, String restoranName, String restoranImage);
}

class RestoranRouterImpl extends RestoranRouter {
  @override
  goToHome() =>
      CustomNavigator.pushReplacementNamed(RoutePath.home, arguments: 0);

  @override
  goToDetailListRestoran(RestoranEntity restoranEntity) =>
      CustomNavigator.pushNamed(RoutePath.restoranDetail,
          arguments: restoranEntity);

  @override
  goToSearchRestoran() => CustomNavigator.pushNamed(
        RoutePath.searchRestoran,
        arguments: 0,
      );

  @override
  goToAddReview(context, String restoranId) => Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddReviewScreen(restoranId: restoranId))).then(
      (value) => BlocProvider.of<GetDetailRestoranBloc>(context)
          .add(GetDetailRestoran(restoranId: restoranId)));

  @override
  goToDetailFavoriteRestoran(context, String restoranId, String restoranName,
          String restoranImage) =>
      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 1000),
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              DetailFavoriteRestoranScreen(
            restoranId: restoranId,
            restoranImage: restoranImage,
            restoranName: restoranName,
          ),
        ),
      ).then((value) => BlocProvider.of<FavoriteRestoranBloc>(context)
          .add(GetListFavoriteRestoran()));
}
