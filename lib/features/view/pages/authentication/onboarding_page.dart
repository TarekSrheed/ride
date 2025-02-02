import 'package:flutter/material.dart';
import 'package:ride_app/core/res/app_color.dart';
import 'package:ride_app/core/res/app_images.dart';
import 'package:ride_app/core/res/app_string.dart';
import 'package:ride_app/core/res/app_style.dart';
import 'package:ride_app/features/view/pages/authentication/welcome_view.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  _OnboardingViewState createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 1;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation =
        Tween<double>(begin: 1 / 3, end: 1 / 3).animate(_animationController)
          ..addListener(() {
            setState(() {});
          });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _goToWelcomePage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const WelcomView()),
    );
  }

  void _increaseProgress() {
    if (_currentPage < 2) {
      setState(() {
        _currentPage++;
        _animation = Tween<double>(
          begin: (_currentPage - 1) / 3,
          end: _currentPage / 3,
        ).animate(_animationController);
        _animationController.forward(from: 0.0);
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    } else {
      _goToWelcomePage(context); // انتقال فوري لصفحة Welcome
    }
  }

  AppString appString = AppString();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () => _goToWelcomePage(context),
            child: Text(
              appString.SKIP,
              style: appbarTitleStyle,
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                  _animation = Tween<double>(
                    begin: index / 3,
                    end: (index + 1) / 3,
                  ).animate(_animationController);
                  _animationController.forward(from: 0.0);
                });
              },
              children: [
                OnboardingColumn(
                  image: img2,
                  subtitle: "",
                  title: appString.ANYWHERE,
                ),
                OnboardingColumn(
                  image: img3,
                  subtitle: "",
                  title: appString.ATANYTIME,
                ),
                OnboardingColumn(
                  image: imge4,
                  subtitle: "",
                  title: appString.BOOKYOURBIKE,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: CircularButton(
              progressValue: _animation.value,
              onPressed: _increaseProgress,
            ),
          ),
        ],
      ),
    );
  }
}

class CircularButton extends StatelessWidget {
  final double progressValue;
  final VoidCallback onPressed;

  CircularButton({
    required this.progressValue,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: CircularProgressIndicator(
              value: progressValue,
              strokeWidth: 8.0,
              valueColor: AlwaysStoppedAnimation<Color>(excellentColor),
              backgroundColor: iconDisplayColor,
            ),
          ),
          // دائرة خلف الأيقونة
          if (progressValue < 1.0)
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: excellentColor, // اللون الخلفي للدائرة
                border: Border.all(
                  color: excellentColor, // لون الإطار
                  width: 2,
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.arrow_forward,
                  size: 20,
                  color: grayColor,
                ),
              ),
            ),
          // عرض النص "Go" فقط في آخر صفحة
          if (progressValue == 1.0)
            Positioned(
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: excellentColor, // اللون الخلفي للدائرة
                  border: Border.all(
                    color: excellentColor, // لون الإطار
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Text(
                    'Go',
                    style: TextStyle(
                      color: white,
                      fontSize: 21,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class OnboardingColumn extends StatelessWidget {
  OnboardingColumn(
      {required this.image, required this.title, required this.subtitle});
  final String image;
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          image,
          height: 270,
        ),
        const SizedBox(height: 30),
        Text(
          title,
          textAlign: TextAlign.center,
          style: titleStyle,
        ),
        const SizedBox(height: 30),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: subtitleStyle,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
