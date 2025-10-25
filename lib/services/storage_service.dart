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
        email: 'yamada@techcorp.com',
        phone: '090-1234-5678',
        department: '開発部',
        company: 'テック株式会社',
        createdAt: now,
        updatedAt: now,
      ),
      Member(
        id: '2',
        name: '佐藤花子',
        email: 'sato@salesplus.co.jp',
        phone: '090-2345-6789',
        department: '営業部',
        company: 'セールスプラス有限会社',
        createdAt: now,
        updatedAt: now,
      ),
      Member(
        id: '3',
        name: '田中次郎',
        email: 'tanaka@globalworks.jp',
        phone: '090-3456-7890',
        department: '総務部',
        company: 'グローバルワークス株式会社',
        createdAt: now,
        updatedAt: now,
      ),
      Member(
        id: '4',
        name: '鈴木美咲',
        email: 'suzuki@designstudio.com',
        phone: '080-4567-8901',
        department: 'デザイン部',
        company: 'クリエイティブスタジオ合同会社',
        createdAt: now,
        updatedAt: now,
      ),
      Member(
        id: '5',
        name: '高橋健一',
        email: 'takahashi@marketing-pro.jp',
        phone: '070-5678-9012',
        department: 'マーケティング部',
        company: 'マーケティングプロ株式会社',
        createdAt: now,
        updatedAt: now,
      ),
      Member(
        id: '6',
        name: '中村あゆみ',
        email: 'nakamura@hrmanagement.com',
        phone: '080-6789-0123',
        department: '人事部',
        company: 'HRマネジメント株式会社',
        createdAt: now,
        updatedAt: now,
      ),
      Member(
        id: '7',
        name: '小林直樹',
        email: 'kobayashi@financegroup.co.jp',
        phone: '090-7890-1234',
        department: '経理部',
        company: 'ファイナンスグループ株式会社',
        createdAt: now,
        updatedAt: now,
      ),
      Member(
        id: '8',
        name: '渡辺麻衣',
        email: 'watanabe@productionworks.jp',
        phone: '070-8901-2345',
        department: '製造部',
        company: 'プロダクションワークス有限会社',
        createdAt: now,
        updatedAt: now,
      ),
      Member(
        id: '9',
        name: '松本優介',
        email: 'matsumoto@consultingfirm.com',
        phone: '080-9012-3456',
        department: 'コンサルティング部',
        company: 'ビジネスコンサルティング株式会社',
        createdAt: now,
        updatedAt: now,
      ),
      Member(
        id: '10',
        name: '森下千春',
        email: 'morishita@customercare.jp',
        phone: '090-0123-4567',
        department: 'カスタマーサポート部',
        company: 'カスタマーケア株式会社',
        createdAt: now,
        updatedAt: now,
      ),
    ];
  }

  String generateId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }
}