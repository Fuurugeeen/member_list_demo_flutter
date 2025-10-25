import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/member.dart';

class StorageService {
  static const String _membersKey = 'members_data';

  Future<List<Member>> getAllMembers() async {
    final prefs = await SharedPreferences.getInstance();
    final membersJson = prefs.getString(_membersKey);
    
    if (membersJson == null) {
      return _getDefaultMembers();
    }
    
    try {
      final dynamic decoded = jsonDecode(membersJson);
      final List<dynamic> membersList = decoded as List<dynamic>;
      return membersList.map((dynamic json) => Member.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      return _getDefaultMembers();
    }
  }

  Future<void> saveMembers(List<Member> members) async {
    final prefs = await SharedPreferences.getInstance();
    final membersJson = jsonEncode(members.map((m) => m.toJson()).toList());
    await prefs.setString(_membersKey, membersJson);
  }

  Future<void> addMember(Member member) async {
    final members = await getAllMembers();
    members.add(member);
    await saveMembers(members);
  }

  Future<void> updateMember(Member updatedMember) async {
    final members = await getAllMembers();
    final index = members.indexWhere((m) => m.id == updatedMember.id);
    
    if (index != -1) {
      members[index] = updatedMember;
      await saveMembers(members);
    }
  }

  Future<void> deleteMember(String memberId) async {
    final members = await getAllMembers();
    members.removeWhere((m) => m.id == memberId);
    await saveMembers(members);
  }

  Future<Member?> getMember(String memberId) async {
    final members = await getAllMembers();
    try {
      return members.firstWhere((m) => m.id == memberId);
    } catch (e) {
      return null;
    }
  }

  List<Member> _getDefaultMembers() {
    final now = DateTime.now();
    return [
      Member(
        id: '1',
        name: '山田太郎',
        email: 'yamada@example.com',
        phone: '090-1234-5678',
        department: '開発部',
        createdAt: now,
        updatedAt: now,
      ),
      Member(
        id: '2',
        name: '佐藤花子',
        email: 'sato@example.com',
        phone: '090-2345-6789',
        department: '営業部',
        createdAt: now,
        updatedAt: now,
      ),
      Member(
        id: '3',
        name: '田中次郎',
        email: 'tanaka@example.com',
        phone: '090-3456-7890',
        department: '総務部',
        createdAt: now,
        updatedAt: now,
      ),
    ];
  }

  String generateId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }
}