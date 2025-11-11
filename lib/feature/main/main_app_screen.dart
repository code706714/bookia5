import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/utils/colors.dart';
import 'package:bookia/feature/cart/presentation/page/cart_screen.dart';
import 'package:bookia/feature/home/presentation/page/home_screen.dart';
import 'package:bookia/feature/wishlist/presentation/page/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key, this.index});
  final int? index;

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  int _currentIndex = 0;

  List<Widget> pages = [
    HomeScreen(),
    WishlistScreen(),
    CartScreen(),
    HomeScreen(),
  ];

  @override
  void initState() {
    _currentIndex = widget.index ?? _currentIndex;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant MainAppScreen oldWidget) {
    _currentIndex = widget.index ?? _currentIndex;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          _buildNavBarItem(label: 'Home', iconPath: AppImages.homeSvg),
          _buildNavBarItem(label: 'Wishlist', iconPath: AppImages.bookmarkSvg),
          _buildNavBarItem(label: 'Cart', iconPath: AppImages.cartSvg),
          _buildNavBarItem(label: 'Profile', iconPath: AppImages.profileSvg),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildNavBarItem({
    required String label,
    required String iconPath,
  }) {
    return BottomNavigationBarItem(
      activeIcon: SvgPicture.asset(
        iconPath,
        colorFilter: ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
      ),
      icon: SvgPicture.asset(iconPath),
      label: label,
    );
  }
}
