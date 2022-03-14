import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  const LoadingContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: _buildContainer(),
          subtitle: _buildContainer(),
        ),
        const Divider(
          height: 8.0,
        )
      ],
    );
  }

  Widget _buildContainer() {
    return Container(
      color: Colors.grey.shade200,
      height: 24,
      width: 150,
      margin: const EdgeInsets.only(
        top: 5.0,
        bottom: 5.0,
      ),
    );
  }
}
