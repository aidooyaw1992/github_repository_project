import 'package:flutter/material.dart';
import 'package:github_repository_project/src/ui/components/fork_count_widget.dart';
import 'package:github_repository_project/src/ui/components/profile_widget.dart';
import 'package:github_repository_project/src/ui/components/star_gazer_widget.dart';
import 'package:intl/intl.dart' as intl;
import 'package:url_launcher/url_launcher.dart';
import '../../domain/details_screen_argument/details_screen_argument.dart';

class RepositoryDetailsPage extends StatelessWidget {
  final DetailsScreenArgument argument;
  const RepositoryDetailsPage({super.key, required this.argument});

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(title: Text("Repository Details")),
      body: Container(
        height: deviceSize.height,
        width: deviceSize.width,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4,
            children: [
              Text(
                argument.repository.name,
                style: TextStyle(fontSize: 16, color: Colors.blue.shade800),
              ),
              SizedBox.fromSize(size: Size.fromHeight(16)),
              Text(argument.repository.fullName),
              SizedBox.fromSize(size: Size.fromHeight(2)),
              Text(
                "Description:",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              Text(argument.repository.description ?? "No Description"),
              SizedBox.fromSize(size: Size.fromHeight(2)),
              Text(
                "Date Created:",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              Text(_formatDateWithOrdinal(argument.repository.createdAt)),
              Text("Owner:", style: TextStyle(fontWeight: FontWeight.w700)),
              ProfileWidget(
                avatarUrl: argument.repository.owner.avatarUrl,
                customSize: 54,
              ),
              Text(argument.repository.owner.login),
              SizedBox.fromSize(size: Size.fromHeight(2)),
              Text("Stars:", style: TextStyle(fontWeight: FontWeight.w700)),
              Row(
                children: [
                  StarGazerWidget(
                    starCount: argument.repository.stargazersCount,
                  ),
                ],
              ),
              SizedBox.fromSize(size: Size.fromHeight(2)),
              Text("Forks:", style: TextStyle(fontWeight: FontWeight.w700)),
              Row(
                children: [
                  ForkCountWidget(
                    forkCount: argument.repository.stargazersCount,
                  ),
                ],
              ),
              SizedBox.fromSize(size: Size.fromHeight(8)),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(deviceSize.width * 0.95, 50),
                  backgroundColor: Colors.white
                ),
                onPressed: () {
                  _launchURL(argument.repository.htmlUrl);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Open Github Link"),
                    Image.asset(
                      'assets/images/github_logo.png',
                      width: 32,
                      height: 32,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
  final Uri uri = Uri.parse(url);
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch $url');
  }
}

  String _formatDateWithOrdinal(DateTime date) {
    final day = date.day;
    final month = intl.DateFormat('MMMM').format(date);
    final year = date.year;
    final ordinalSuffix = _getOrdinalSuffix(day);

    return '$day$ordinalSuffix $month, $year';
  }

  // Get ordinal suffix (st, nd, rd, th)
  String _getOrdinalSuffix(int day) {
    if (day >= 11 && day <= 13) return 'th';

    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }
}
