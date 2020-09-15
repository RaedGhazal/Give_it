part of pages;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Home'),
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: grey,
          ),
          onPressed: () {
            _scaffoldKey.currentState.openDrawer();
          },
        ),
      ),
      drawer: Drawer(),
      floatingActionButton: LemonFloatingButton(_scaffoldKey),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
          ),
          children: [
            CategoryWidget(
              asset: 'assets/categories/furniture.jpg',
              label: 'Furniture',
            ),
            CategoryWidget(
              asset: 'assets/categories/clothes.jpg',
              label: 'clothes',
            ),
            CategoryWidget(
              asset: 'assets/categories/electronics.jpg',
              label: 'Electronics',
            ),
            CategoryWidget(
              asset: 'assets/categories/tools.jpg',
              label: 'Tools',
            ),
            CategoryWidget(
              asset: 'assets/categories/pets_accessories.jpg',
              label: ' Pets accessories',
            ),
            CategoryWidget(
              asset: 'assets/categories/books.jpg',
              label: 'Books',
            ),
            CategoryWidget(
              asset: 'assets/categories/all.jpg',
              label: 'All',
            ),
          ],
        ),
      ),
    );
  }
}
