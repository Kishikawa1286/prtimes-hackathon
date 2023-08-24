import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sora/pages/messages/view_model.dart';

class MessagesPage extends HookConsumerWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(messagesPageViewModelProvider);
    final messages = model.messages;
    final viewModel = ref.read(messagesPageViewModelProvider.notifier);

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

          // If we're at the last message, fetch more messages
          if (index == messages.length - 1) {
            viewModel.fetchMoreMessages();
          }

          final iconUrl = message.senderIconUrl;
          return ExpansionTile(
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
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(message.summary),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(message.message),
              ),
            ],
          );
        },
      ),
    );
  }
}
