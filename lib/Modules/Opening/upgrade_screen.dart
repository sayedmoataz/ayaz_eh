

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadayek_hof/Cubit/cubit.dart';
import 'package:hadayek_hof/Cubit/states.dart';

import '../../Shared/AppBar/update_appar.dart';

class UpgradeScreen extends StatelessWidget {
  const UpgradeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) { },
      builder: (context, snapshot) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          appBar: updateAppBar(),
          body: AlertDialog(
            content: const Text("بوجد تحديث جديد للتطبيق يرجى التحديث الآن"),
            actions: [
              TextButton(onPressed:  () => cubit.launchUrl2("https://play.google.com/store/apps/details?id=com.Hadayekhof.HadayekHof"), child: const Text("تحديث الآن"))
            ],
          ),
        );
      }
    );
  }
}