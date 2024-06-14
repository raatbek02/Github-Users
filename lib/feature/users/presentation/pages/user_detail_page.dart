import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_users/core/common/widgets/loader.dart';
import 'package:github_users/feature/users/domain/entities/user_detail_entity.dart';
import 'package:github_users/feature/users/domain/entities/users_entity.dart';
import 'package:github_users/feature/users/presentation/bloc/user_detail_bloc/user_detail_bloc.dart';
import 'package:github_users/feature/users/presentation/bloc/user_detail_bloc/user_detail_event.dart';
import 'package:github_users/feature/users/presentation/bloc/user_detail_bloc/user_detail_state.dart';
import 'package:github_users/generated/l10n.dart';
import 'package:translit/translit.dart';

class UserDetailPage extends StatefulWidget {
  final UsersEntity user;

  const UserDetailPage({super.key, required this.user});

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<UserDetailBloc>().add(UserDetailFetch(link: widget.user.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<UserDetailBloc, UserDetailState>(
        listener: (context, state) {
          if (state is UserDetailFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          if (state is UserDetailLoading) {
            return const Loader();
          }
          if (state is UserDetailDisplaySuccess) {
            return _buildUserDetail(context, state.userDetail);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildUserDetail(BuildContext context, UserDetailEntity userDetail) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 300,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            background: _buildBackgroundImage(userDetail.avatarUrl),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildUserName(userDetail.name),
                const SizedBox(height: 8),
                _buildUserBio(userDetail.bio),
                const SizedBox(height: 16),
                _buildUserDetailsCard(context, userDetail),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBackgroundImage(String avatarUrl) {
    return Image.network(
      avatarUrl,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return const Center(child: Icon(Icons.error));
      },
    );
  }

  Widget _buildUserName(String? name) {
    final translit = Translit();
    final locale = Localizations.localeOf(context).languageCode;
    final displayName = (locale == 'ru' && name != null)
        ? translit.unTranslit(source: name)
        : (name ?? S.of(context).unknown);

    return Text(
      displayName,
      style: const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget _buildUserBio(String? bio) {
    return Text(
      bio ?? '',
      style: TextStyle(
        fontSize: 16,
        color: Colors.grey[600],
      ),
    );
  }

  Widget _buildUserDetailsCard(
      BuildContext context, UserDetailEntity userDetail) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildDetailItem(
              icon: Icons.location_on,
              label: S.of(context).location,
              text: userDetail.location ?? '-',
            ),
            _buildDetailItem(
              icon: Icons.link,
              label: S.of(context).blog,
              text: userDetail.blog ?? '-',
            ),
            _buildDetailItem(
              icon: Icons.work,
              label: S.of(context).company,
              text: userDetail.company ?? '-',
            ),
            _buildDetailItem(
              icon: Icons.person,
              label: S.of(context).userType,
              text: userDetail.type,
            ),
            const Divider(),
            _buildFollowersAndFollowing(context, userDetail),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem({
    required IconData icon,
    required String label,
    required String text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 24),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFollowersAndFollowing(
      BuildContext context, UserDetailEntity userDetail) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            const Icon(Icons.people, size: 24),
            const SizedBox(height: 4),
            Text(
              '${userDetail.followers}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              S.of(context).followers,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ],
        ),
        Column(
          children: [
            const Icon(Icons.person_add, size: 24),
            const SizedBox(height: 4),
            Text(
              '${userDetail.following}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              S.of(context).following,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
