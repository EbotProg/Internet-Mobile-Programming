// import 'package:lone_soul/models/match.dart';
// import 'package:lone_soul/models/preference.dart';
// import 'package:lone_soul/models/user.dart';
// import 'package:lone_soul/services/db/conversation_db_methods.dart';
// import 'package:lone_soul/services/db/user_db_methods.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class FoodService {
//   final supabaseInstance = Supabase.instance;

//   //insert users to database
//   Future<List<MatchUser>> getMatches(String userId) async {
//     final userDBMethods = UserDBMethods();
//     final conversationDBMethods = ConversationDBMethods();
//     try {
//       final conversations =
//           await conversationDBMethods.getConversations(userId);
//       final map1 = await supabaseInstance.client
//           .from('matches')
//           .select<List<Map<String, dynamic>>>()
//           .contains('user_id_1', userId);
//       final map2 = await supabaseInstance.client
//           .from('matches')
//           .select<List<Map<String, dynamic>>>()
//           .contains('user_id_2', userId);
//       final finalMap = [...map1, ...map2];

//       final requests = finalMap.map((e) {
//         if (e['user_id_1'] != userId) {
//           return userDBMethods.getUser(e['user_id_1']);
//         }

//         return userDBMethods.getUser(e['user_id_2']);
//       });

//       final results = await Future.wait(requests);

//       final matches = <MatchUser>[];
//       for (int i = 0; i < results.length; i++) {
//         if (results[i] == null ||
//             conversations.any(
//               (element) => element.userId == results[i]?.userId,
//             )) {
//           continue;
//         }
//         matches.add(
//           MatchUser(
//             id: finalMap[i]['id'],
//             match: results[i],
//             matchScore: finalMap[i]['match_score'],
//           ),
//         );
//       }

//       return matches;
//     } on PostgrestException catch (e) {
//       print(e);
//       return [];
//     } catch (e) {
//       print(e);
//       return [];
//     }
//   }

//   //insert users to database
//   Future<List<MatchUser>> searchForMatches(
//     String userId,
//     Preference? preference,
//   ) async {
//     final conversationDBMethods = ConversationDBMethods();
//     try {
//       final userDBMethods = UserDBMethods();

//       final user1 = await userDBMethods.getUser(userId);

//       if (user1 == null) return [];

//       if (preference != null) {
//         user1.preference = preference;
//       }

//       final users = await supabaseInstance.client
//           .from('users')
//           .select<List<Map<String, dynamic>>>('id');

//       final conversations =
//           await conversationDBMethods.getConversations(userId);

//       users.removeWhere(
//         (user) => conversations.any(
//           (conversation) => conversation.userId == user['id'],
//         ),
//       );

//       final userRequests = users.map((e) {
//         return getMatchScore(userId, e['id']);
//       });

//       final results = await Future.wait(userRequests);

//       results.removeWhere((e) => e == null);
//       final realResults = results.map((e) => e!).toList();
//       realResults.sort((a, b) => a.matchScore.compareTo(b.matchScore));

//       return realResults;
//     } on PostgrestException catch (e) {
//       print(e);
//       return [];
//     } catch (e) {
//       print(e);
//       return [];
//     }
//   }

//   Future<MatchUser?> getMatchScore(String userID1, String userID2) async {
//     try {
//       final userDBMethods = UserDBMethods();

//       final user1 = await userDBMethods.getUser(userID1);
//       final user2 = await userDBMethods.getUser(userID2);

//       if (user1 == null || user2 == null) return null;

//       return MatchUser(
//         matchScore: _checkAge(user1, user2) +
//             _checkGender(user1, user2) +
//             _checkInterests(user1, user2),
//         match: user2,
//       );
//     } on PostgrestException catch (e) {
//       print(e);
//       return null;
//     }
//   }

//   double _checkAge(AppUser user1, AppUser user2) {
//     double score = 0;
//     if ((user1.age ?? 0) <= (user2.preference?.maxAge ?? 0) &&
//         (user1.age ?? 0) >= (user2.preference?.minAge ?? 0)) {
//       score += 1;
//     }

//     if ((user2.age ?? 0) <= (user1.preference?.maxAge ?? 0) &&
//         (user2.age ?? 0) >= (user1.preference?.minAge ?? 0)) {
//       score += 1;
//     }

//     return score;
//   }

//   double _checkGender(AppUser user1, AppUser user2) {
//     double score = 0;
//     if ((user1.gender ?? 'man') == (user2.preference?.gender ?? 'man')) {
//       score += 1;
//     }

//     if ((user2.gender ?? 'man') == (user1.preference?.gender ?? 'man')) {
//       score += 1;
//     }

//     return score;
//   }

//   double _checkInterests(AppUser user1, AppUser user2) {
//     double score = 0;

//     final similarities1 = user1.preference?.interests
//             ?.where((element) => user2.interests?.contains(element) ?? false) ??
//         [];

//     score +=
//         (similarities1.length / (user1.preference?.interests?.length ?? 1)) * 3;

//     final similarities2 = user2.preference?.interests
//             ?.where((element) => user1.interests?.contains(element) ?? false) ??
//         [];

//     score +=
//         (similarities2.length / (user2.preference?.interests?.length ?? 1)) * 3;

//     return score;
//   }
// }
