import 'package:flutter/material.dart';
import '../models/member.dart';
import '../services/auth_service.dart';
import '../services/storage_service.dart';

class MemberListScreen extends StatefulWidget {
  const MemberListScreen({
    super.key,
    required this.mode,
  });

  final AppMode mode;

  @override
  State<MemberListScreen> createState() => _MemberListScreenState();
}

class _MemberListScreenState extends State<MemberListScreen> {
  final _storageService = StorageService();
  final _authService = AuthService();
  final _searchController = TextEditingController();
  List<Member> _members = [];
  List<Member> _filteredMembers = [];
  bool _isLoading = true;
  bool _isSearchActive = false;

  @override
  void initState() {
    super.initState();
    _loadMembers();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadMembers() async {
    setState(() {
      _isLoading = true;
    });

    final members = await _storageService.getAllMembers();
    setState(() {
      _members = members;
      _filteredMembers = members;
      _isLoading = false;
    });
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _isSearchActive = query.isNotEmpty;
      if (query.isEmpty) {
        _filteredMembers = _members;
      } else {
        _filteredMembers = _members.where((member) {
          return member.name.toLowerCase().contains(query) ||
                 member.company.toLowerCase().contains(query) ||
                 member.department.toLowerCase().contains(query) ||
                 member.email.toLowerCase().contains(query) ||
                 member.phone.contains(query);
        }).toList();
      }
    });
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _isSearchActive = false;
      _filteredMembers = _members;
    });
  }


  Future<void> _deleteMember(Member member) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('削除確認'),
        content: Text('${member.name}を削除しますか？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('削除'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await _storageService.deleteMember(member.id);
      _loadMembers();
    }
  }

  void _editMember(Member? member) {
    Navigator.of(context).pushNamed(
      '/edit',
      arguments: member,
    ).then((_) => _loadMembers());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mode == AppMode.view ? '名簿一覧' : '名簿編集'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _members.isEmpty
              ? const Center(
                  child: Text('メンバーが登録されていません'),
                )
              : ListView.builder(
                  itemCount: _members.length,
                  itemBuilder: (context, index) {
                    final member = _members[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      child: ListTile(
                        title: Text(member.name),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(member.company, 
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.blue[700],
                              ),
                            ),
                            Text('${member.department} | ${member.email}'),
                            Text(member.phone),
                          ],
                        ),
                        trailing: widget.mode == AppMode.edit
                            ? PopupMenuButton<String>(
                                onSelected: (value) {
                                  if (value == 'edit') {
                                    _editMember(member);
                                  } else if (value == 'delete') {
                                    _deleteMember(member);
                                  }
                                },
                                itemBuilder: (context) => [
                                  const PopupMenuItem(
                                    value: 'edit',
                                    child: Row(
                                      children: [
                                        Icon(Icons.edit),
                                        SizedBox(width: 8),
                                        Text('編集'),
                                      ],
                                    ),
                                  ),
                                  const PopupMenuItem(
                                    value: 'delete',
                                    child: Row(
                                      children: [
                                        Icon(Icons.delete),
                                        SizedBox(width: 8),
                                        Text('削除'),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : null,
                        onTap: widget.mode == AppMode.edit
                            ? () => _editMember(member)
                            : null,
                      ),
                    );
                  },
                ),
      floatingActionButton: widget.mode == AppMode.edit
          ? FloatingActionButton(
              onPressed: () => _editMember(null),
              tooltip: '新規追加',
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}