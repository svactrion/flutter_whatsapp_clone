import 'package:flutter/material.dart';

class ChatItem extends StatelessWidget {
  /// [avatarPathOrUrl] can be an asset path (e.g. 'assets/images/avatar.png')
  /// or a network URL (e.g. 'https://example.com/avatar.jpg').
  final String avatarPathOrUrl;
  final String name;
  final String message;
  final String time;

  const ChatItem({
    Key? key,
    required this.avatarPathOrUrl,
    required this.name,
    required this.message,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determine image provider based on prefix
    final ImageProvider avatarImage =
        avatarPathOrUrl.startsWith('http')
            ? NetworkImage(avatarPathOrUrl)
            : AssetImage(avatarPathOrUrl) as ImageProvider;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(backgroundImage: avatarImage, radius: 25),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(time, style: TextStyle(color: Colors.grey[500], fontSize: 12)),
        ],
      ),
    );
  }
}
