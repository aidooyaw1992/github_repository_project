import 'package:flutter/material.dart';

import 'favourites_page.dart';
import 'trending_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin<HomePage> {
  late PageController pageController;

  int bottomSelectedIndex = 0;

  @override
  void initState() {
    pageController = PageController(
      initialPage: bottomSelectedIndex,
      keepPage: true,
    );
    super.initState();
  }

  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
    });
  }

  void onBottomTap(int? index) {
    if (index == null) return;

    setState(() {
      pageController.jumpToPage(index);
      bottomSelectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: pageChanged,
        children: [TrendingPage(), FavouritesPage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onBottomTap,
        currentIndex: bottomSelectedIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            label: "Trending",
            icon: Icon(Icons.trending_up_sharp),
          ),
          BottomNavigationBarItem(
            label: "Favourites",
            icon: Icon(Icons.favorite),
          ),
        ],
      ),
    );
  }
}

