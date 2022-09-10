import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:tyba_test/src/repository/models/university.dart';
import 'package:tyba_test/src/repository/network/shared_configuration.dart';
import 'package:tyba_test/src/utils/routes/navigation.dart';

import '../bloc/university_bloc/university_bloc.dart';
import '../bloc/university_bloc/university_bloc_event.dart';
import '../bloc/university_bloc/university_bloc_state.dart';
import '../utils/theme/colors.dart';
import '../utils/widgets/loading.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({this.newBLoc});
  static const String routeName = 'home_screen';
  // ignore: prefer_typing_uninitialized_variables
  final newBLoc;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late UniversityBloc _bloc = UniversityBloc();
  bool isLoading = false;
  bool _gridFlag = true;
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    widget.newBLoc == null
        ? _bloc.add(GetUniversitysEvent())
        : _bloc = widget.newBLoc;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            _header,
            _content(context),
            if (isLoading) Loading(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _gridFlag = !_gridFlag;
          });
        },
        backgroundColor: AppColors.primaryDarkColor,
        child:
            _gridFlag ? Icon(Icons.app_registration_sharp) : Icon(Icons.list),
      ),
    );
  }

  Widget get _header => SizedBox(
        width: 100.w,
        child: SvgPicture.network(
          SharedConfiguration.network.baseUrlImageTyba,
          semanticsLabel: 'Tyba Logo',
          placeholderBuilder: (BuildContext context) => Container(
            padding: const EdgeInsets.all(30.0),
            child: Center(
              child: const CircularProgressIndicator(),
            ),
          ),
        ),
      );
  Widget _content(BuildContext context) =>
      BlocBuilder<UniversityBloc, UniversityState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state is HasUniversityState) {
            return Container(
              margin: EdgeInsets.only(top: 8.h),
              child: _gridFlag
                  ? _list(context, state.universities)
                  : _grid(context, state.universities),
            );
          }
          return Center();
        },
      );

  Widget _list(BuildContext context, List<UniversityModel> data) {
    return NotificationListener<ScrollEndNotification>(
        onNotification: (notification) {
          if (_controller.position.maxScrollExtent ==
              _controller.position.pixels) {
            //TODO me falto implementar la logica para el scroll infinito
          }
          return true;
        },
        child: ListView.builder(
          controller: _controller,
          itemCount: data.length,
          physics: BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) => Container(
            height: 7.h,
            width: 90.w,
            margin: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
            decoration: BoxDecoration(
              color: AppColors.primaryLigthColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: InkWell(
              onTap: (() {
                navigateToDetailScreen(context, _bloc, index);
              }),
              child: ListTile(
                leading: data[index].image != null
                    ? SizedBox(
                        height: 60,
                        width: 50,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(180),
                          child: Image.file(
                            File(data[index].image!),
                          ),
                        ),
                      )
                    : SizedBox(
                        height: 60,
                        width: 50,
                        child: Image(
                          fit: BoxFit.scaleDown,
                          height: 4.h,
                          image: NetworkImage(
                              'https://cdn-icons-png.flaticon.com/512/154/154378.png?w=1380&t=st=1662821833~exp=1662822433~hmac=b58c788c8bc7096d4bbe8e61fec61d731164dd245ab07033ae8a73c5ff77b412'),
                        ),
                      ),
                title: Text(data[index].name),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
          ),
        ));
  }

  Widget _grid(BuildContext context, List<UniversityModel> data) {
    return NotificationListener<ScrollEndNotification>(
      onNotification: (notification) {
        if (_controller.position.maxScrollExtent ==
            _controller.position.pixels) {
          //TODO me falto implementar la logica para el scroll infinito
        }

        return true;
      },
      child: GridView.count(
        crossAxisCount: 2,
        controller: _controller,
        childAspectRatio: 3.6 / 4,
        children: List.generate(data.length, (index) {
          return Center(
            child: InkWell(
              onTap: (() {
                navigateToDetailScreen(context, _bloc, index);
              }),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                color: AppColors.primaryLigthColor,
                margin: EdgeInsets.all(15),
                elevation: 10,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: SizedBox(
                    width: 100.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        data[index].image != null
                            ? Image.file(File(data[index].image!))
                            : Image(
                                fit: BoxFit.scaleDown,
                                height: 13.h,
                                image: NetworkImage(
                                    'https://cdn-icons-png.flaticon.com/512/154/154378.png?w=1380&t=st=1662821833~exp=1662822433~hmac=b58c788c8bc7096d4bbe8e61fec61d731164dd245ab07033ae8a73c5ff77b412'),
                              ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            data[index].name,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
