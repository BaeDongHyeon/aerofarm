import 'package:capstone/model/BoardType.dart';
import 'package:capstone/widget/BoardAnnouncementWidget.dart';
import 'package:capstone/widget/CustomAppBar.dart';
import 'package:capstone/widget/CustomDrawer.dart';
import 'package:capstone/widget/FloatingWidget.dart';
import 'package:capstone/widget/TitleListViewButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/Screen.dart';
import '../provider/Controller.dart';
import '../service/fetch.dart' as fetch;
import '../themeData.dart';
import '../widget/BoardWidget.dart';

class CommunityScreen extends StatelessWidget {
  final BoardType boardType;
  const CommunityScreen({Key? key, required this.boardType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _key = GlobalKey();
    final floatingController = Get.put(FloatingController());
    final loadingController = Get.put(LoadingController());
    final boardListController = Get.put(BoardListController());
    final routeController = Get.put(RouteController());
    final scrollController = ScrollController();
    //final selectController = Get.put(SearchController())

    //onWillPop을 사용하려면 이렇게 해야함
    loadingController.context = context;

    routeController.setBoardType(boardType);
    if(boardType==BoardType.announcement){
      fetch.startAnnouncementProcess().then((value) => loadingController.setFalse());
    }else if(boardType == BoardType.hot) {
      fetch.startHotProcess(boardType).then((value) => loadingController.setFalse());
    }else{
      fetch.startProcess(boardType).then((value) => loadingController.setFalse());
    }
    //fetch.startFetch(boardType).then((value) => loadingController.setFalse());

    scrollController.addListener(() {
      if(scrollController.offset == scrollController.position.maxScrollExtent){
        fetch.loadProcess(boardType);
        //fetch.loadFetch(boardType);
      }
    });

    return GestureDetector(
      onDoubleTap: () {
        floatingController.toggle();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: MainColor.six,
        key: _key,
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: Obx(()=>floatingController.floating.value ? const FloatingWidget(type: Screen.community): const SizedBox()),
        appBar: CustomAppBar( title: "도시농부",onPressed: (){_key.currentState!.openDrawer();},iconData: Icons.menu,home: true,),
        drawer: SizedBox(
          width: MainSize.width * 0.75,
          height: MainSize.height,
          child: const Drawer(
            backgroundColor: Colors.black,
            child: CustomCommunityDrawer(),
          ),
        ),
        body: RefreshIndicator(
          backgroundColor: Colors.black,
          color: Colors.white,
          onRefresh: () async {
            if(boardType==BoardType.announcement){
              fetch.startAnnouncementProcess().then((value) => loadingController.setFalse());
            }else if(boardType == BoardType.hot) {
              fetch.startHotProcess(boardType).then((value) => loadingController.setFalse());
            }else{
              fetch.startProcess(boardType).then((value) => loadingController.setFalse());
            }
            //fetch.startProcess(boardType);
            //fetch.startFetch(boardType);
          },
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.fromLTRB(
                MainSize.width * 0.03,
                0,
                MainSize.width * 0.03,
                MainSize.width * 0.04,
              ),
              color: MainColor.six,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        boardType.displayName,
                        style: CommunityScreenTheme.title,
                      ),
                      Container(
                        height: MainSize.height * 0.039,
                        width: MainSize.width * 0.6,
                        padding: EdgeInsets.only(
                          left: MainSize.width * 0.021,
                        ),
                        child: TitleListViewButton(boardType: boardType),
                      )
                    ],
                  ),
                  Obx(()=>!(loadingController.loading.value) ?
                  Container(
                      margin: EdgeInsets.only(
                        top: MainSize.height * 0.014,
                      ),
                      constraints: BoxConstraints(
                        minHeight: MainSize.height*0.8
                      ),
                      child: Column(children: boardListController.boardList))
                      :
                  const Center(
                      child: CircularProgressIndicator(
                        color: MainColor.three,
                      )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}