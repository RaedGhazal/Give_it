part of pages;

class PostPage extends StatefulWidget {
  final String category;

  const PostPage({@required this.category});

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {

  final location = Location();

  var val;

  Post post = Post(
      id: -1,
      subCategory: 'Sub category test',
      categoryId: 0,
      description: 'description test',
      city: 'amman',
      country: 'Jordan',
      phoneNumber: '+962 77xxxxxxxx',
      urlImages: [
        'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6e/Zinnienbl%C3%BCte_Zinnia_elegans_stack15_20190722-RM-7222254.jpg/400px-Zinnienbl%C3%BCte_Zinnia_elegans_stack15_20190722-RM-7222254.jpg',
        'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6e/Zinnienbl%C3%BCte_Zinnia_elegans_stack15_20190722-RM-7222254.jpg/400px-Zinnienbl%C3%BCte_Zinnia_elegans_stack15_20190722-RM-7222254.jpg',
        'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6e/Zinnienbl%C3%BCte_Zinnia_elegans_stack15_20190722-RM-7222254.jpg/400px-Zinnienbl%C3%BCte_Zinnia_elegans_stack15_20190722-RM-7222254.jpg',
      ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.category),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: SortByLocation(location),
          )
        ],
      ),
      body: ListView.builder(itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: PostWidget(post),
        );
      }),
    );
  }
}
