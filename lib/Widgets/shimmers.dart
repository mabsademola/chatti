import 'package:chatti/utility.dart/theme.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Listshimmer extends StatelessWidget {
  const Listshimmer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kkDefaultPadding * 0.75),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Shimmer.fromColors(
              baseColor: Colors.grey.withOpacity(0.4),
              highlightColor: Colors.grey.withOpacity(0.1),
              enabled: true,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (_, __) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Stack(
                        children: [
                          CircleAvatar(
                            maxRadius: 25,
                            backgroundColor: Colors.white,
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              height: 18,
                              width: 18,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: kContentColorLightTheme, width: 3),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kDefaultPadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.60,
                                height: 15.0,
                                color: Colors.white,
                              ),
                              SizedBox(height: 8),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.40,
                                height: 15.0,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Opacity(
                            opacity: 0.64,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.09,
                              height: 15.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                itemCount: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

gridshimmer() {
  return Container(
    width: double.infinity,
    child: Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: Shimmer.fromColors(
              baseColor: Colors.grey.withOpacity(0.4),
              highlightColor: Colors.grey.withOpacity(0.1),
              enabled: true,
              child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 20,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 180,
                    // crossAxisSpacing: 2,
                    childAspectRatio: 0.8,
                    // mainAxisSpacing: 2
                  ),
                  itemBuilder: (BuildContext _context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Positioned(
                                bottom: 0,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                )),
                          ],
                        ),
                        decoration: BoxDecoration(
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              blurRadius: 2,
                              offset: Offset(1, 1),
                            ),
                          ],

                          // color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          color: kContentColorLightTheme,
                        ),
                      ),
                    );
                  })),
        ),
      ],
    ),
  );
}

class SingleListshimmer extends StatelessWidget {
  const SingleListshimmer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kkDefaultPadding * 0.75),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.withOpacity(0.4),
        highlightColor: Colors.grey.withOpacity(0.1),
        enabled: true,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: [
                  CircleAvatar(
                    maxRadius: 25,
                    backgroundColor: Colors.white,
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: 18,
                      width: 18,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: kContentColorLightTheme, width: 3),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.60,
                        height: 15.0,
                        color: Colors.white,
                      ),
                      SizedBox(height: 8),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.40,
                        height: 15.0,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  Opacity(
                    opacity: 0.64,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.09,
                      height: 15.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NotificationShimmer extends StatelessWidget {
  const NotificationShimmer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kkDefaultPadding * 0.75),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Shimmer.fromColors(
              baseColor: Colors.grey.withOpacity(0.4),
              highlightColor: Colors.grey.withOpacity(0.1),
              enabled: true,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (_, __) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Stack(
                        children: [
                          CircleAvatar(
                            maxRadius: 25,
                            backgroundColor: Colors.white,
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              height: 18,
                              width: 18,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: kContentColorLightTheme, width: 3),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.80,
                                  height: 40.0,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      height: 40.0,
                                      width: 100.0,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Container(
                                      height: 40.0,
                                      width: 100.0,
                                      color: Colors.white,
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                itemCount: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SingleNotificationShimmer extends StatelessWidget {
  const SingleNotificationShimmer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kkDefaultPadding * 0.75),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.withOpacity(0.4),
        highlightColor: Colors.grey.withOpacity(0.1),
        enabled: true,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: [
                  CircleAvatar(
                    maxRadius: 25,
                    backgroundColor: Colors.white,
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: 18,
                      width: 18,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: kContentColorLightTheme, width: 3),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.80,
                          height: 40.0,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              height: 40.0,
                              width: 100.0,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              height: 40.0,
                              width: 100.0,
                              color: Colors.white,
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
