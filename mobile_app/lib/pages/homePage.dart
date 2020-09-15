part of pages;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final location = Location(governorate: 'All');
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> locationsWithAll = ['All', ...locations];

  Map<String, dynamic> usedCategories;

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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                icon: Icon(Icons.location_on),
                value: location.governorate,
                items: <DropdownMenuItem<String>>[
                  for (int i = 0; i < locationsWithAll.length; i++)
                    DropdownMenuItem<String>(
                      value: locationsWithAll[i],
                      child: Text(
                        locationsWithAll[i],
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    )
                ],
                onChanged: (value) {
                  setState(() => location.governorate = value);
                },
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(),
      floatingActionButton: LemonFloatingButton(_scaffoldKey),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<List<Category>>(
            future: getUsedCategories(
              country: 'jordan',
              city: location.governorate,
            ),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.done) {
                List<Category> data = snap.data;

                if (data == null) {
                  return Center(
                    child: Text(snap.error.toString()),
                  );
                }

                return GridView.builder(
                  itemCount: data.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  itemBuilder: (context, index) => CategoryWidget(data[index] , location),
                );
              }

              return Center(
                child: CircularProgressIndicator(),
              );
            },
          )),
    );
  }
}
