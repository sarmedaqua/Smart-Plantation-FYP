import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:assignment_starter/view/screens/locate_plantation_point.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:assignment_starter/staticfiles/constants.dart';
import 'package:assignment_starter/Domain/plants.dart';
import 'package:assignment_starter/view/screens/scan_page.dart';
//import 'package:assignment_starter/view/screens/more_screens/cart_page.dart';
import 'package:assignment_starter/view/screens/more_screens/favorite_page.dart';
import 'package:assignment_starter/view/screens/more_screens/home_page.dart';
import 'package:assignment_starter/view/screens/more_screens/profile_page.dart';
import 'package:page_transition/page_transition.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  late User _user;
  List<Plant> favorites = [];
  //List<Plant> myCart = [];

  int _bottomNavIndex = 0;

  @override
  void initState() {
    _user = widget._user;
    print(_user);

    super.initState();
  }

  //List of the pages
  List<Widget> _widgetOptions(){
    return [
      HomePage(user: _user,),
      FavoritePage(favoritedPlants: favorites,),
      //CartPage(addedToCartPlants: myCart,),
      const MapSample(),
      ProfilePage(user: _user),
    ];
  }


  //List of the pages icons
  List<IconData> iconList = [
    Icons.home,
    Icons.favorite,
    //Icons.shopping_cart,
    Icons.location_on_outlined,
    Icons.person,

  ];

  //List of the pages titles
  List<String> titleList = [
    'Home',
    'Favorite',
    //'Cart',
    'Map',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(titleList[_bottomNavIndex], style: TextStyle(
              color: Constants.blackColor,
              fontWeight: FontWeight.w500,
              fontSize: 24,
            ),),
            Icon(Icons.notifications, color: Constants.blackColor, size: 30.0,)
          ],
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
      ),
      body: IndexedStack(
        index: _bottomNavIndex,
        children: _widgetOptions(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, PageTransition(child: const ScanPage(), type: PageTransitionType.bottomToTop));
        },
        child: Image.asset('assets/images/code-scan-two.png', height: 30.0,),
        backgroundColor: Constants.primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: AnimatedBottomNavigationBar(
          splashColor: Constants.primaryColor,
          activeColor: Constants.primaryColor,
          inactiveColor: Colors.black.withOpacity(.5),
          icons: iconList,

          activeIndex: _bottomNavIndex,
          gapLocation: GapLocation.none,
          notchSmoothness: NotchSmoothness.softEdge,
          onTap: (index){
            setState(() {
              _bottomNavIndex = index;
              final List<Plant> favoritedPlants = Plant.getFavoritedPlants();
              //final List<Plant> addedToCartPlants = Plant.addedToCartPlants();

              favorites = favoritedPlants;
              //myCart = addedToCartPlants.toSet().toList();
            });
          }
      ),
    );
  }
}

