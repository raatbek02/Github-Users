import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            return const Center(child: CircularProgressIndicator());
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
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  text,
                  style: const TextStyle(fontSize: 16),
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
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(
              S.of(context).followers,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
        Column(
          children: [
            const Icon(Icons.person_add, size: 24),
            const SizedBox(height: 4),
            Text(
              '${userDetail.following}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(
              S.of(context).following,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }
}


// class UserDetailPage extends StatefulWidget {
//   final UsersEntity user;

//   const UserDetailPage({super.key, required this.user});

//   @override
//   State<UserDetailPage> createState() => _UserDetailPageState();
// }

// class _UserDetailPageState extends State<UserDetailPage> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<UserDetailBloc>().add(UserDetailFetch(link: widget.user.url));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       body: BlocConsumer<UserDetailBloc, UserDetailState>(
//         listener: (context, state) {
//           if (state is UserDetailFailure) {
//             // showSnackBar(context, state.error);
//             print("Failure");
//           }
//         },
//         builder: (context, state) {
//           if (state is UserDetailLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (state is UserDetailDisplaySuccess) {
//             return _buildPersonDetail(context, state.userDetail);
//           }
//           return const SizedBox.shrink();
//         },
//       ),
//     );
//   }

//   Widget _buildPersonDetail(
//       BuildContext context, UserDetailEntity personDetail) {
//     return Stack(
//       children: [
//         _buildBackgroundImage(context, personDetail.avatarUrl),
//         SingleChildScrollView(
//           padding: const EdgeInsets.only(top: 300),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 16),
//               _buildPersonName(personDetail.name),
//               const SizedBox(height: 8),
//               _buildPersonBio(personDetail.bio),
//               const SizedBox(height: 16),
//               _buildPersonDetailsCard(context, personDetail),
//               const SizedBox(height: 16),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildBackgroundImage(BuildContext context, String avatarUrl) {
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.5,
//       decoration: BoxDecoration(
//         image: DecorationImage(
//           image: NetworkImage(avatarUrl),
//           fit: BoxFit.cover,
//         ),
//       ),
//       child: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.bottomCenter,
//             end: Alignment.topCenter,
//             colors: [
//               Colors.black.withOpacity(0.8),
//               Colors.transparent,
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildPersonName(String? name) {
//     final translit = Translit();

//     // Определение текущего языка
//     final locale = Localizations.localeOf(context).languageCode;

//     // Если язык русский, транслитерировать имя
//     final displayName = (locale == 'ru' && name != null)
//         ? translit.unTranslit(source: name)
//         : (name ?? S.of(context).unknown);

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Text(
//         displayName,
//         style: const TextStyle(
//           fontSize: 28,
//           color: Colors.white,
//           fontWeight: FontWeight.w700,
//         ),
//       ),
//     );
//   }

//   Widget _buildPersonBio(String? bio) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Text(
//         bio ?? "",
//         style: TextStyle(
//           fontSize: 16,
//           color: Colors.grey[400],
//         ),
//       ),
//     );
//   }

//   Widget _buildPersonDetailsCard(
//       BuildContext context, UserDetailEntity personDetail) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16),
//       decoration: BoxDecoration(
//         color: Colors.grey[900],
//         borderRadius: BorderRadius.circular(8),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.2),
//             blurRadius: 4,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           _buildDetailListTile(
//             icon: Icons.location_on,
//             text: personDetail.location ?? "",
//           ),
//           _buildDivider(),
//           _buildDetailListTile(
//             icon: Icons.link,
//             text: personDetail.blog ?? "",
//           ),
//           _buildDivider(),
//           _buildDetailListTile(
//             icon: Icons.work,
//             text: personDetail.company ?? "",
//           ),
//           _buildDivider(),
//           _buildDetailListTile(
//             icon: Icons.person,
//             text: personDetail.type,
//           ),
//           _buildDivider(),
//           _buildFollowersAndFollowing(context, personDetail),
//         ],
//       ),
//     );
//   }

//   Widget _buildDetailListTile({required IconData icon, required String text}) {
//     return ListTile(
//       leading: Icon(icon, color: Colors.grey[400]),
//       title: Text(
//         text,
//         style: TextStyle(color: Colors.grey[400]),
//       ),
//     );
//   }

//   Widget _buildDivider() {
//     return Divider(height: 1, color: Colors.grey[700]);
//   }

//   Widget _buildFollowersAndFollowing(
//       BuildContext context, UserDetailEntity personDetail) {
//     return ListTile(
//       leading: Icon(Icons.people, color: Colors.grey[400]),
//       title: Text(
//         "${personDetail.followers} ${S.of(context).followers}",
//         style: TextStyle(color: Colors.grey[400], fontSize: 14),
//       ),
//       trailing: Text(
//         "${personDetail.following} ${S.of(context).following}",
//         style: TextStyle(color: Colors.grey[400], fontSize: 14),
//       ),
//     );
//   }
// }

// class UserDetailPage extends StatefulWidget {
//   final UsersEntity user;

//   const UserDetailPage({super.key, required this.user});

//   @override
//   State<UserDetailPage> createState() => _UserDetailPageState();
// }

// class _UserDetailPageState extends State<UserDetailPage> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<UserDetailBloc>().add(UserDetailFetch(link: widget.user.url));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       body: BlocConsumer<UserDetailBloc, UserDetailState>(
//         listener: (context, state) {
//           if (state is UserDetailFailure) {
//             // showSnackBar(context, state.error);
//             print("Failure");
//           }
//         },
//         builder: (context, state) {
//           if (state is UserDetailLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (state is UserDetailDisplaySuccess) {
//             return _buildPersonDetail(context, state.userDetail);
//           }
//           return const SizedBox.shrink();
//         },
//       ),
//     );
//   }

//   Widget _buildPersonDetail(
//       BuildContext context, UserDetailEntity personDetail) {
//     return Stack(
//       children: [
//         _buildBackgroundImage(context, personDetail.avatarUrl),
//         SingleChildScrollView(
//           padding: const EdgeInsets.only(top: 300),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 16),
//               _buildPersonName(personDetail.name),
//               const SizedBox(height: 8),
//               _buildPersonBio(personDetail.bio),
//               const SizedBox(height: 16),
//               _buildPersonDetailsCard(context, personDetail),
//               const SizedBox(height: 16),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildBackgroundImage(BuildContext context, String avatarUrl) {
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.5,
//       decoration: BoxDecoration(
//         image: DecorationImage(
//           image: NetworkImage(avatarUrl),
//           fit: BoxFit.cover,
//         ),
//       ),
//       child: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.bottomCenter,
//             end: Alignment.topCenter,
//             colors: [
//               Colors.black.withOpacity(0.8),
//               Colors.transparent,
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildPersonName(String? name) {
//     final translit = Translit();

//     // Определение текущего языка
//     final locale = Localizations.localeOf(context).languageCode;

//     // Если язык русский, транслитерировать имя
//     final displayName = (locale == 'ru' && name != null)
//         ? translit.unTranslit(source: name)
//         : (name ?? S.of(context).unknown);

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Text(
//         displayName,
//         style: const TextStyle(
//           fontSize: 28,
//           color: Colors.white,
//           fontWeight: FontWeight.w700,
//         ),
//       ),
//     );
//   }

//   Widget _buildPersonBio(String? bio) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Text(
//         bio ?? "",
//         style: TextStyle(
//           fontSize: 16,
//           color: Colors.grey[400],
//         ),
//       ),
//     );
//   }

//   Widget _buildPersonDetailsCard(
//       BuildContext context, UserDetailEntity personDetail) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16),
//       decoration: BoxDecoration(
//         color: Colors.grey[900],
//         borderRadius: BorderRadius.circular(8),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.2),
//             blurRadius: 4,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           _buildDetailItem(
//             icon: Icons.location_on,
//             label: S.of(context).location,
//             text: personDetail.location ?? "",
//           ),
//           _buildDivider(),
//           _buildDetailItem(
//             icon: Icons.link,
//             label: S.of(context).blog,
//             text: personDetail.blog ?? "",
//           ),
//           _buildDivider(),
//           _buildDetailItem(
//             icon: Icons.work,
//             label: S.of(context).company,
//             text: personDetail.company ?? "",
//           ),
//           _buildDivider(),
//           _buildDetailItem(
//             icon: Icons.person,
//             label: S.of(context).userType,
//             text: personDetail.type,
//           ),
//           _buildDivider(),
//           _buildFollowersAndFollowing(context, personDetail),
//         ],
//       ),
//     );
//   }

//   Widget _buildDetailItem({
//     required IconData icon,
//     required String label,
//     required String text,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//       child: Row(
//         children: [
//           Icon(icon, color: Colors.grey[400]),
//           const SizedBox(width: 8),
//           Text(
//             '${label}: ',
//             style: TextStyle(color: Colors.grey[400], fontSize: 14),
//           ),
//           const SizedBox(width: 8),
//           Expanded(
//             child: Text(
//               text,
//               style: TextStyle(color: Colors.grey[400]),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDivider() {
//     return Divider(height: 1, color: Colors.grey[700]);
//   }

//   Widget _buildFollowersAndFollowing(
//       BuildContext context, UserDetailEntity personDetail) {
//     return ListTile(
//       leading: Icon(Icons.people, color: Colors.grey[400]),
//       title: Text(
//         "${personDetail.followers} ${S.of(context).followers}",
//         style: TextStyle(color: Colors.grey[400], fontSize: 14),
//       ),
//       trailing: Text(
//         "${personDetail.following} ${S.of(context).following}",
//         style: TextStyle(color: Colors.grey[400], fontSize: 14),
//       ),
//     );
//   }
// }

