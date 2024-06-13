import 'package:flutter/material.dart';
import 'package:github_users/feature/users/domain/entities/users_entity.dart';
import 'package:github_users/feature/users/presentation/pages/user_detail_page.dart';
import 'package:github_users/feature/users/presentation/widgets/user_cache_image.dart';

class SearchResult extends StatelessWidget {
  final UsersEntity userResult;

  const SearchResult({super.key, required this.userResult});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserDetailPage(user: userResult),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 2.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: PersonCacheImage(
                imageUrl: userResult.avatarUrl,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                userResult.login,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                userResult.login,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
