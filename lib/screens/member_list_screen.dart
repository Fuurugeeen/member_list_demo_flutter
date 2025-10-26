import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../models/member.dart';
import '../services/auth_service.dart';
import '../services/storage_service.dart';
import '../theme/business_theme.dart';

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
  String _version = '';

  @override
  void initState() {
    super.initState();
    _loadMembers();
    _loadVersion();
    _searchController.addListener(_onSearchChanged);
  }

  Future<void> _loadVersion() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      setState(() {
        _version = 'v${packageInfo.version}';
      });
      print('Version loaded: $_version'); // デバッグ用
    } catch (e) {
      print('Error loading version: $e'); // デバッグ用
      // エラーの場合でもバージョンを表示
      setState(() {
        _version = 'v1.0.0';
      });
    }
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
    Navigator.of(context)
        .pushNamed(
          '/edit',
          arguments: member,
        )
        .then((_) => _loadMembers());
  }

  Widget _buildMemberCard(Member member) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: widget.mode == AppMode.edit ? () => _editMember(member) : null,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: BusinessTheme.mobileCardPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      member.name,
                      style: BusinessTheme.memberNameStyle,
                    ),
                  ),
                  if (widget.mode == AppMode.edit)
                    PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'edit') {
                          _editMember(member);
                        } else if (value == 'delete') {
                          _deleteMember(member);
                        }
                      },
                      icon: Icon(
                        Icons.more_vert,
                        size: 24,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'edit',
                          child: Row(
                            children: [
                              Icon(Icons.edit_outlined, size: 20),
                              SizedBox(width: 12),
                              Text('編集'),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete_outlined, size: 20),
                              SizedBox(width: 12),
                              Text('削除'),
                            ],
                          ),
                        ),
                      ],
                    ),
                ],
              ),
              const SizedBox(height: BusinessTheme.mobileElementSpacing),
              Text(
                member.company,
                style: BusinessTheme.memberCompanyStyle,
              ),
              const SizedBox(height: 6),
              Text(
                member.department,
                style: BusinessTheme.memberDepartmentStyle,
              ),
              const SizedBox(height: BusinessTheme.mobileCardSpacing),
              Row(
                children: [
                  Icon(
                    Icons.email_outlined,
                    size: BusinessTheme.mobileIconSize,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      member.email,
                      style: BusinessTheme.memberContactStyle,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.phone_outlined,
                    size: BusinessTheme.mobileIconSize,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    member.phone,
                    style: BusinessTheme.memberContactStyle,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.mode == AppMode.view ? '名簿一覧' : '名簿編集'),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                _version.isEmpty ? 'v1.0.0' : _version,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await _authService.logout(widget.mode);
              if (mounted && context.mounted) {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/', (route) => false);
              }
            },
            icon: const Icon(Icons.logout),
            tooltip: 'ログアウト',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : CustomScrollView(
              slivers: [
                // 検索バー（スティッキーヘッダー）
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _SearchBarDelegate(
                    isSearchActive: _isSearchActive,
                    filteredCount: _filteredMembers.length,
                    child: Container(
                      color: Theme.of(context).colorScheme.surface,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: BusinessTheme.mobileSearchPadding,
                            child: TextField(
                              controller: _searchController,
                              style: const TextStyle(fontSize: 16),
                              decoration: InputDecoration(
                                hintText: '名前、会社名、部署、メール、電話番号で検索...',
                                hintStyle: BusinessTheme.searchHintStyle,
                                prefixIcon: Icon(
                                  Icons.search,
                                  size: BusinessTheme.mobileIconSize,
                                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                                ),
                                suffixIcon: _isSearchActive
                                    ? IconButton(
                                        onPressed: _clearSearch,
                                        icon: const Icon(
                                          Icons.clear,
                                          size: BusinessTheme.mobileIconSize,
                                        ),
                                        tooltip: '検索をクリア',
                                      )
                                    : null,
                              ),
                            ),
                          ),
                          // 検索結果の件数表示
                          if (_isSearchActive)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.search_outlined,
                                    size: 18,
                                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '${_filteredMembers.length}件の検索結果',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurfaceVariant,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                // メンバーリスト
                if (_members.isEmpty)
                  SliverFillRemaining(
                    child: Center(
                      child: Text('メンバーが登録されていません'),
                    ),
                  )
                else if (_filteredMembers.isEmpty)
                  SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 64,
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            '検索結果が見つかりません',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                                ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '他のキーワードで検索してみてください',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                                ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final member = _filteredMembers[index];
                        return _buildMemberCard(member);
                      },
                      childCount: _filteredMembers.length,
                    ),
                  ),
              ],
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

// スティッキーヘッダー用のデリゲートクラス
class _SearchBarDelegate extends SliverPersistentHeaderDelegate {
  _SearchBarDelegate({
    required this.child,
    required this.isSearchActive,
    required this.filteredCount,
  });

  final Widget child;
  final bool isSearchActive;
  final int filteredCount;

  @override
  double get minExtent => isSearchActive ? 150.0 : 100.0;

  @override
  double get maxExtent => isSearchActive ? 150.0 : 100.0;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SearchBarDelegate oldDelegate) {
    return isSearchActive != oldDelegate.isSearchActive ||
        filteredCount != oldDelegate.filteredCount;
  }
}
