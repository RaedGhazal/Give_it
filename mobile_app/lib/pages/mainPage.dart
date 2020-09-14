part of pages;

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(
              child: Text('Home'),
              icon: Icon(Icons.home),
            ),
            Tab(
              child: Text('Add post'),
              icon: Icon(Icons.home),
            ),
            Tab(
              child: Text('Settings'),
              icon: Icon(Icons.home),
            ),
          ],
        ),
        body: TabBarView(
          children: [
            HomePage(),
            AddPostPage(),
            SettingsPage(),
          ],
        ),
      ),
    );
  }
}
