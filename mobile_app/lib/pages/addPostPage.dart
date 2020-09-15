part of pages;

class AddPostBody extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<ScaffoldState> homeScaffoldKey;

  AddPostBody(this.scaffoldKey, this.homeScaffoldKey);

  @override
  _AddPostBodyState createState() => _AddPostBodyState();
}

class _AddPostBodyState extends State<AddPostBody> {
  Location location = Location();

  String category;

  List<Category> downloadedCategories;

  final _descriptionKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();

  final _subCategoryKey = GlobalKey<FormState>();
  final _subCategoryController = TextEditingController();

  FilePickerResult filePickerResult;

  @override
  Widget build(BuildContext context) {
    if (isSignedIn) {
      return Stack(
        fit: StackFit.expand,
        children: [
          ListView(
            padding: EdgeInsets.only(top: 15, left: 10, right: 10),
            children: [
              //Add images.
              Text(
                'Add one image at least',
                style: Theme.of(context).textTheme.bodyText1,
              ),

              SizedBox(
                height: 10,
              ),

              Container(
                height: 100,
                width: double.infinity,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: GestureDetector(
                        child: Container(
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 30,
                          ),
                          color: lightGrey,
                        ),
                        onTap: () async {
                          filePickerResult =
                              await FilePicker.platform.pickFiles(
                            type: FileType.image,
                            allowCompression: true,
                            allowMultiple: true,
                            withData: true,
                          );

                          setState(() {});
                        },
                      ),
                    ),
                    if (filePickerResult != null)
                      for (int i = 0; i < filePickerResult.files.length; i++)
                        AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            child: Image.memory(
                              filePickerResult.files[i].bytes,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                  ],
                ),
              ),

              const SizedBox(
                height: 15,
              ),

              //Location
              const SizedBox(
                height: 15,
              ),
              PickLocation(location),

              const SizedBox(
                height: 15,
              ),

              Row(
                children: [
                  //Category
                  Expanded(
                    flex: 1,
                    child: FutureBuilder<List<Category>>(
                      future: getAllCategories(),
                      builder: (context, snap) {
                        if (snap.connectionState == ConnectionState.done) {
                          final data = snap.data;
                          if (data == null) {
                            return Center(
                              child: Text(snap.error.toString()),
                            );
                          }

                          downloadedCategories = data;

                          return StatefulBuilder(
                            builder: (context, setState2) {
                              return RoundedDropDownButton(
                                DropdownButton<String>(
                                  hint: Text(
                                    'Category',
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  value: category,
                                  items: <DropdownMenuItem<String>>[
                                    for (int i = 0; i < data.length; i++)
                                      DropdownMenuItem<String>(
                                        value: data[i].name,
                                        child: Text(
                                          data[i].name,
                                          //categoriesAssets.keys.toList()[i],
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        ),
                                      )
                                  ],
                                  onChanged: (value) {
                                    setState2(() {
                                      category = value;
                                    });
                                  },
                                ),
                              );
                            },
                          );
                        }

                        return RoundedDropDownButton(
                          DropdownButton<String>(
                            hint: Text(
                              'Category',
                              style: Theme.of(context).textTheme.bodyText1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            value: category,
                            items: categoriesAssets.keys.map((e) {
                              return DropdownMenuItem<String>(
                                value: e,
                                child: Text(
                                  e,
                                  //categoriesAssets.keys.toList()[i],
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                category = value;
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(
                    width: 15,
                  ),

                  //Sub-category
                  Expanded(
                    flex: 1,
                    child: MyForm(
                      labelText: 'Sub category',
                      formKey: _subCategoryKey,
                      controller: _subCategoryController,
                      validator: (value) {
                        if (value.trim().isEmpty)
                          return 'Sub category cannot be empty';
                        return null;
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 10,
              ),

              //Description.
              MyForm(
                labelText: 'Description',
                formKey: _descriptionKey,
                controller: _descriptionController,
                validator: (value) {
                  if (value.trim().length == 0)
                    return 'Description cannot be empty';

                  return null;
                },
              ),

              const SizedBox(
                height: 10,
              ),

              //Upload
              FlatButton(
                color: grey,
                child: Text('Upload',
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: Colors.white,
                        )),
                onPressed: () async {
                  if (filePickerResult == null) {
                    showSnackBar(widget.scaffoldKey,
                        content: 'Choose at least one image');

                    return;
                  }
                  if (filePickerResult.files.length > 5) {
                    showSnackBar(widget.scaffoldKey,
                        content:
                            'Maximum number of images is 5 , please reduce the number of images');

                    return;
                  }

                  _descriptionKey.currentState.validate();
                  _subCategoryKey.currentState.validate();

                  if (category == null) {
                    showSnackBar(widget.scaffoldKey,
                        content: 'category cannot be empty');
                    return;
                  }

                  if (location == null) {
                    showSnackBar(widget.scaffoldKey,
                        content: 'location cannot be empty');
                    return;
                  }

                  final images = List<List<String>>();
                  for (var i = 0; i < filePickerResult.files.length; i++)
                    images.add([
                      base64Encode(filePickerResult.files[i].bytes),
                      filePickerResult.files[i].name
                    ]);

                  //TODO: TEST ONLY , FIX IT.
                  addPost(
                    phoneNumber: '+962770551747',
                    userToken: 'ABCD',
                    images: images,
                    categoryId: downloadedCategories
                        .where((element) {
                          if (element.name == category) return true;
                          if (element.name == category) return true;

                          return false;
                        })
                        .toList()
                        .first
                        .id,
                    subCategory: _subCategoryController.text.trim(),
                    country: 'jordan',
                    city: location.governorate,
                    description: _descriptionController.text.trim(),
                  ).then((value) {
                    if (widget.homeScaffoldKey?.currentState != null) {
                      showSnackBar(widget.homeScaffoldKey,
                          color: Colors.green, content: 'Post uploaded');
                    }
                  }).catchError((onError) {
                    if (widget.homeScaffoldKey?.currentState != null) {
                      showSnackBar(widget.homeScaffoldKey,
                          color: Colors.red,
                          content: 'Error : your post cannot be uploaded');
                    }
                  });

                  await Navigator.maybePop(context);
                  showSnackBar(widget.homeScaffoldKey,
                      color: Colors.green,
                      content: 'your post is being processed');
                  setState(() {});
                },
              ),
            ],
          ),
        ],
      );
    } else {
      return Row(
        children: [
          Expanded(
            child: FlatButton(
              child: Text(
                'Sign in',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.white),
              ),
              color: grey,
              onPressed: () async {
                await Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpPage()));
                setState(() {});
              },
            ),
          ),
        ],
      );
    }
  }
}

class AddPostPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> homeScaffoldKey;

  const AddPostPage(this.homeScaffoldKey);

  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Add post'),
      ),
      body: AddPostBody(_scaffoldKey, widget.homeScaffoldKey),
    );
  }
}
