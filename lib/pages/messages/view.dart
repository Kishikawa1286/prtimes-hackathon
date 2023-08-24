import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:sora/pages/card_messages/view.dart';
import 'package:sora/pages/messages/view_model.dart';

class MessagesPage extends HookConsumerWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(messagesPageViewModelProvider);
    final messages = model.messages;

  String formatWithWeekday(DateTime date) {
    final now = DateTime.now();
    final weekdays = ['月', '火', '水', '木', '金', '土', '日'];
    final weekday = weekdays[
        date.weekday - 1]; // DateTimeのweekdayは1から7の値を返すため、-1して配列のインデックスとして使用

    // 午前 or 午後の判断
    final ampm = date.hour < 12 ? '午前' : '午後';

    // 午前・午後表示のための時間調整（13時以降は1から数える）
    final adjustedHour = date.hour <= 12 ? date.hour : date.hour - 12;

    // 今日の日付と指定された日付が同じであるかどうかを確認
    if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day) {
      return '$ampm $adjustedHour:${date.minute.toString().padLeft(2, '0')}';
    } else {
      return '${date.month}/${date.day}($weekday)';
  }
}


    if (messages.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('メッセージ'),
        ),
        body: const Center(child: Text('メッセージがありません')), // メッセージがない場合の表示
      );
    }

    return Scaffold(//全体
      appBar: AppBar(//header
        title: Row(
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.symmetric(horizontal: 24),
                ),
              ),
              child: const Text('All', style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.symmetric(horizontal: 24),
                ),
              ),
              child: const Text('Slack', style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.symmetric(horizontal: 24),
                ),
              ),
              child: const Text('LINE', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
      body: ListView.builder(//中身
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final message = messages[index];
          if (message == null) {
            return const SizedBox.shrink();
          }

          final iconUrl = message.senderIconUrl;

          return Slidable(//スライド部分
            key: ValueKey(index),
            startActionPane: ActionPane(
              extentRatio: 0.2,
              motion: const ScrollMotion(),
              dismissible: DismissiblePane(onDismissed: () {
                // Handle dismiss action here
              }),
              children: [
                SlidableAction(
                  onPressed: (context) async {},
                  backgroundColor: const Color.fromARGB(255, 0, 149, 255),
                  foregroundColor: Colors.white,
                  icon: Icons.thumb_down,
                  label: 'bad',
                ),
              ],
            ),
            endActionPane: ActionPane(
              extentRatio: 0.2,
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {},
                  backgroundColor: const Color.fromARGB(255, 255, 115, 0),
                  foregroundColor: Colors.white,
                  icon: Icons.thumb_up,
                  label: 'good',
                ),
              ],
            ),
            child: ListTile(//中身
              leading: iconUrl != null
                  ? ClipRRect(//アイコン
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        iconUrl,
                        width: 56,
                        height: 56,
                      ),
                    )
                  : null,
              title: Row(
                children: [
                  Text(message.senderName,style: const TextStyle(fontSize: 16)),
                  const Expanded(child: SizedBox()),
                  Text(formatWithWeekday(message.createdAt.toDate()),style: const TextStyle(fontSize: 12)),
                ],
              ),
              subtitle: Text(message.summary,style: const TextStyle(fontSize: 16)),
            ),
          );
        },
      ),
    );
  }
}
