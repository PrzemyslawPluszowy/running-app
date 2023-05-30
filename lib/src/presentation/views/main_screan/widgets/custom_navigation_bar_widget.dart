import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/src/presentation/cubits/bootom_navigation/page_view_bootom_n_avigation_cubit.dart';

List<BottomNavigationBarItem> listNavigationBar = const [
  BottomNavigationBarItem(icon: Icon(Icons.calculate), label: ''),
  BottomNavigationBarItem(icon: Icon(Icons.run_circle), label: ''),
  BottomNavigationBarItem(icon: Icon(Icons.watch_later_outlined), label: ''),
  BottomNavigationBarItem(icon: Icon(Icons.list_alt_rounded), label: ''),
  BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
];

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(20)),
        child: BlocConsumer<PageViewBootomNavigationCubit,
            PageViewBootomNavigationState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is PageViewIndex) {
              return BottomNavigationBar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  type: BottomNavigationBarType.fixed,
                  currentIndex: state.index,
                  onTap: (index) {
                    BlocProvider.of<PageViewBootomNavigationCubit>(context)
                        .pageViewIndex(index);
                  },
                  elevation: 2,
                  iconSize: 35,
                  unselectedItemColor:
                      Theme.of(context).colorScheme.outlineVariant,
                  selectedItemColor: Theme.of(context).colorScheme.onPrimary,
                  items: listNavigationBar);
            } else {
              return const SizedBox();
            }
          },
        ));
  }
}
