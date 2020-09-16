part of pages;

class PostPage extends StatefulWidget {
  final Category category;
  final Location location;

  const PostPage({@required this.category, @required this.location});

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(widget.category.name),
      ),
      body: FutureBuilder<List<Post>>(
        future: getPosts(
            country: 'jordan',
            city: widget.location.governorate,
            categoryId: widget.category.id),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.done) {
            final data = snap.data;

            if (data == null) {
              return Center(
                child: Text(snap.error.toString()),
              );
            }

            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: PostWidget(data[index]),
                  );
                });
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
