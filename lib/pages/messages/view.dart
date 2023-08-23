import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sora/pages/card_message/card_message.dart';
import 'package:sora/pages/messages/view_model.dart';

class MessagesPage extends HookConsumerWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(messagesPageViewModelProvider);
    final messages = model.messages;

    return Scaffold(
      appBar: AppBar(
        title: const Text('メッセージ'),
      ),
      body: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final message = messages[index];
          if (message == null) {
            return const SizedBox.shrink();
          }

          final iconUrl = message.senderIconUrl;

          return Slidable(
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              dismissible: DismissiblePane(onDismissed: () {
                // Handle dismiss action here
              }),
              children: [
                SlidableAction(
                  onPressed: (context) {},
                  backgroundColor: const Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
              ],
            ),
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {},
                  backgroundColor: Color(0xFF0392CF),
                  foregroundColor: Colors.white,
                  icon: Icons.save,
                  label: 'Save',
                ),
              ],
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CardMessage(message: message),
                  ),
                );
              },
              child: ListTile(
                leading: iconUrl != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          iconUrl,
                          width: 40,
                          height: 40,
                        ),
                      )
                    : null,
                title: Text(message.senderName),
                subtitle: Text(message.createdAt.toDate().toIso8601String()),
              ),
            ),
          );
        },
      ),
    );
  }
}
