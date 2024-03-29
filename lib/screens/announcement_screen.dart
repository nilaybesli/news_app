import 'package:flutter/material.dart';

import '../models/announcement.dart';
import '../widgets/announce_item.dart';

class AnnouncementScreen extends StatelessWidget {
  const AnnouncementScreen({super.key, required this.announce, this.title});

  final String? title;
  final List<Announcement> announce;

  @override
  Widget build(BuildContext context) {

    Widget content = ListView.builder(
      itemCount: announce.length,
      itemBuilder: (ctx, index) => AnnounceItem(
        announcement: announce[index],
      ),
    );

    if (announce.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Uh oh ... Nothing here!",
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "Try selecting different category",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
          ],
        ),
      );
    }

    if (title == null) {
      return content;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
