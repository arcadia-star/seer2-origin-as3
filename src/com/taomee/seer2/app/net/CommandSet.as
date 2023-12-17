package com.taomee.seer2.app.net
{
   public class CommandSet
   {
      
      public static const GET_VERIFY_CODE_101:Command = new Command(101,"验证 码");
      
      public static const LOGIN_103:Command = new Command(103,"Login");
      
      public static const ACTIVE_CODE_104:Command = new Command(104,"Set active code");
      
      public static const GET_RECOMMEND_SERVER_LIST_105:Command = new Command(105,"Get recommend server list");
      
      public static const GET_RANGED_SERVER_LIST_106:Command = new Command(106,"Get ranged server list");
      
      public static const CREATE_ROLE_107:Command = new Command(107,"创建角色");
      
      public static const CHECK_CREATED_ROLE_110:Command = new Command(110,"Check has role");
      
      public static const CHECK_HAS_ROLE_111:Command = new Command(111,"Check role exists in data base");
      
      public static const DEPUTIZE_SEND_999:Command = new Command(999,"发送代理地址给online服务器");
      
      public static const ONLINE_LOGIN_1001:Command = new Command(1001,"Login to online server");
      
      public static const SYNC_SERVER_TIME_1100:Command = new Command(1100,"Synchronize time of server");
      
      public static const SYNC_POSITION_1101:Command = new Command(1101,"Synchronize postion of actors");
      
      public static const LIST_USER_1004:Command = new Command(1004,"地图---玩家列表");
      
      public static const USER_ENTER_MAP_1002:Command = new Command(1002,"地图---玩家进入");
      
      public static const USER_LEAVE_MAP_1003:Command = new Command(1003,"地图---玩家离开");
      
      public static const USER_CHANGE_NICK_1099:Command = new Command(1099,"改变昵称");
      
      public static const USER_CHANGE_MEDAL_1008:Command = new Command(1008,"User change medal");
      
      public static const USER_CHANGE_SIGNATURE_1029:Command = new Command(1029,"User change signature");
      
      public static const USER_GET_SIMPLE_INFO_1028:Command = new Command(1028,"获取简单用户信息");
      
      public static const USER_GET_DETAIL_INFO_1010:Command = new Command(1010,"获取详细用户信息");
      
      public static const ITEM_GET_LIST_1005:Command = new Command(1005,"Get item list");
      
      public static const ITEM_REMOVE_1009:Command = new Command(1009,"Remove item");
      
      public static const ITEM_ADD_1006:Command = new Command(1006,"Add item or equip");
      
      public static const EQUIP_GET_LIST_1007:Command = new Command(1007,"获取装备列表");
      
      public static const EQUIP_CHANGE_1098:Command = new Command(1098,"改变装备");
      
      public static const SERVER_CLOSE_NOTIFY_1012:Command = new Command(1012,"服务器关闭通知");
      
      public static const QUEST_ACCEPT_1011:Command = new Command(1011,"接受任务");
      
      public static const QUEST_ABORT_1013:Command = new Command(1013,"取消任务");
      
      public static const QUEST_GET_BUFFER_1014:Command = new Command(1014,"获取任务信息");
      
      public static const QUEST_SUBMIT_STEP_BUFFER_1015:Command = new Command(1015,"设置任务步骤信息");
      
      public static const FIGHT_CATCH_PET_1031:Command = new Command(1031,"捕捉精灵");
      
      public static const FIGHT_USE_MEDICINE_1048:Command = new Command(1048,"使用道具");
      
      public static const FIGHT_START_WILD_1500:Command = new Command(1500,"对战野怪");
      
      public static const FIGHT_RES_READY_1501:Command = new Command(1501,"用户资源加载完成");
      
      public static const FIGHT_USE_SKILL_1502:Command = new Command(1502,"用户选择技能");
      
      public static const FIGHE_PLAYER_INVITE_1503:Command = new Command(1503,"邀请用户对战");
      
      public static const FIGHE_PLAYER_ACCEPT_1504:Command = new Command(1504,"接受用户对战");
      
      public static const FIGHE_PLAYER_CANCEL_1505:Command = new Command(1505,"取消邀请");
      
      public static const FIGHT_END_1507:Command = new Command(1507,"战斗结束");
      
      public static const FIGHT_INVITE_1508:Command = new Command(1508,"online向用户发送战斗请求包");
      
      public static const FIGHT_ESCAPE_1509:Command = new Command(1509,"用户逃离战斗");
      
      public static const FIGHT_INVITE_PVP_1512:Command = new Command(1512,"PVP邀请");
      
      public static const FIGHT_ACCEPT_PVP_1513:Command = new Command(1513,"PVP接受");
      
      public static const FIGHT_CANCEL_INVITE_PVP_1514:Command = new Command(1514,"PVP取消邀请");
      
      public static const ACCEPT_FIGHT_PVP_1515:Command = new Command(1515,"通知用户,被邀请方接受");
      
      public static const FIGHT_LOAD_RES_1:Command = new Command(1,"拉取战队双方信息 （1~1000为btl直接传给cli，无需online解包、打包 ）");
      
      public static const FIGHT_TURN_START_2:Command = new Command(2,"战斗会合开始");
      
      public static const FIGHT_HURT_NOTIFY_3:Command = new Command(3,"在一回合中，通知计算结果的通知包 （无请求包，返回包为通知包）");
      
      public static const FIGHT_LOAD_MAP_4:Command = new Command(4,"对战双方已应答，通知客户端可以加载对战资源 （无请求包，返回包为通知包）");
      
      public static const FIGHT_GET_REVENUE_5:Command = new Command(5,"战斗结束，获胜方获得经验通知 （无请求包，返回包为通知包）");
      
      public static const FIGHT_NEXT_TURN_7:Command = new Command(7,"通知一回合开始 （无请求包，返回包为通知包）");
      
      public static const FIGHT_CHANGED_NOTIFY_8:Command = new Command(8,"通知用户交换了精灵 （无请求包，返回包为通知包）");
      
      public static const FIGHT_BUFF_RESULT_NOTIFY_9:Command = new Command(9,"通知每回合状态影响 （无请求包，返回包为通知包）");
      
      public static const FIGHT_USE_ITEM_NOTIFY_10:Command = new Command(10,"使用道具后的广播包");
      
      public static const FIGHT_FEATRUE_RESULT_11:Command = new Command(11,"精灵特性改变精灵数据通知包");
      
      public static const FIGHT_ESCAPE_NOTIFY_12:Command = new Command(12,"Fight escape notify");
      
      public static const FIGHT_NOTIFY_MON_POS_15:Command = new Command(15,"通知位置上更新精灵信息");
      
      public static const FIGHT_UPDATE_ANGER_16:Command = new Command(16,"通知位置上更新双方怒气值");
      
      public static const PVP_FIGHT_NOTIFY_MON_POS_17:Command = new Command(17,"PVP_通知位置上更新精灵信息");
      
      public static const FIT_CHANGE_HP_POS_18:Command = new Command(18,"合体变身通知血量");
      
      public static const FIGHT_CHANGE_PET_19:Command = new Command(19,"变身精灵");
      
      public static const FIGHT_CHANGE_FIGHTER_1032:Command = new Command(1032,"Fight change fighter");
      
      public static const CHAT_1102:Command = new Command(1102,"Chat");
      
      public static const FIGHT_RING_INFO_1104:Command = new Command(1104,"擂台信息");
      
      public static const CLIENT_BROADCAST_DATA_1105:Command = new Command(1105,"客户端广播数据");
      
      public static const HOME_GET_BUDDY_NEWS_1041:Command = new Command(1041,"Get buddy news in home scene");
      
      public static const HOME_GET_HONOR_INFO_1052:Command = new Command(1052,"Get honor in home scene");
      
      public static const HOME_GET_ENTRY_INFO_1038:Command = new Command(1038,"Get enter info in home scene");
      
      public static const HOME_GARBAGE_CLEAN_1123:Command = new Command(1123,"小屋---清理垃圾");
      
      public static const GET_DREAM_REWAED_1053:Command = new Command(1053,"Get reward after dream");
      
      public static const PET_SPAWN_1103:Command = new Command(1103,"Pet spawn in lobby scene");
      
      public static const PET_CURE_1037:Command = new Command(1037,"用赛尔豆增加血量");
      
      public static const PET_TRAINING_START_1039:Command = new Command(1039,"设置训练精灵");
      
      public static const PET_TRAINING_FINISH_1040:Command = new Command(1040,"Finish training pet in home scene");
      
      public static const PET_TRAINING_FIGHT_1042:Command = new Command(1042,"Fight training pet in home scene");
      
      public static const PET_REPLACE_SKILL_1030:Command = new Command(1030,"Pet Skill Replaced");
      
      public static const PET_ADD_LEARNING_POINT_1033:Command = new Command(1033,"Pet learning point added");
      
      public static const PET_GET_DICTIONARY_LIST_1034:Command = new Command(1034,"Get pet list of dictionary");
      
      public static const PET_REWARD_STATUS_1058:Command = new Command(1058,"Get petDictionaryRewardStatus");
      
      public static const GET_REWARDS_HANDBOOK_1036:Command = new Command(1036,"Get petDictionary Collect Rewards");
      
      public static const PET_GET_STORAGE_LIST_1016:Command = new Command(1016,"获得仓库的精灵列表");
      
      public static const PET_SIMPLE_INFO_1017:Command = new Command(1017,"Get pet simple infomation");
      
      public static const PET_SET_STARTING_1018:Command = new Command(1018,"设置对战首发精灵");
      
      public static const PET_SET_FOLLOWING_1019:Command = new Command(1019,"设置精灵跟随与否");
      
      public static const PET_SET_STORAGE_STATUS_1020:Command = new Command(1020,"设置精灵放仓库或放背包里：当精灵从仓库放入背包时，若背包满，服务器发错误码，客户端接收到错误码后，请用户在背包中选择一只替换精灵，客户端发1020（flag=0），将替换精灵放至仓库，再发1020（flag=1），将原精灵放入背包");
      
      public static const PET_SET_FREE_STATUS_1021:Command = new Command(1021,"Set pet free status");
      
      public static const PET_GET_FREE_LIST_1022:Command = new Command(1022,"获得放生仓库精灵列表");
      
      public static const PET_STORAGE_TREASURE_1130:Command = new Command(1130,"精灵仓库---寻宝");
      
      public static const PET_WASH_LEARNING_POINT_1159:Command = new Command(1159,"精灵---使用物品洗学习力");
      
      public static const CHECK_ONLINE_1023:Command = new Command(1023,"Check online buddy");
      
      public static const BUDDY_ADD_1024:Command = new Command(1024,"Add Buddy Or Black");
      
      public static const BUDDY_REMOVE_1025:Command = new Command(1025,"Remove buddy");
      
      public static const BUDDY_NOTIFY_ADD_1026:Command = new Command(1026,"Notify add buddy");
      
      public static const BUDDY_REPLY_ADD_1027:Command = new Command(1027,"Reply add buddy");
      
      public static const MINI_GAME_START_1043:Command = new Command(1043,"开始小游戏");
      
      public static const MINI_GAME_OVER_1044:Command = new Command(1044,"离开小游戏");
      
      public static const BOSS_START_FIGHT_1046:Command = new Command(1046,"Boss start fight");
      
      public static const ITEM_SERVER_GIVE_1051:Command = new Command(1051,"Item sever active give");
      
      public static const ITEM_EXCHANGE_1055:Command = new Command(1055,"Item exchange");
      
      public static const ITEM_ADD_EXPERIENCE_1056:Command = new Command(1056,"使用加经验值的道具，精灵属性更改通知包");
      
      public static const ITEM_PET_UPDATE_1057:Command = new Command(1057,"Item pet update");
      
      public static const SPT_GET_INFO_1059:Command = new Command(1059,"获取SPT信息");
      
      public static const DIGGER_MINE_1060:Command = new Command(1060,"挖矿");
      
      public static const CLIENT_GET_BUFFER_INFO_1062:Command = new Command(1062,"向服务器请求客户端保存的数据");
      
      public static const CLIENT_SET_BUFFER_INFO_1063:Command = new Command(1063,"向服务器设置客户端保存的数据");
      
      public static const TRAILS_DOOR_FIGHT_1064:Command = new Command(1064,"向服务器请求试炼之门当前层的战斗精灵Id");
      
      public static const FIGHT_IN_TRAILSDOOR_1047:Command = new Command(1047,"向服务器请求试炼之门开始战斗");
      
      public static const DOOR_OUT_1049:Command = new Command(1049,"退出门对战");
      
      public static const DAILY_LIMIT_1065:Command = new Command(1065,"获取每日上限的剩余次数");
      
      public static const ACTIVITY_FIGHT_MONSTER_1066:Command = new Command(1066,"fight monster in activity");
      
      public static const ADD_ALLPETBAT_BLOOD_1069:Command = new Command(1069,"add all petbag pets\' blood");
      
      public static const CHECK_DAILY_REWARD_1061:Command = new Command(1061,"Check Daily Reward");
      
      public static const FISH_FIGHT_1165:Command = new Command(1165,"与钓上的精灵对战");
      
      public static const MAGIC_NUM_QUERY_1067:Command = new Command(1067,"神奇密码查询");
      
      public static const MAGIC_NUM_USE_1068:Command = new Command(1068,"神奇密码使用");
      
      public static const BEAT_CAPTAIN_1070:Command = new Command(1070,"BeatCaptain");
      
      public static const VOTE_SEND_INFO_1071:Command = new Command(1071,"Send Vote Info");
      
      public static const VOTE_GET_INFO_1072:Command = new Command(1072,"Get Vote Info");
      
      public static const NOTIFY_SYS_MSG_1073:Command = new Command(1073,"详细通告");
      
      public static const GET_PETINFO_1074:Command = new Command(1074,"获取精灵信息");
      
      public static const SHOOT_1075:Command = new Command(1075,"射击");
      
      public static const SET_THIS_SUMMONED_1076:Command = new Command(1076,"设置自己为召集者");
      
      public static const SET_SUMMONED_ID_1077:Command = new Command(1077,"设置自己的召集者的ID");
      
      public static const GET_SUMMONED_INFO_1078:Command = new Command(1078,"获取被召集者列表");
      
      public static const DOOR_FIGHT_MATCH_1079:Command = new Command(1079,"请求门战匹配");
      
      public static const DOOR_FIGHT_MATCH_CANCEL_1080:Command = new Command(1080,"取消门战匹配");
      
      public static const DOOR_FIGHT_MATCH_END_1082:Command = new Command(1082,"门战匹配结果");
      
      public static const DOOR_FIGHT_WAR_PET_INFO_13:Command = new Command(13,"门战对方选择的精灵");
      
      public static const TEAM_PREPARE_ACTIVITY_1081:Command = new Command(1081,"提交意见表");
      
      public static const TEAM_CREATE_1083:Command = new Command(1083,"战队---创建");
      
      public static const TEAM_INVITE_JOIN_1084:Command = new Command(1084,"战队---邀请加入");
      
      public static const TEAM_INVITE_NOTIFY_1085:Command = new Command(1085,"战队---邀请通知");
      
      public static const TEAM_INVITE_REPLY_1086:Command = new Command(1086,"战队---邀请回复");
      
      public static const TEAM_MEMBER_LIST_1089:Command = new Command(1089,"战队---拉取列表");
      
      public static const TEAM_MEMBER_QUERY_1090:Command = new Command(1090,"战队---成员查询");
      
      public static const TEAM_MEMBER_KICK_1092:Command = new Command(1092,"战队---踢出成员");
      
      public static const TEAM_QUIT_1093:Command = new Command(1093,"战队---退出战队");
      
      public static const TEAM_APPLY_JOIN_1166:Command = new Command(1166,"战队---申请加入");
      
      public static const TEAM_APPOINT_1567:Command = new Command(1567,"战队---任命为副队长");
      
      public static const TEAM_CANCEL_1568:Command = new Command(1568,"战队---撤销副队长");
      
      public static const TEAM_Reject_1571:Command = new Command(1571,"战队---拒绝加入战队");
      
      public static const MINIGAME_MOREGAIN_1091:Command = new Command(1091,"额外物品奖励的游戏id集");
      
      public static const INITPET_TRAINING_STEP_COMPLETE_1087:Command = new Command(1087,"Init Pet Training Step Complete");
      
      public static const INITPET_TRAINING_STEP_STATUS_1088:Command = new Command(1088,"Get Init Pet Training Step Status");
      
      public static const SELECT_ACTIVITY_TROOP_1106:Command = new Command(1106,"选择活动队伍");
      
      public static const GET_ACTIVITY_TROOP_FRACTION_1108:Command = new Command(1108,"获取每队的分数");
      
      public static const NOTICE_PVP_COPE_1107:Command = new Command(1107,"通知PVP对战");
      
      public static const CANCEL_NOTICE_1109:Command = new Command(1109,"通知方取消邀请");
      
      public static const ACTIVITY_ALL_USER_STATUS_1110:Command = new Command(1110,"返回活动中所有用户的状态");
      
      public static const HONOR_EXCHANGE_1097:Command = new Command(1097,"荣誉兑换");
      
      public static const START_FIGHT_SERVER_VERIFY_1111:Command = new Command(1111,"Server require verifying for start fight wild or SPT boss");
      
      public static const START_FIGHT_CLIENT_VERIFY_1112:Command = new Command(1112,"Client do verifying for start fight wild or SPT boss");
      
      public static const CLIENT_SET_SVR_BUF_INFO_1113:Command = new Command(1113,"Client set server buffer info");
      
      public static const ITEM_APPRISAL_1116:Command = new Command(1116,"洗资质");
      
      public static const BRANCH_EVOLUTION_1117:Command = new Command(1117,"分支进化");
      
      public static const FIGHT_NPC_1511:Command = new Command(1511,"和NPC战斗");
      
      public static const TEAM_DISSOLVE_1118:Command = new Command(1118,"dissolve team");
      
      public static const TEAM_TRANSFERCAPTAIN_1119:Command = new Command(1119,"transfer team captain");
      
      public static const TEAM_MODIFYINFO_1120:Command = new Command(1120,"modify team info");
      
      public static const TEAM_NEWS_1121:Command = new Command(1121,"拉取战队新闻的信息");
      
      public static const GET_ONLINE_CAN_SWAP_NUM_1122:Command = new Command(1122,"查询在线送奖励的可送个数");
      
      public static const HALLOWEEN_GET_USER_NICK_1125:Command = new Command(1125,"查询万圣节小屋好友对战信息");
      
      public static const GET_GIFT_CANGET_1124:Command = new Command(1124,"查询精灵图鉴礼包是否可领取");
      
      public static const GET_GAME_CANPLAY_1126:Command = new Command(1126,"查询游戏是否可玩");
      
      public static const TEAM_INFO_1127:Command = new Command(1127,"获得军团签到信息、挑战信息、公告等");
      
      public static const TEAM_REGISTER_1128:Command = new Command(1128,"军团签到");
      
      public static const TEAM_SAVENOTICE_1129:Command = new Command(1129,"更新军团公告");
      
      public static const TEAM_SAVEMSG_1570:Command = new Command(1570,"更新入队须知");
      
      public static const TEAM_GET_UPGRADE_INFO_1135:Command = new Command(1135,"获取战队升级信息");
      
      public static const TEAM_UPGRADE_1136:Command = new Command(1136,"战队升级");
      
      public static const TEAM_SAVE_COINS_1138:Command = new Command(1138,"给战队存钱");
      
      public static const TEAM_RANK_ID_1148:Command = new Command(1148,"TOP100战队ID");
      
      public static const TEAM_RANK_SIMPLEINFO_1149:Command = new Command(1149,"战队排名简单信息");
      
      public static const BAIT_FISH_1132:Command = new Command(1132,"放饵钓鱼");
      
      public static const GET_FISH_1133:Command = new Command(1133,"拉竿,获取鱼");
      
      public static const SHOW_FISH_LIST_1137:Command = new Command(1137,"展示钓过的鱼");
      
      public static const GET_VIP_TRY_1134:Command = new Command(1134,"vip预热活动");
      
      public static const ACTIVITY_PRE_FISH_1139:Command = new Command(1139,"活动--钓鱼预热");
      
      public static const RANDOM_EVENT_1140:Command = new Command(1140,"随机事件或物品");
      
      public static const FRIENDSHIP_TREE_REAP_1143:Command = new Command(1143,"收获友谊果实");
      
      public static const COOKING_CLICK_1144:Command = new Command(1144,"烹饪");
      
      public static const CHANGE_COLOR_1145:Command = new Command(1145,"改变赛尔颜色");
      
      public static const ACTIVE_COUNT_1142:Command = new Command(1142,"活动次数");
      
      public static const DOUBLEEXPTIME_INFO_1153:Command = new Command(1153,"获取用户累积的双倍经验时间信息");
      
      public static const DOUBLEEXPTIME_DRAW_1157:Command = new Command(1157,"领取双倍经验时间");
      
      public static const VIP_GAME_START_1146:Command = new Command(1146,"vip游戏开始");
      
      public static const VIP_GAME_OVER_1147:Command = new Command(1147,"vip游戏结束");
      
      public static const VIP_UPDATE:Command = new Command(1152,"vip信息更新");
      
      public static const SESSION_1156:Command = new Command(1156,"获取Session");
      
      public static const VIP_PAY_NOTICE:Command = new Command(1160,"vip付费通知");
      
      public static const FROZEN_ACTIVITY_TYPE_1151:Command = new Command(1151,"冰封活动广播报类型");
      
      public static const FROZEN_OUT_OR_OVER_1150:Command = new Command(1150,"用户离开或者进入5个点");
      
      public static const FROZEN_FIGHT_1154:Command = new Command(1154,"头部射击打中冰块或者人");
      
      public static const FROZEN_DEFEND_1155:Command = new Command(1155,"用户在盾里");
      
      public static const FROZEN_STATUS_1158:Command = new Command(1158,"轴的血和状态");
      
      public static const GET_DEVIL_TRAIN_1163:Command = new Command(1163,"获取魔鬼训练精灵列表");
      
      public static const DEVIL_TRAIN_1164:Command = new Command(1164,"魔鬼训练开始或者结束");
      
      public static const PET_PYRAMID_CHALLENGE_QUERY_1161:Command = new Command(1161,"精灵金字塔挑战查询");
      
      public static const PET_PYRAMID_CHALLENGE_RANK_1162:Command = new Command(1162,"精灵金字塔挑战排行");
      
      public static const VIP_LUCKY_MSG_1168:Command = new Command(1168,"vip幸运礼包");
      
      public static const HANI_SNOW_QUERY_1167:Command = new Command(1167,"哈尼雪人活动信息查询");
      
      public static const CHANGE_CHARECTER_1169:Command = new Command(1169,"洗性格");
      
      public static const LUCKY_TURN_TABLE_1170:Command = new Command(1170,"幸运转盘开始，扣除游戏币");
      
      public static const LUCKY_TURN_TABLE_1171:Command = new Command(1171,"幸运转盘结束，领奖励");
      
      public static const PLAYING_DEATH_LIST_1172:Command = new Command(1172,"获取玩法中死亡的精灵");
      
      public static const GET_CURRENT_POKE_COUNT_1173:Command = new Command(1173,"获得当前阶段遇到扑克怪的数量");
      
      public static const CHRISTMAS_MAKE_1174:Command = new Command(1174,"ChristmasMake");
      
      public static const INVITE_FRIEND_1175:Command = new Command(1175,"12月16日以后注册的用户填写老用户的米米号");
      
      public static const INVITE_FRIEND_1176:Command = new Command(1176,"填写此用户为召集用户的米米号的数目");
      
      public static const GET_VIP_GIFT_1177:Command = new Command(1177,"获取vip充值礼包个数");
      
      public static const GET_SPECIAL_ITEMINFO_1178:Command = new Command(1178,"获取特殊物品信息");
      
      public static const CHRISTMAS_WISH_1179:Command = new Command(1179,"圣诞许愿");
      
      public static const CALL_FIRE_DRAGON_1180:Command = new Command(1180,"召唤火龙");
      
      public static const SEND_SOCKS_GIFT_1181:Command = new Command(1181,"给好友送圣诞袜礼物");
      
      public static const GET_SOCKS_REWARD_1182:Command = new Command(1182,"领取圣诞袜礼物");
      
      public static const GET_SOCKS_USER_LIST_1184:Command = new Command(1184,"获取圣诞袜礼物用户id和nick列表");
      
      public static const SERVER_TYPE_1183:Command = new Command(1183,"用户从哪个网络代签过来");
      
      public static const REPLACE_PET_1185:Command = new Command(1185,"广播替换精灵");
      
      public static const GET_PUBLIC_ACTIVITY_COUNT_1186:Command = new Command(1186,"获取公共活动次数");
      
      public static const PUBLIC_ACTIVITY_1187:Command = new Command(1187,"公共活动");
      
      public static const DECORATE_CHEER_1188:Command = new Command(1188,"新年新气象加油");
      
      public static const TRAINER_TASKS_STATUS_1189:Command = new Command(1189,"获取训练师成长任务状态");
      
      public static const TRAINER_TASK_REWARD_1190:Command = new Command(1190,"训练师成长任务完成领奖");
      
      public static const SELECT_FIGHT_MONS_1192:Command = new Command(1192,"用户选择战斗的精灵");
      
      public static const SET_SECOND_MON_1193:Command = new Command(1193,"设置对战辅位精灵");
      
      public static const SET_NONO_FLAG_1194:Command = new Command(1194,"设置NONO跟随(返回包为广播包)");
      
      public static const GET_PET_PRACTICE_INFO_1195:Command = new Command(1195,"getPetPracticeInfo");
      
      public static const SET_PET_PRACTICE_INFO_1196:Command = new Command(1196,"setPetPracticeInfo");
      
      public static const NONO_TIME_BUTLER_UPDATE_1197:Command = new Command(1197,"NONO时间管家广播包");
      
      public static const BAB_LANGUAGE_1198:Command = new Command(1198,"脏词显示");
      
      public static const GET_VIPREWARD_INFO_1199:Command = new Command(1199,"获取VIP奖励信息");
      
      public static const ITEM_MAX_NOTIFY_INFO_1200:Command = new Command(1200,"物品最大值通知包");
      
      public static const MAP_RATE_PET_INFO_1201:Command = new Command(1201,"地图稀有精灵通知包");
      
      public static const MEE_COIN_INFO_1202:Command = new Command(1202,"米币账户余额");
      
      public static const MEE_COIN_RECRAGE_1203:Command = new Command(1203,"米币充值");
      
      public static const GET_BIRTH_SYSTEM_INFO_1204:Command = new Command(1204,"获取繁殖精灵信息");
      
      public static const START_BIRTH_PET_1205:Command = new Command(1205,"开始繁殖精灵");
      
      public static const CLOSE_BIRTH_1206:Command = new Command(1206,"取消繁殖精灵");
      
      public static const SET_BIRTH_HOME_1207:Command = new Command(1207,"设置小屋精灵");
      
      public static const GET_TWO_PET_1208:Command = new Command(1208,"获取二代精灵");
      
      public static const GET_RANGE_DAY_LIMIT_1209:Command = new Command(1209,"得到某个范围内用户每天做的事情的数目");
      
      public static const GET_DAY_RANDOM_PET_1210:Command = new Command(1210,"获取后台每日随机精灵");
      
      public static const GET_IS_START_ONHOOK_1212:Command = new Command(1212,"获取挂机跟随精灵获得的总经验值");
      
      public static const GET_DAY_EXP_TIME_1213:Command = new Command(1213,"获取今天双倍时间和学习力的倍数");
      
      public static const SET_BUDDY_POINT_1214:Command = new Command(1214,"赠送给好友点");
      
      public static const TREAT_ALL_PET_1215:Command = new Command(1215,"群体医疗");
      
      public static const PET_INFO_MESSAGE_1216:Command = new Command(1216,"通知精灵相关信息（后台主动发的）");
      
      public static const SELECT_PET_FIGHT_1217:Command = new Command(1217,"选择群体精灵对战");
      
      public static const SYSTEM_PET_FIGHT_1218:Command = new Command(1218,"用系统的精灵对战");
      
      public static const GET_TOTAL_VOTE_INFO_1219:Command = new Command(1219,"获取所有票数信息");
      
      public static const GET_DAYLIMIT_INFO_1220:Command = new Command(1220,"得到日常限制信息");
      
      public static const GET_PET_KING_AWARD_1221:Command = new Command(1221,"获取精灵王抢分赛奖励");
      
      public static const GET_SHOP_INFO_1223:Command = new Command(1223,"获取商品详细信息");
      
      public static const MI_BUY_ITEM_1224:Command = new Command(1224,"用米币购买商品");
      
      public static const CHECK_MI_CIPHER_1225:Command = new Command(1225,"检查密码是否正确");
      
      public static const CHECK_SETUP_CIPHER_1226:Command = new Command(1226,"是否设置过支付密码");
      
      public static const GET_TEAM_BLOOD_1227:Command = new Command(1227,"当前血量");
      
      public static const NOT_1070:Command = new Command(1228,"模仿1070");
      
      public static const GET_WOHOO_PVP_INFO_1229:Command = new Command(1229,"获取单挑王PVP信息");
      
      public static const GET_INTEGRAL_INFO_1230:Command = new Command(1230,"获取积分信息");
      
      public static const GET_CURR_BLOOD_1231:Command = new Command(1231,"当前血量");
      
      public static const GET_RANKING_LIST_1232:Command = new Command(1232,"获取排名序列");
      
      public static const GET_HOPES_LIST_1233:Command = new Command(1233,"提取用户愿景");
      
      public static const GET_PET_ITEM_INFO_1234:Command = new Command(1234,"获取精灵药品信息");
      
      public static const UPDATE_PET_ITEM_INFO_1235:Command = new Command(1235,"更新精灵药品信息");
      
      public static const ELEMENT_EQUIP_1236:Command = new Command(1236,"装备附魔");
      
      public static const MI_EXCHANGE_ITEM_1239:Command = new Command(1239,"米币兑换物品");
      
      public static const CLI_NOTIFY_DEL_MONSTER_1259:Command = new Command(1259,"删除精灵");
      
      public static const GRASP_SKILL_1246:Command = new Command(1246,"一键习得");
      
      public static const BATTERY_SWITCH_1516:Command = new Command(1516,"电池开关");
      
      public static const GET_INVITE_INFO_1517:Command = new Command(1517,"邀请好友信息");
      
      public static const GET_PLANT_INFO_1518:Command = new Command(1518,"获取田的信息");
      
      public static const PLANT_SET_INFO_1519:Command = new Command(1519,"田块操作信息");
      
      public static const CLI_SUBMIT_REPORT_ADD_1520:Command = new Command(1520,"获取装备特殊属性");
      
      public static const GET_RANK_LIST_1521:Command = new Command(1521,"拉取总排名");
      
      public static const GET_ACTOR_RANK_1522:Command = new Command(1522,"获取自己的排名");
      
      public static const PET_CHARA_PRACTICE_1525:Command = new Command(1525,"精灵性格修炼");
      
      public static const UPDATE_PET_CHARA_INFO_1526:Command = new Command(1526,"更新精灵性格相关属性");
      
      public static const SUPER_PET_PRACTICE_1528:Command = new Command(1528,"精灵一键搞定");
      
      public static const CLI_MIBI_GET_GIFT_INFO_1529:Command = new Command(1529,"用户米币消费获取礼物次数");
      
      public static const SERVER_MESSAGE_8000:Command = new Command(8000,"Server message");
      
      public static const CLI_SET_WIN_COPY_1237:Command = new Command(1237,"完成某个副本关卡");
      
      public static const CLI_GET_WIN_COPY_1238:Command = new Command(1238,"拉取所有完成的副本关卡信息");
      
      public static const SET_CHPHER_IS_OPEN_1240:Command = new Command(1240,"设置支付密码的开关");
      
      public static const DAY_LIMIT_LIST_1241:Command = new Command(1241,"dayLimit序列拉取");
      
      public static const CLI_RAND_MONSTER_INDEX_1242:Command = new Command(1242,"暴食回廊中客户端随机精灵信息通知服务器");
      
      public static const CLI_NOTI_COPY_MAP_FIN_1243:Command = new Command(1243,"通知副本完成(由后台主动通知，不需要请求包)");
      
      public static const CLI_CHECK_HAVE_THIS_NUM_ID_1244:Command = new Command(1244,"判断用户是否拥有此类的精灵");
      
      public static const MYSTERY_YITE_MAP:Command = new Command(1245,"神秘伊特中获取地图的跳转顺序");
      
      public static const CLI_ASK_TO_DRESS_UP_1247:Command = new Command(1247,"玩家申请变身");
      
      public static const CLI_ASK_TO_ENTER_CHUANGO_1248:Command = new Command(1248,"玩家请求串串锅的状态");
      
      public static const CLI_ASK_CHUANGO_INFO_1249:Command = new Command(1249,"串串锅的状态信息");
      
      public static const CLI_RAND_SOME_INDEX_1250:Command = new Command(1250,"获取随机的下标,凯伊对决");
      
      public static const CLI_FIGHT_MON_SELECT_MON_1251:Command = new Command(1251,"选择出战精灵");
      
      public static const CLI_MONEY_COUNT_1253:Command = new Command(1253,"查询星钻数量");
      
      public static const CLI_BUY_MONEY_COUNT_1254:Command = new Command(1254,"米币购买星钻");
      
      public static const DELETE_MAIL_ON_SERVER:Command = new Command(1252,"删除服务器邮件数据");
      
      public static const GET_MAIL_LIST_DATA:Command = new Command(1255,"拉取邮件列表信息");
      
      public static const GET_SINGLE_MAIL_DATA:Command = new Command(1256,"获取某一封邮件的具体数据");
      
      public static const GET_MAIL_AWARD_1257:Command = new Command(1257,"获取邮件附件奖品");
      
      public static const NEW_MAIL_ARRIVE_1258:Command = new Command(1258,"有新邮件");
      
      public static const ALL_SERVER_DATA_1527:Command = new Command(1527,"全服数据");
      
      public static const CLI_GET_BOUGHT_LOTTERY_TICKET_INFO_1530:Command = new Command(1530,"拉取购买了的获奖彩票号码和注数");
      
      public static const CLI_GET_LOTTERY_BINGO_INFO_1531:Command = new Command(1531,"拉取历史中奖号码");
      
      public static const CLI_GET_LOTTERY_LUCKY_INFO_1532:Command = new Command(1532,"拉取历史开奖号码");
      
      public static const GET_PET_INFO_1533:Command = new Command(1533,"获取指定精灵信息");
      
      public static const INPUT_FRIEND_MIMI_1534:Command = new Command(1534,"填写召回人的米米号");
      
      public static const GET_PET_NUMBERID_HAVE_1535:Command = new Command(1535,"获取精灵种类ID有没有");
      
      public static const GET_VOTE_DATA_1536:Command = new Command(1536,"获得吉祥三宝的18个选择数据（全服）");
      
      public static const CLI_GET_WORLD_BOSS_BLOOD_DIMUSEN_1537:Command = new Command(1537,"蒂姆森之超能战纪，请求BOSS血量和阶段");
      
      public static const CLI_GET_WORLD_BOSS_BLOOD_DIMUSEN_1538:Command = new Command(1538,"请求BOSS血量和阶段");
      
      public static const CLI_START_BREED_1539:Command = new Command(1539,"精灵孵化器开始孵化");
      
      public static const CLI_SPEED_BREED_1540:Command = new Command(1540,"孵化器孵化加速");
      
      public static const GET_HOME_FIGHT_COUNT_1191:Command = new Command(1191,"获取小屋战斗次数");
      
      public static const CLI_GET_MON_FROM_BREEDING_1541:Command = new Command(1541,"取下孵化精元或者领取孵化精灵");
      
      public static const CLI_GET_MON_FROM_BREEDING_1542:Command = new Command(1542,"获取孵化器信息");
      
      public static const PINGTAI_GET_1543:Command = new Command(1543,"平台触发一下");
      
      public static const PET_EVOLVE_1544:Command = new Command(1544,"精灵魔神化");
      
      public static const CLI_GET_RANK_BEFORE_1545:Command = new Command(1545,"拉取过往排行榜");
      
      public static const CLI_GET_MON_SIMPLE_INFO_IN_BAG_1546:Command = new Command(1546,"拉背包指定精灵最新信息");
      
      public static const GET_CONIS_1547:Command = new Command(1547,"主动送赛尔豆");
      
      public static const TEMP_NOTIFY_1548:Command = new Command(1548,"后台通知有临时时间发生");
      
      public static const CLI_SET_MON_STATUS_VIP_1260:Command = new Command(1260,"设置精灵放仓库或者VIP背包里");
      
      public static const CLI_EXCHANGE_MON_BETWEEN_BAG_AND_VIP_BAG_1261:Command = new Command(1261,"增加普通背包和VIP背包的精灵互换协议");
      
      public static const CLI_ENTER_XINGHUNSHENGYU_1262:Command = new Command(1262,"拉取星魂背包");
      
      public static const CLI_STARHUN_GET_STARHUN_1263:Command = new Command(1263,"抽取星魂");
      
      public static const CLI_EXP_TO_COIN_STARHUN_1264:Command = new Command(1264,"星力转换");
      
      public static const CLI_PUT_ALL_RUNES_STARHUN_1265:Command = new Command(1265,"一键拾取星魂");
      
      public static const CLI_STAR_LEVEL_UP_1266:Command = new Command(1266,"升级星魂");
      
      public static const CLI_STAR_LEVEL_UP_1267:Command = new Command(1267,"移动星魂");
      
      public static const CLI_STAR_LEVEL_UP_1268:Command = new Command(1268,"获得宠物星魂");
      
      public static const CLI_CALC_POTENTIAL_1269:Command = new Command(1269,"资质洗练");
      
      public static const CLI_PASSWORD_1270:Command = new Command(1270,"密保回答");
      
      public static const CLI_HAVECLIE_REQUEST_1271:Command = new Command(1271,"一段时间内获取星钻数量");
      
      public static const GET_WISH_NUMS_1549:Command = new Command(1549,"获取用户当天能够许愿的次数");
      
      public static const GET_TEAM_QUEST_1550:Command = new Command(1550,"战队任务");
      
      public static const COM_TEAM_QUEST_1551:Command = new Command(1551,"完成任务");
      
      public static const QUIT_TEAM_QUEST_1552:Command = new Command(1552,"放弃任务");
      
      public static const NEW_TEAM_SHOP_BUY_1553:Command = new Command(1553,"新战队购买");
      
      public static const TEAM_RANK_INFO_1554:Command = new Command(1554,"新战队获取战队列表信息");
      
      public static const TEAM_BOSS_CURR_HP_1555:Command = new Command(1555,"军团BOSS剩余血量");
      
      public static const TEAM_BOSS_CURR_GET_1556:Command = new Command(1556,"军团BOSS奖励");
      
      public static const DREAM_ENTRY_MAP_1557:Command = new Command(1557,"进入永恒梦境关卡");
      
      public static const DREAM_CURR_MAP_INFO_1558:Command = new Command(1558,"永恒梦境当前关卡");
      
      public static const DREAM_AUTO_FIGHT_1559:Command = new Command(1559,"永恒梦境自动挑战");
      
      public static const DREAM_FIGHT_PET_1560:Command = new Command(1560,"永恒梦境挑战地图中的BOSS");
      
      public static const DREAM_FAMILY_INFO_1561:Command = new Command(1561,"拉去梦境氏族列表");
      
      public static const DREAM_MAP_INFO_LIST_1562:Command = new Command(1562,"永恒梦境氏族里的子列表");
      
      public static const DREAM_FAMILY_INFO_ONE_1563:Command = new Command(1563,"永恒梦境单个氏族的信息");
      
      public static const DREAM_MAP_INFO_ONE_1564:Command = new Command(1564,"永恒梦境单个氏族的信息");
      
      public static const CLI_PUBLIC_GET_KEY_VALUE_LIMIT_1273:Command = new Command(1273,"获得指定的key范围内的value,数量限制在limit范围内");
      
      public static const CLI_GET_USER_KING_BATTLE_LINEUP_1565:Command = new Command(1565,"获取特定玩家王者之战阵容");
      
      public static const CLI_GET_MASCOT_BLOOD_AND_STATE_1566:Command = new Command(1566,"吉祥物的血量和吉祥物的状态");
       
      
      public function CommandSet()
      {
         super();
      }
   }
}
