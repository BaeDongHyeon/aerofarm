import 'package:capstone/LRPage/LRPageLoginRegister.dart';
import 'package:capstone/LRPage/LRPageTop.dart';
import 'package:capstone/themeData.dart';
import 'package:flutter/material.dart';

class LRPage extends StatefulWidget {
  const LRPage({Key? key}) : super(key: key);

  @override
  State<LRPage> createState() => _LRPageState();
}

class _LRPageState extends State<LRPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Center(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _scrollController,
          scrollDirection: Axis.vertical,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  LRPageTop(),
                  LRPageLoginRegister(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
