import 'package:flutter/material.dart';
import 'package:restoran/data/local/model/restoran_table.dart';
import 'package:restoran/domain/entity/restoran_entity.dart';
import 'package:restoran/domain/router/restoran_router.dart';
import 'package:restoran/external/custom_colors.dart';
import 'package:restoran/external/custom_screen_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RestoranCard extends StatelessWidget {
  final RestoranEntity restoranEntity;
  final RestoranTableData restoranTableData;
  final RestoranRouter _restoranListRouter = RestoranRouterImpl();

  RestoranCard(
      {@required this.restoranEntity, @required this.restoranTableData});

  @override
  Widget build(BuildContext context) {
    CustomScreenUtils.initScreenUtils(context);
    return Container(
      margin: EdgeInsets.fromLTRB(8.w, 8.w, 8.w, 0.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 0.5),
            blurRadius: 1.0,
          ),
        ],
      ),
      child: InkWell(
        onTap: () => restoranEntity != null
            ? _restoranListRouter.goToDetailListRestoran(restoranEntity)
            : _restoranListRouter.goToDetailFavoriteRestoran(
                context,
                restoranTableData.id,
                restoranTableData.name,
                restoranTableData.pictureId),
        child: Row(
          children: [
            Hero(
              tag: restoranEntity != null
                  ? restoranEntity.name
                  : restoranTableData.name,
              child: Material(
                color: Colors.transparent,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.network(
                    restoranEntity != null
                        ? restoranEntity.pictureId
                        : restoranTableData.pictureId,
                    height: 90.w,
                    width: 125.w,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.w, 0.w, 16.w, 0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      restoranEntity != null
                          ? restoranEntity.name
                          : restoranTableData.name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: CustomColors.darkGrey,
                          fontSize: 16.sp),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.pin_drop,
                            color: CustomColors.grey,
                            size: 16.w,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8.w),
                            child: Text(
                                restoranEntity != null
                                    ? restoranEntity.city
                                    : restoranTableData.city,
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: CustomColors.darkGrey,
                                    fontSize: 14.sp)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.green,
                            size: 16.w,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8.w),
                            child: Text(
                                restoranEntity != null
                                    ? restoranEntity.rating
                                    : restoranTableData.rating,
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: CustomColors.darkGrey,
                                    fontSize: 14.sp)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
