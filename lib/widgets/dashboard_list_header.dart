import 'package:flutter/material.dart';

import '../widgets/label_filter_dropdown.dart';

// Used in DashboardScreen. Contains History text and dropdown filter.

class DashboardListHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SectionHeaderDelegate(
        child: Container(
          // Need to specify the color or it'll be transparent.
          color: Colors.white,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      'History',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                    LabelFilterDropdown(),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              // Psuedo-shadow.
              const Divider(
                height: 0,
                thickness: 1.5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SectionHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;

  const SectionHeaderDelegate({
    @required this.child,
    // This is the height of the child.
    this.height = 58,
  });

  @override
  Widget build(BuildContext context, _, __) {
    return child;
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(_) => false;
}
