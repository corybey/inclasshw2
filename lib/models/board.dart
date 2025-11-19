//home page boards

class Board {
  final String id;
  final String name;
  final String description;
  final String icon; // using emoji for simplicity

  const Board({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
  });
}

// Hard-coded boards
const List<Board> kBoards = [
  Board(
    id: 'general',
    name: 'General',
    description: 'General discussion for everyone',
    icon: '💬',
  ),
  Board(
    id: 'homework',
    name: 'Homework Help',
    description: 'Ask questions about assignments',
    icon: '📚',
  ),
  Board(
    id: 'announcements',
    name: 'Announcements',
    description: 'Important updates and news',
    icon: '📢',
  ),
];
