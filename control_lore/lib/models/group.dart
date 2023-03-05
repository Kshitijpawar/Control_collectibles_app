import 'package:control_lore/models/subgroup.dart';

class Group {
  String groupName;
  List<Subgroup> subgroups;
  Group({required this.groupName, required this.subgroups});

  factory Group.fromJson(groupNameKey, groupValue) {
    return Group(
        groupName: groupNameKey,
        subgroups: groupValue.entries.map<Subgroup>((entry) {
          return Subgroup.fromJson(entry.value, entry.key);
        }).toList());
  }

  Map<String, dynamic> toJson() {
    return {'groupName' : groupName, 'subgroups': subgroups.map((e) => e.toJson()).toList()};
  }

  @override
  String toString() => 'Groupname :$groupName\t';
}
