import 'package:askute/controller/SearchController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

import '../../controller/HomeController.dart';
import '../Home/hot_post_screen.dart';
import '../Home/search_screen.dart';

class HomeSearchScreen extends StatefulWidget {
  const HomeSearchScreen({super.key});

  @override
  State<HomeSearchScreen> createState() => _HomeSearchScreenState();
}

class _HomeSearchScreenState extends State<HomeSearchScreen> {
  final HomeController _homeController = Get.put(HomeController());
  final SearchPostController _searchPostController = Get.put(SearchPostController());
  List<String> searchSuggestions = [
    'Từ khóa gợi ý 1',
    'Từ khóa gợi ý 2',
    'Từ khóa gợi ý 3',
    // Thêm các từ khóa gợi ý khác nếu cần
  ];

  OverlayEntry? _overlayEntry;
  TextEditingController _searchController = TextEditingController();
  FocusNode _searchFocusNode = FocusNode();
List<String> historyKeys = [];
  @override
  void initState() {
    super.initState();
    //_homeController.load10HotPost(context);
    _searchPostController.loadHistoryKeywords(context);
    setState(() {
      _searchPostController.loadHistoryKeywords(context);
    });
    print('bắt đầu tới channel');
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    _searchPostController.textControllerKeyword.text='';

    super.dispose();
  }

  void _showSearchSuggestions(BuildContext context) {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
      return;
    }

    _overlayEntry = OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: () {
          // Lấy vị trí của người dùng khi click
          RenderBox? overlay = context.findRenderObject() as RenderBox?;
          var position = overlay!.localToGlobal(Offset.zero);

          // Lấy kích thước của danh sách gợi ý
          double suggestionListHeight = (searchSuggestions.length * 56).toDouble(); // Chiều cao mỗi ListTile trong danh sách gợi ý là 56
          double top = position.dy + kToolbarHeight + 10; // Vị trí y của danh sách gợi ý
          double bottom = top + suggestionListHeight;

          // Kiểm tra xem người dùng có click ngoài danh sách gợi ý hay không
          if (position.dy < top || position.dy > bottom) {
            _hideSearchSuggestions();
          }
        },
        child: Material(
          elevation: 4.0,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: searchSuggestions
                  .map((suggestion) => ListTile(
                title: Text(suggestion),
                onTap: () {
                  _searchController.text = suggestion;
                  _searchController.selection = TextSelection.fromPosition(TextPosition(offset: suggestion.length));
                  _hideSearchSuggestions();
                },
              ))
                  .toList(),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context)?.insert(_overlayEntry!);
  }


  void _hideSearchSuggestions() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                title: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchPostController.textControllerKeyword,
                          focusNode: _searchFocusNode,
                          onTap: () {
                            //_showSearchSuggestions(context);
                          },
                          onChanged: (value) {
                            // Handle search text change
                          },
                          decoration: InputDecoration(
                            hintText: 'Search for.....',
                            hintStyle: TextStyle(
                                color: Color(0xFFB4BDC4),
                              fontSize: 14
                            ),
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Handle search button tap
                          final check = _searchPostController.textControllerKeyword.text;
                          if (check.trim()!= '')
                         {_searchPostController.loadListResultController(context);
                          _searchPostController.addSearchKeywords(_searchPostController.textControllerKeyword.text);
                          _searchPostController.loadHistoryKeywords(context);

                          setState(() {
                            HomeSearchScreen();
                            historyKeys = _searchPostController.lastFiveKeywords;
                          });
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.bottomToTop,
                              child: SearchResultScreen(),
                            ),
                          );}
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.search),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: Container(
            child: Column(
              children: [
                // Your body content here
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 5),
                    height: 2, // Chiều cao của thanh ngang
                    width: 200, // Độ dày của thanh ngang
                    color: Colors.black12,
                  ),
                ),
                Text('Lịch sử tìm kiếm'),
                _buildHistoryKeywords(_searchPostController.lastFiveKeywords),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildHistoryKeywords(List<String> lastFiveKeywords) {
    return        Expanded(
          child: ListView.builder(
            itemCount: lastFiveKeywords.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(lastFiveKeywords[index]),
                onTap: () {
                  // Xử lý khi người dùng nhấn vào từ khóa tìm kiếm
                  _searchPostController.textControllerKeyword.text=lastFiveKeywords[index];
                },
              );
            },
          ),
    );
  }
}
