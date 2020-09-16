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
                      child: RoundedDropDownButton(
                        DropdownButton<String>(
                          hint: Text(
                            'Category',
                            style: Theme.of(context).textTheme.bodyText1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          value: category,
                          items: <DropdownMenuItem<String>>[
                            for (int i = 1; i < categories.length; i++)
                              DropdownMenuItem<String>(
                                value: categories[i],
                                child: Text(
                                  categories[i],
                                  //categoriesAssets.keys.toList()[i],
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              )
                          ],
                          onChanged: (value) {
                            setState(() {
                              category = value;
                            });
                          },
                        ),
                      )),

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

                  if (!_descriptionKey.currentState.validate()) return;

                  if (!_subCategoryKey.currentState.validate()) return;

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

                  addPost(
                    phoneNumber: user.phoneNumber,
                    userToken: user.uid,
                    images: images,
                    categoryId: categories.indexOf(category),
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

                  await Navigator.of(context).maybePop(context);
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
      return ListView(
        padding: EdgeInsets.only(top: 150, left: 60, right: 60),
        children: [
          Center(
            child: Text(
              'Please sign-in first',
              style:
                  Theme.of(context).textTheme.headline6.copyWith(fontSize: 25),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
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
          )
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
