part of 'detail_restoran_screen.dart';

class DescriptionScreen extends StatelessWidget {
  final DetailRestoranEntity restoranEntity;

  DescriptionScreen({@required this.restoranEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                color: Colors.green,
                size: 20.w,
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: Text(restoranEntity.rating,
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
                child: Text("${restoranEntity.address}, ${restoranEntity.city}",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: CustomColors.darkGrey,
                        fontSize: 18.sp)),
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
          Container(
            height: 20.w,
            margin: EdgeInsets.only(top: 8.w),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: restoranEntity.categories.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(right: 8.w),
                    padding: EdgeInsets.fromLTRB(16.w, 0.w, 16.w, 0.w),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 0.5),
                          blurRadius: 1.0,
                        ),
                      ],
                    ),
                    child: Text(
                      restoranEntity.categories[index].name,
                      style: TextStyle(
                          fontSize: 16.sp,
                          color: CustomColors.white,
                          fontWeight: FontWeight.normal),
                    ),
                  );
                }),
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
              restoranEntity.description,
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
}
