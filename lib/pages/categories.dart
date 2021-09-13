import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:iran_gard/iran_gard_icons_icons.dart';
import 'package:iran_gard/models/category.dart';

final List<Category> categories = [
  Category(
    name: 'کوه نوردی',
    icon: IranGardIcons.climbing,
    color: Colors.deepOrange,
  ),
  Category(name: 'طبیعت گردی', icon: IranGardIcons.nature, color: Colors.green),
  Category(
    name: 'پیاده روی',
    icon: IranGardIcons.walking,
    color: Colors.pink,
  ),
  Category(name: 'کویر گردی', icon: IranGardIcons.desert, color: Colors.brown),
  Category(
      name: 'برف بازی',
      icon: IranGardIcons.snow,
      color: Colors.limeAccent[700]),
  Category(name: 'اسکی', icon: IranGardIcons.ski, color: Colors.black),
  Category(
    name: 'شنا و غواصی',
    icon: IranGardIcons.swim,
    color: Colors.blue,
  ),
  Category(
      name: 'پاراگلایدر', icon: IranGardIcons.paraglider, color: Colors.red),
  Category(name: 'ماهی گیری', icon: IranGardIcons.fishing, color: Colors.amber),
  Category(
      name: 'قایق سواری', icon: IranGardIcons.bout, color: Colors.deepPurple),
  Category(
      name: 'دوچرخه سواری',
      icon: IranGardIcons.bycicle,
      color: Colors.cyan[900]),
  Category(
      name: 'آثار باستانی',
      icon: IranGardIcons.ancient,
      color: Colors.pink[900]),
  Category(
      name: 'سایر دسته بندی ها',
      icon: IranGardIcons.other,
      color: Colors.purple),
];

class CategoriesPage extends StatefulWidget {
  List<Category> selectedCategories;
  CategoriesPage({this.selectedCategories});

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  bool searchMode = false;
  bool _isFabExtended = true;
  bool upDirection = true, flag = true;
  TextEditingController searchTextController = TextEditingController();
  ScrollController _scrollController;

  List<Category> searchingCategories = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        upDirection = _scrollController.position.userScrollDirection ==
            ScrollDirection.forward;

        // makes sure we don't call setState too much, but only when it is needed
        if (upDirection != flag)
          setState(() {
            _isFabExtended = !_isFabExtended;
          });

        flag = upDirection;
      });
    searchTextController.addListener(() {
      searchingCategories = [];
      if (searchTextController.text.trim().isNotEmpty) {
        for (Category c in categories) {
          if (c.name.contains(searchTextController.text.trim()))
            searchingCategories.add(c);
        }
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Size pageSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(searchMode ? 0 : 48.0),
                bottomRight: Radius.circular(searchMode ? 0 : 48.0))),
        centerTitle: true,
        title: Text(
          'دسته بندی ها',
          style: TextStyle(
              fontFamily: 'Sans',
              fontWeight: FontWeight.bold,
              color: Color(0xFF232226)),
        ),
        automaticallyImplyLeading: true,
        elevation: searchMode ? 0 : 6.0,
        actions: [
          IconButton(
              icon: Icon(Icons.search_rounded, color: Color(0xFF232226)),
              onPressed: () {
                setState(() {
                  searchMode = !searchMode;
                });
              })
        ],
      ),
      body: Scaffold(
        appBar: searchMode
            ? AppBar(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(48.0),
                        bottomRight: Radius.circular(48.0))),
                centerTitle: true,
                title: Container(
                  width: pageSize.width - 64,
                  height: 35.0,
                  decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(
                        color: Color(0xFF232226),
                        width: 1.5,
                      )),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: pageSize.width - 100,
                        height: 35.0,
                        child: TextField(
                          controller: searchTextController,
                          textDirection: TextDirection.rtl,
                          cursorColor: Colors.white,
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'Sans'),
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'جستجو...',
                            hintTextDirection: TextDirection.rtl,
                            hintStyle: TextStyle(
                                color: Colors.white54,
                                fontFamily: 'Sans',
                                fontSize: 14.0),
                            alignLabelWithHint: true,
                            contentPadding: const EdgeInsets.only(
                                right: 8.0, bottom: 8.0, top: 8.0),
                          ),
                        ),
                      ),
                      if (searchTextController.text.isNotEmpty)
                        InkWell(
                          onTap: () {
                            setState(() {
                              searchTextController.clear();
                            });
                          },
                          child: Container(
                              height: 35.0,
                              width: 32.0,
                              child: Center(
                                child: Icon(
                                  Icons.close_rounded,
                                  color: Color(0xFF232226),
                                ),
                              )),
                        ),
                    ],
                  ),
                ),
                automaticallyImplyLeading: false,
              )
            : PreferredSize(
                child: SizedBox(),
                preferredSize: Size.fromHeight(0),
              ),
        body: GridView.count(
          crossAxisCount: ((pageSize.width / pageSize.height).round() == 0
              ? 2
              : (2.5 * (pageSize.width / pageSize.height)).round()),
          padding: EdgeInsets.all(8.0),
          children: List.generate(
              (searchMode && searchTextController.text.isNotEmpty)
                  ? searchingCategories.length
                  : categories.length, (index) {
            Category cat = (searchMode && searchTextController.text.isNotEmpty)
                ? searchingCategories[index]
                : categories[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      widget.selectedCategories != null &&
                              widget.selectedCategories.contains(cat)
                          ? cat.color
                          : Colors.white),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    side: BorderSide(
                      color: cat.color,
                      width: 2.5,
                    ),
                  )),
                ),
                onPressed: () {
                  if (widget.selectedCategories != null) {
                    setState(() {
                      if (widget.selectedCategories.contains(cat))
                        widget.selectedCategories.remove(cat);
                      else
                        widget.selectedCategories.add(cat);
                    });
                  }
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          right: (cat.icon == IranGardIcons.bout ? 64.0 : 0)),
                      child: Icon(
                        cat.icon,
                        color: widget.selectedCategories != null &&
                                widget.selectedCategories.contains(cat)
                            ? Colors.white
                            : cat.color,
                        size: (cat.icon == IranGardIcons.bout ? 44.0 : 64),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      cat.name,
                      style: TextStyle(
                          fontFamily: 'Sans',
                          fontSize: 11.0,
                          color: widget.selectedCategories != null &&
                                  widget.selectedCategories.contains(cat)
                              ? Colors.white
                              : Colors.black),
                      textDirection: TextDirection.rtl,
                    )
                  ],
                ),
              ),
            );
          }),
        ),
        floatingActionButton: widget.selectedCategories != null
            ? AnimatedContainer(
                duration: Duration(),
                child: FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.of(context).pop(widget.selectedCategories);
                  },
                  backgroundColor: Color(0xFF001FAB),
                  isExtended: _isFabExtended,
                  label: _isFabExtended
                      ? Text('انتخاب',
                          style: TextStyle(
                              fontFamily: "sans", color: Colors.white))
                      : Icon(
                          Icons.done,
                          color: Colors.white,
                        ),
                  icon: _isFabExtended
                      ? Icon(
                          Icons.done,
                          color: Colors.white,
                        )
                      : null,
                ))
            : null,
      ),
    );
  }
}
