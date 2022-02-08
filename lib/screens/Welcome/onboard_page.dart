import 'package:chatti/helper/images.dart';
import 'package:chatti/utility.dart/theme.dart';
import 'package:chatti/util/page_indicator.dart';
import 'package:chatti/Widgets/text_fields.dart';
import 'package:chatti/utility.dart/theme.dart';
import 'package:flutter/material.dart';

class GetStartedPage extends StatefulWidget {
  const GetStartedPage({Key key}) : super(key: key);

  static MaterialPageRoute getRoute() {
    return MaterialPageRoute(
      builder: (_) => const GetStartedPage(),
    );
  }

  @override
  _GetStartedPageState createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  final _formKey = GlobalKey<FormState>();

  ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  PageController controller;
  String buttonText;
  @override
  void initState() {
    controller = PageController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    switch (controller.page.toInt()) {
      case 0:
        controller.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInSine);
        break;
      case 1:
        controller.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInSine);
        break;

      case 2:
        print("Navigate to Sign");
        Navigator.of(context).pushNamed('/LoginScreen');
        break;

      default:
    }
  }

  Widget _form(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 16,
      margin: const EdgeInsets.symmetric(vertical: 16) +
          const EdgeInsets.only(top: 32),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 30),
            SizedBox(
              height: MediaQuery.of(context).size.height * .7,
              child: PageView.builder(
                controller: controller,
                physics: const BouncingScrollPhysics(),
                itemCount: 3,
                onPageChanged: (page) {
                  setState(() {
                    buttonText = page < 2 ? "Next" : "Get Started";
                  });
                },
                itemBuilder: (context, index) {
                  switch (index) {
                    case 0:
                      return const Slider1();
                    case 1:
                      return const Slider2();
                    case 2:
                      return const Slider3();
                      break;
                    default:
                      return const Slider1();
                  }
                },
              ),
            ),
            DotsIndicator(
              controller: controller,
              itemCount: 3,
              color: kPrimaryColor.withOpacity(1),
            ),
            // const SizedBox(height: 14),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: MyTextButton(
                  buttonName: buttonText ?? "Next",
                  onTap: () {
                    _submit(context);
                  },
                ))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SafeArea(
          top: false,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      _form(context),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Slider1 extends StatelessWidget {
  const Slider1({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/onboard/img_welcome_one.png',
            // height: height * .4
          ),
          // RichText(
          //   textAlign: TextAlign.center,
          //   text: TextSpan(
          //     style: TextStyles.headline36(context)
          //         .copyWith(fontWeight: FontWeight.w500),
          //     children: [
          //       TextSpan(text: "Welcome \nto"),
          //       TextSpan(
          //         text: "Chatti",
          //         style: kBodyText12.copyWith(
          //           fontWeight: FontWeight.w800,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // Text(
          //     "Social network where you get rewards for posts, comments and likes",
          //     style: kBodyText12.copyWith(
          //       fontWeight: FontWeight.w800,
          //     ),
          //     textAlign: TextAlign.center)
        ],
      ),
    );
  }
}

class Slider2 extends StatelessWidget {
  const Slider2({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Container(
            height: 300,
            width: 300,
            child: Image.asset(
              Images.onBoardPicTwo,
            ),
          ),
          Spacer(),
          Text("All-in-One Social Network ",
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center),
          Text(
              "Choose communities of interest and be rewarded for your actions",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center),
          Spacer()
        ],
      ),
    );
  }
}

class Slider3 extends StatelessWidget {
  const Slider3({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(Images.onBoardPicFour, height: height * .4),
          // RichText(
          //   textAlign: TextAlign.center,
          //   text: TextSpan(
          //     style: TextStyles.headline36(context).copyWith(
          //       fontWeight: FontWeight.w800,
          //     ),
          //     children: [
          //       TextSpan(text: "Owned"),
          //       TextSpan(
          //         text: "by users",
          //         style: TextStyles.headline36(context).copyWith(
          //           fontWeight: FontWeight.w500,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // Text(
          //   "Communities has no single owner and fully belongs to its members",
          //   style: TextStyles.headline18(context),
          //   textAlign: TextAlign.center,
          // )
        ],
      ),
    );
  }
}
