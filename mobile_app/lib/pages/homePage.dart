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
      drawer: StatefulBuilder(
        builder: (context, setState2) {
          return Drawer(
            child: ListView(
              children: [
                isSignedIn
                    ? Card(
                        child: ListTile(
                          leading: Icon(Icons.account_circle),
                          title: Text('Sign out'),
                          onTap: () async {
                            signOut();
                            await Navigator.of(context).maybePop(context);
                            setState2(() {});
                          },
                        ),
                      )
                    : Card(
                        child: ListTile(
                          leading: Icon(Icons.account_circle),
                          title: Text('Sign-in or Sign-up'),
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpPage()),
                            );

                            setState2(() {});
                          },
                        ),
                      ),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.report),
                    title: Text('licences'),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AboutDialog(
                          applicationName: 'Give it',
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'An error occurred',
                        ),
                        FlatButton(
                          color: grey,
                          child: Text(
                            'Try again',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(color: Colors.white),
                          ),
                          onPressed: () {
                            setState(() {});
                          },
                        )
                      ],
                    ),
                  );
                }

                return GridView.builder(
                  itemCount: data.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  itemBuilder: (context, index) =>
                      CategoryWidget(data[index], location),
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
