// import 'package:flutter/material.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:money_transfer_app/src/models/user_model.dart';
// import 'package:money_transfer_app/src/providers/userProvider.dart';
// import 'package:money_transfer_app/src/screens/pages/agent_transaction_page.dart';
// import 'package:money_transfer_app/src/screens/pages/home_page.dart';
// import 'package:money_transfer_app/src/screens/pages/roles_page.dart';
// import 'package:money_transfer_app/src/screens/pages/sender_transaction_page.dart';
// import 'package:money_transfer_app/src/screens/pages/update_profile_page.dart';
// import 'package:provider/provider.dart';

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int _pageIndex = 0;
//   GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
//   late UserModel? user;
//   late List<Widget> _pages;

//   @override
//   void initState() {
//     super.initState();
//     user = Provider.of<UserProvider>(context, listen: true).user;

//     _pages = [
//       HomePage(),
//       if (user!.role == 'sender' || user!.role == 'receiver')
//         SenderTransactionPage(),
//       if (user!.role != 'sender' && user!.role != 'receiver') AgentTransactionPage(),
//       RolesPage(),
//       UpdateProfilePage(),
//     ];
//   }



//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[_pageIndex],
//       bottomNavigationBar: CurvedNavigationBar(
//         key: _bottomNavigationKey,
//         index: 0,
//         height: 50.0,
//         items: const <Widget>[
//           Icon(Icons.home, size: 20),
//           Icon(Icons.compare_arrows, size: 20),
//           Icon(Icons.group, size: 20),
//           Icon(Icons.person, size: 20),
//         ],
//         color: Colors.white,
//         buttonBackgroundColor: Colors.white,
//         backgroundColor: Colors.blueAccent,
//         animationCurve: Curves.easeInOut,
//         animationDuration: const Duration(milliseconds: 300),
//         onTap: (index) {
//           setState(() {
//             _pageIndex = index;
//           });
//         },
//         letIndexChange: (index) => true,
//       ),
//     );
//   }
// }


// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:money_transfer_app/src/models/user_model.dart';
import 'package:money_transfer_app/src/providers/userProvider.dart';
import 'package:money_transfer_app/src/screens/pages/agent_transaction_page.dart';
import 'package:money_transfer_app/src/screens/pages/home_page.dart';
import 'package:money_transfer_app/src/screens/pages/roles_page.dart';
import 'package:money_transfer_app/src/screens/pages/sender_transaction_page.dart';
import 'package:money_transfer_app/src/screens/pages/update_profile_page.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _pageIndex = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey<CurvedNavigationBarState>();

  List<Widget> _buildPages(UserModel user) {
    return [
      const HomePage(),
      if (user.role == 'sender' || user.role == 'receiver') 
        const SenderTransactionPage(),
      if (user.role != 'sender' && user.role != 'receiver') 
        const AgentTransactionPage(),
      const RolesPage(),
      const UpdateProfilePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    if (user == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final pages = _buildPages(user);

    return Scaffold(
      body: pages[_pageIndex],
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 50.0,
        items: const <Widget>[
          Icon(Icons.home, size: 20),
          Icon(Icons.compare_arrows, size: 20),
          Icon(Icons.group, size: 20),
          Icon(Icons.person, size: 20),
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.blueAccent,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        onTap: (index) {
          setState(() {
            _pageIndex = index;
          });
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}
