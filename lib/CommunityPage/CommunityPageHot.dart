import 'package:capstone/CommunityPage/CommunityPageAll.dart';
import 'package:capstone/CommunityPage/CommunityPageDrawer.dart';
import 'package:capstone/CommunityPage/CommunityPageFloating.dart';
import 'package:capstone/MainPage/MainPage.dart';
import 'package:capstone/themeData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../CurrentTime.dart';

class CommunityPageHot extends StatefulWidget {
  const CommunityPageHot({Key? key}) : super(key: key);

  @override
  State<CommunityPageHot> createState() => _CommunityPageHotState();
}

class _CommunityPageHotState extends State<CommunityPageHot> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const CommunityPageFloating(),
      appBar: AppBar(
        centerTitle: true,
        //foregroundColor: Colors.transparent,
        backgroundColor: MainColor.six,
        //backgroundColor: Colors.transparent,
        toolbarHeight: MainSize.toobarHeight,
        elevation: 0,
        leadingWidth: MediaQuery.of(context).size.width * 0.2106,
        leading: Container(
          margin:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
          child: FittedBox(
              child: Builder(
            builder: (context) => IconButton(
              padding: EdgeInsets.zero,
              alignment: Alignment.center,
              color: MainColor.three,
              iconSize: 50,
              // 패딩 설정
              constraints: const BoxConstraints(),
              icon: const Icon(
                Icons.menu,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          )),
        ),
        title: const Text(
          "도시농부",
          style: MainTheme.title,
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(
                right: MediaQuery.of(context).size.width * 0.05),
            child: Builder(
              builder: (context) => IconButton(
                padding: EdgeInsets.zero,
                alignment: Alignment.center,
                color: MainColor.three,
                iconSize: 50,
                constraints: const BoxConstraints(),
                icon: const Icon(
                  Icons.home,
                ),
                onPressed: () {
                  Get.off(const MainPage());
                },
              ),
            ),
          )
        ],
      ),
      drawer: SizedBox(
        width: MediaQuery.of(context).size.width * 0.75,
        height: MediaQuery.of(context).size.height,
        child: const Drawer(
          backgroundColor: Colors.black,
          child: CommunityPageDrawer(),
        ),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width * 0.04,
          0,
          MediaQuery.of(context).size.width * 0.04,
          MediaQuery.of(context).size.height * 0.018,
        ),
        color: MainColor.six,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.016),
                    child: const Text(
                      "인기게시판",
                      style: CommunityPageTheme.title,
                      textAlign: TextAlign.left,
                    )),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.021,
                    bottom: MediaQuery.of(context).size.height * 0.018,),
                  child: ListView(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      TitleButton(title: "전체",onPressed: (){
                        Get.to(const CommunityPageAll());
                      }),
                      TitleButton(title: "자유",onPressed: (){
                        Get.to(const CommunityPageAll());
                      }),
                      TitleButton(title: "사진",onPressed: (){
                        Get.to(const CommunityPageAll());
                      }),
                      TitleButton(title: "정보",onPressed: (){
                        Get.to(const CommunityPageAll());
                      }),
                      TitleButton(title: "질문",onPressed: (){
                        Get.to(const CommunityPageAll());
                      }),
                      TitleButton(title: "거래",onPressed: (){
                        Get.to(const CommunityPageAll());
                      }),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.012),
              decoration: const BoxDecoration(
                  border: Border(
                bottom: BorderSide(width: 1, color: Colors.white),
              )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.015),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Text(
                      "필독",
                      style: CommunityPageTheme.main,
                    ),
                  ),
                  const Text(
                    "도시농부 서비스 안내",
                    style: CommunityPageTheme.main,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.014,
              ),
              height: MediaQuery.of(context).size.height * 0.69,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.01,
                        right: MediaQuery.of(context).size.width * 0.01),
                    height: MediaQuery.of(context).size.height * 0.08,
                    decoration: const BoxDecoration(
                        border: Border(
                      bottom: BorderSide(width: 1, color: Colors.white),
                    )),
                    child: InkWell(
                      onTap: () {
                        //Get.off(()=>const MachinePageInfo());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Row(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.64,
                                  margin: EdgeInsets.only(
                                      right: MediaQuery.of(context).size.width *
                                          0.06),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          margin: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.008),
                                          child: Text(
                                            "도시농부 서비스 좋네여 $index",
                                            style: CommunityPageTheme.main,
                                          )),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "city",
                                            style: CommunityPageTheme.sub,
                                          ),
                                          const CurrentTime(
                                            type: true,
                                            style: 'sub',
                                          ),
                                          Text(
                                            "조회 $index",
                                            style: CommunityPageTheme.sub,
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                "추천 ",
                                                style: CommunityPageTheme.sub,
                                              ),
                                              Text(
                                                "$index",
                                                style: CommunityPageTheme.sub1,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.1,
                                  height: MediaQuery.of(context).size.height *
                                      0.048,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "$index",
                                    style: CommunityPageTheme.main,
                                    textAlign: TextAlign.center,
                                  ),
                                  decoration: BoxDecoration(
                                      color: MainColor.one,
                                      borderRadius: BorderRadius.circular(10)),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TitleButton extends StatelessWidget {
  const TitleButton({Key? key, required this.title, required this.onPressed}) : super(key: key);
  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.12,
      child: TextButton(
        onPressed: (){
         onPressed();
        },
        child: Text(title,style: CommunityPageTheme.titleButton,),
        style: TextButton.styleFrom(
            padding: EdgeInsets.zero
        ),
      ),
    );
  }
}
