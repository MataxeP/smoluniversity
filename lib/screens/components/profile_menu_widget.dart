import 'package:flutter/material.dart';

class ProfileMenuWidget extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  const ProfileMenuWidget({
    Key? key,
    required this.color,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: color,
            ),
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          const SizedBox(
            width: 50,
            height: 50,
            child: Icon(Icons.arrow_forward),
          )
        ],
      ),
    );
  }
}
