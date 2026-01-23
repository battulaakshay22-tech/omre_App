import 'dart:math';

class MockPost {
  final String id;
  final String username;
  final String avatarUrl;
  final String imageUrl;
  final String caption;
  final int likes;
  final String timestamp;

  MockPost({
    required this.id,
    required this.username,
    required this.avatarUrl,
    required this.imageUrl,
    required this.caption,
    required this.likes,
    required this.timestamp,
  });
}

class MockStory {
  final String id;
  final String username;
  final String avatarUrl;
  final bool isMe;

  MockStory({
    required this.id,
    required this.username,
    required this.avatarUrl,
    this.isMe = false,
  });
}

class MockChat {
  final String id;
  final String name;
  final String avatarUrl;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final String category;

  MockChat({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.lastMessage,
    required this.time,
    required this.unreadCount,
    required this.category,
  });
}

class MockCourse {
  final String id;
  final String title;
  final String instructor;
  final String price;
  final String thumbnail;

  MockCourse({
    required this.id,
    required this.title,
    required this.instructor,
    required this.price,
    required this.thumbnail,
  });
}

class MockService {
  static final List<MockCourse> courses = [
    MockCourse(id: 'c1', title: 'Modern UI/UX Design', instructor: 'Sarah Jenkins', price: '\$49.99', thumbnail: 'https://picsum.photos/seed/course1/400/250'),
    MockCourse(id: 'c2', title: 'Advanced Flutter Dev', instructor: 'Marcus Aurelius', price: 'Free', thumbnail: 'https://picsum.photos/seed/course2/400/250'),
    MockCourse(id: 'c3', title: 'Motion Graphics 101', instructor: 'Elena Fisher', price: '\$29.99', thumbnail: 'https://picsum.photos/seed/course3/400/250'),
    MockCourse(id: 'c4', title: 'Product Management', instructor: 'Ken Robinson', price: '\$59.00', thumbnail: 'https://picsum.photos/seed/course4/400/250'),
  ];
  static final List<MockPost> posts = List.generate(10, (index) => MockPost(
    id: 'post_$index',
    username: 'user_$index',
    avatarUrl: 'https://i.pravatar.cc/150?u=user_$index',
    imageUrl: 'https://picsum.photos/seed/post$index/600/600',
    caption: 'This is a beautiful day at index $index!',
    likes: Random().nextInt(1000),
    timestamp: '${index + 1}h ago',
  ));

  static final List<MockStory> stories = [
    MockStory(id: 'me', username: 'Your Story', avatarUrl: 'https://i.pravatar.cc/150?u=me', isMe: true),
    ...List.generate(8, (index) => MockStory(
      id: 'story_$index',
      username: 'friend_$index',
      avatarUrl: 'https://i.pravatar.cc/150?u=friend_$index',
    )),
  ];

  static final List<MockChat> chats = [
    MockChat(id: '1', name: 'Jordan Smith', avatarUrl: 'https://i.pravatar.cc/150?u=jordan', lastMessage: 'Hey Alex, got a minute?', time: '5:08 PM', unreadCount: 3, category: 'Private'),
    MockChat(id: '2', name: 'Flutter Devs', avatarUrl: 'https://i.pravatar.cc/150?u=devs', lastMessage: 'New release is out! 🚀', time: '4:30 PM', unreadCount: 12, category: 'Pulse'),
    MockChat(id: '3', name: 'Weekend Trip', avatarUrl: 'https://i.pravatar.cc/150?u=trip', lastMessage: 'Who is bringing the snacks?', time: '4:15 PM', unreadCount: 5, category: 'Social'),
    MockChat(id: '4', name: 'Avery Johnson', avatarUrl: 'https://i.pravatar.cc/150?u=avery', lastMessage: 'Sounds good, let\'s talk later!', time: '4:08 PM', unreadCount: 0, category: 'Private'),
    MockChat(id: '5', name: 'Casey Williams', avatarUrl: 'https://i.pravatar.cc/150?u=casey', lastMessage: 'Did you see the new design?', time: '3:08 PM', unreadCount: 1, category: 'Private'),
    MockChat(id: '6', name: 'Tech Talk Global', avatarUrl: 'https://i.pravatar.cc/150?u=tech', lastMessage: 'AI is taking over!', time: '2:45 PM', unreadCount: 99, category: 'Pulse'),
    MockChat(id: '7', name: 'Family Group', avatarUrl: 'https://i.pravatar.cc/150?u=family', lastMessage: 'Happy Birthday! 🎂', time: '1:00 PM', unreadCount: 2, category: 'Social'),
    MockChat(id: '8', name: 'Taylor Brown', avatarUrl: 'https://i.pravatar.cc/150?u=taylor', lastMessage: 'Meeting confirmed.', time: '2:08 PM', unreadCount: 0, category: 'Private'),
    MockChat(id: '9', name: 'Riley Garcia', avatarUrl: 'https://i.pravatar.cc/150?u=riley', lastMessage: 'On my way!', time: '1:08 PM', unreadCount: 0, category: 'Private'),
    MockChat(id: '10', name: 'Crypto News', avatarUrl: 'https://i.pravatar.cc/150?u=crypto', lastMessage: 'Bitcoin hits new ATH!', time: '11:30 AM', unreadCount: 0, category: 'Pulse'),
    MockChat(id: '11', name: 'Book Club', avatarUrl: 'https://i.pravatar.cc/150?u=book', lastMessage: 'Next book is "Dune".', time: '10:15 AM', unreadCount: 0, category: 'Social'),
  ];

  static List<MockMessage> getMessages(String chatId) {
    // Generate some random messages for demo
    return List.generate(15, (index) {
      final isMe = index % 2 == 0;
      return MockMessage(
        id: 'msg_$index',
        text: isMe ? 'This is a message from me ($index)' : 'This is a reply from the other person ($index)',
        isMe: isMe,
        timestamp: '10:${index.toString().padLeft(2, '0')}',
      );
    }).reversed.toList();
  }
}

class MockMessage {
  final String id;
  final String text;
  final bool isMe;
  final String timestamp;

  MockMessage({
    required this.id,
    required this.text,
    required this.isMe,
    required this.timestamp,
  });
}
