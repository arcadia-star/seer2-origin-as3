package com.taomee.seer2.app.net {
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.core.log.Logger;

import org.taomee.ds.HashMap;
import org.taomee.ds.HashSet;

public class ErrorMap {

    private static var _map:HashMap = new HashMap();

    private static var _filters:HashSet = new HashSet();

    private static var _logger:Logger;


    public static var DebugMode:Boolean = false;

    {
        initialize();
    }

    public function ErrorMap() {
        super();
    }

    private static function initialize():void {
        _logger = Logger.getLogger("ErrorMap");
        _filters.add(21);
        _filters.add(4);
        _filters.add(200021);
        _map.add(1, "用户重复登入");
        _map.add(2, "非法操作");
        _map.add(3, "未处理完上一条命令中，又收到客户端发来的命令");
        _map.add(4, "用户当前不在任何地图内");
        _map.add(5, "不正确的地图编号");
        _map.add(6, "找不到此物品(装扮)ID或此物品不在背包或装扮已有");
        _map.add(7, "穿着的衣服超过6件");
        _map.add(8, "此物品不能买");
        _map.add(9, "此物品不能卖");
        _map.add(10, "所需物品数量不足");
        _map.add(11, "已接的任务数已达上限");
        _map.add(12, "此任务已接或已完成");
        _map.add(13, "依赖任务没完成");
        _map.add(14, "主线任务不能取消");
        _map.add(15, "非法步骤数");
        _map.add(16, "依赖步骤没完成");
        _map.add(17, "任务完成时，不是所有步骤都完成了");
        _map.add(18, "背包太满，赠送不了，不能提交任务");
        _map.add(19, "任务或步骤提交时，扣除的东西不足，不能提交任务");
        _map.add(20, "");
        _map.add(21, "你使用了非法语言！");
        _map.add(22, "一次聊天内容（msg_len）过长");
        _map.add(23, "用户处于对战中");
        _map.add(24, "精灵背包只有一只精灵时，不能放仓库");
        _map.add(25, "背包中满六只精灵，不能把精灵再放背包");
        _map.add(26, "用户未处于对战中");
        _map.add(27, "仓库精灵数量不能超过1000");
        _map.add(28, "好友已存在，不能再添加此人");
        _map.add(29, "好友数量超过上限");
        _map.add(30, "黑名单上已存在，不能再添加此人");
        _map.add(31, "黑名单数量超过200上限");
        _map.add(32, "既非好友又非黑名单");
        _map.add(33, "精灵不在精灵背包里");
        _map.add(34, "不在好友列表");
        _map.add(35, "不在黑名单");
        _map.add(36, "技能背包没有此技能");
        _map.add(37, "替换的技能类型与被替换的类型不符");
        _map.add(38, "可替换的技能无此技能");
        _map.add(39, "没有此精灵的ID号");
        _map.add(40, "精灵图鉴没有达到要完成的程度");
        _map.add(41, "用户不在小屋");
        _map.add(42, "没有此只精灵在训练中");
        _map.add(43, "这是背包里的最后一只精灵");
        _map.add(44, "不能挑战自己的精灵");
        _map.add(45, "游戏的ID号不存在");
        _map.add(46, "游戏还没开始");
        _map.add(47, "完成游戏小于最小时间");
        _map.add(48, "游戏分数超过最大值");
        _map.add(49, "没有足够的赛尔豆");
        _map.add(50, "此物品不能捕捉精灵");
        _map.add(51, "此物品不是纹章");
        _map.add(52, "没有权限使用此纹章");
        _map.add(53, "精灵玩法的ID号不对");
        _map.add(54, "选择的精灵数目不对");
        _map.add(55, "道具无效");
        _map.add(56, "还没完成前面一个玩法");
        _map.add(57, "对战模式不对");
        _map.add(58, "还没有通关");
        _map.add(59, "物品的种类不对");
        _map.add(60, "地图上不含BOSS");
        _map.add(61, "对战首发精灵没血了");
        _map.add(62, "错误的勋章ID");
        _map.add(63, "更换的称号与原称号一样");
        _map.add(64, "此精灵不能做梦");
        _map.add(65, "精灵没有此交换任务存在");
        _map.add(66, "达到每天的上限");
        _map.add(67, "物品信息有错");
        _map.add(68, "该数据在数据库中不存在");
        _map.add(69, "已经领取过");
        _map.add(70, "今天不能触发双倍经验值");
        _map.add(71, "电池时间不足");
        _map.add(72, "不能够遇到做梦的精灵");
        _map.add(73, "没有跟随精灵");
        _map.add(74, "电池已耗完不能精灵对战");
        _map.add(75, "没有更改装扮");
        _map.add(76, "背包中无此装备");
        _map.add(77, "用户不在此场景上");
        _map.add(78, "此精灵已跟随，不要再设置跟随");
        _map.add(79, "此精灵未跟随，所以不能设置收回跟随");
        _map.add(80, "对战连接出错");
        _map.add(81, "连接数据库出错");
        _map.add(82, "不能加自己为好友或黑名单");
        _map.add(83, "主线任务只能接一个");
        _map.add(84, "背包中无精灵");
        _map.add(85, "签名字数过多");
        _map.add(86, "采矿地点不正确");
        _map.add(87, "此精灵不能放生");
        _map.add(88, "最高等级的精灵的等级不够");
        _map.add(89, "前置的BOSS没打败");
        _map.add(90, "达到每周的上限");
        _map.add(91, "服务器将在30秒后关闭");
        _map.add(92, "服务器关闭");
        _map.add(93, "你的精灵还没有准备好再次出战");
        _map.add(94, "序列号不正确");
        _map.add(95, "未选择门战出战精灵");
        _map.add(96, "精灵等级不够");
        _map.add(97, "session 已经失效");
        _map.add(98, "发来的每日上限类型错误");
        _map.add(102, "精灵血量未满");
        _map.add(106, "精灵血量未满");
        _map.add(111, "还没到6点,不能战斗");
        _map.add(113, "训练师等级不够");
        _map.add(114, "对方已加入别的战队");
        _map.add(116, "用户还没军团");
        _map.add(117, "当前活动已结束");
        _map.add(121, "对方状态不能参战");
        _map.add(122, "还不符合领取条件哦！");
        _map.add(123, "管理员踢人");
        _map.add(128, "不是军团队长");
        _map.add(129, "不能查看军团成员列表，原因：不在基地，或还没加入军团");
        _map.add(130, "没有通过战斗校验");
        _map.add(131, "此用户是军团队长");
        _map.add(139, "不能移交自己为军团队长");
        _map.add(140, "被移交成为队长的人不是此军团成员");
        _map.add(141, "在线时长领奖励未到时间");
        _map.add(142, "无权拉取战队详细信息");
        _map.add(143, "能源回收器今天已经不能再回收垃圾啦");
        _map.add(144, "无权签到");
        _map.add(145, "无权更新军团公告");
        _map.add(147, "每日钓鱼数量上限");
        _map.add(148, "每日钓鱼次数上限");
        _map.add(149, "上次没有拉杆");
        _map.add(150, "没有放饵");
        _map.add(151, "钓鱼位置不正确");
        _map.add(152, "渔具不足");
        _map.add(165, "领取次数达到上限");
        _map.add(168, "战队贡献等级不够");
        _map.add(172, "此军团已解散");
        _map.add(173, "双精灵对战血量不足");
        _map.add(175, "你的发言太频繁了,请先休息一下吧！");
        _map.add(176, "物品使用次数已达到每日上限");
        _map.add(183, "你说同一句话太多次了，先休息一下吧。");
        _map.add(184, "任务接取时间不正确");
        _map.add(186, "用户处于小游戏中");
        _map.add(192, "不能够为背包所有精灵加血");
        _map.add(193, "初始精灵等级不够");
        _map.add(194, "不是需要的初始精灵的总类");
        _map.add(195, "今日获得赛尔豆达到上限");
        _map.add(196, "资质已经到达最大了");
        _map.add(202, "此精灵已存在");
        _map.add(205, "该精灵不能参与离线经验注入");
        _map.add(222, "该鱼饵为钓鱼大师赛指点鱼饵，仅能在水仙溪口使用哦。");
        _map.add(223, "今日贡献烹调大赛脂肪值达到上限");
        _map.add(226, "已经有此精灵");
        _map.add(5012, "首发精灵不正确");
        _map.add(100105, "星钻余额不足，请充值后再购买!");
        _map.add(101002, "数据库出错");
        _map.add(101003, "NET出错");
        _map.add(101004, "命令ID没有定义");
        _map.add(101005, "协议长度不符合");
        _map.add(101014, "该数据在数据库已存在");
        _map.add(101015, "无此数据");
        _map.add(101017, "网络超时");
        _map.add(101020, "数量不够减");
        _map.add(101021, "DB中数据存储超过最大值");
        _map.add(101104, "米米号已存在");
        _map.add(101105, "你输入的米米号不存在");
        _map.add(104331, "session无效");
        _map.add(104333, "用户被禁永远");
        _map.add(104334, "用户被禁24小时");
        _map.add(104335, "用户被禁一周");
        _map.add(104336, "用户被禁两周");
        _map.add(104383, "用户被禁30天");
        _map.add(104337, "该装扮ID不在数据库装扮ID的区间，请检查XML表中此ID是否存在");
        _map.add(104338, "该物品ID不在数据库物品ID的区间，请检查XML表中此ID是否存在");
        _map.add(104339, "离线消息太多，超出数据库存储范围");
        _map.add(104340, "精灵图鉴已满");
        _map.add(104341, "训练的精灵超过上限");
        _map.add(104342, "领悟技能条件过多，超过存储上限");
        _map.add(104343, "spt信息过多，超过存储上限");
        _map.add(104344, "技能过多，超过存储上限");
        _map.add(104345, "各门战斗信息过多，超过存储上限");
        _map.add(104346, "精灵不在仓库和背包中");
        _map.add(104347, "符合要求的精灵不存在");
        _map.add(104348, "符合要求的物品不存在");
        _map.add(104349, "符合要求的任务不存在");
        _map.add(104350, "bit_index不正确");
        _map.add(104351, "个性签名过长，超过存储上限");
        _map.add(104352, "好友列表或黑名单达到存储上限");
        _map.add(104353, "赛尔豆");
        _map.add(104354, "物品数量不足");
        _map.add(104359, "军团人数已达到上限");
        _map.add(104360, "用户已经是军团的成员");
        _map.add(104361, "用户不是军团成员");
        _map.add(104362, "垃圾已经被人抢先一步回收啦");
        _map.add(104366, "只有VIP才能兑换哦");
        _map.add(104372, "仓库精灵已达到上限,请放生精灵");
        _map.add(109999, "数据库没有操作，更新不成功 \n ps：db操作后返回值没有错误码，系统自动设置9999");
        _map.add(200001, "战队不处于资源加载状态");
        _map.add(200002, "用户处于未应答加入战队状体");
        _map.add(200003, "用户未处于可战斗状态");
        _map.add(200004, "战队未处于可以选择技能状态");
        _map.add(200005, "用户已经选择了技能");
        _map.add(200007, "选择技能时,没有可战斗的精灵");
        _map.add(200008, "未处理完上一条命令中，又收到客户端发来的命令");
        _map.add(200009, "更换精灵错误(HP==0/精灵不存在)");
        _map.add(200010, "道具不存在");
        _map.add(200011, "使用道具时,没有可参战的精灵");
        _map.add(200012, "邀请参战用户不存在");
        _map.add(200013, "用户选择技能太快");
        _map.add(200017, "巅峰之战不在规则时间内");
        _map.add(200018, "不符合参赛条件");
        _map.add(200028, "次数不足");
        _map.add(200029, "冷却中");
        _map.add(200032, "你背包中已经有一只该类精灵，不能让多只该类精灵出战！");
        _map.add(200033, "精灵魔神化等级已经满了");
        _map.add(200039, "星魂抽满了");
        _map.add(200034, "没有改精灵的神化魔化信息");
        _map.add(200052, "功能下线");
        _map.add(200054, "合体失败，精灵身上星魂未移除");
        _map.add(104388, "副队长人数达到最大");
        _map.add(104389, "副队长人数为0");
        _map.add(200077, "背包内只能携带一只该精灵！");
    }

    public static function findErrorMessage(param1:int):String {
        if (_map.containsKey(param1)) {
            return _map.getValue(param1);
        }
        return "错误码:" + param1;
    }

    public static function parseStatusCode(param1:uint):void {
        var errorMessage:String;
        var statusCode:uint = param1;
        if (_filters.contains(statusCode)) {
            return;
        }
        errorMessage = findErrorMessage(statusCode);
        try {
            if (errorMessage != "") {
                if(DebugMode){
                    AlertManager.showAlert(errorMessage + "!");
                }
            }
        } catch (e:Error) {
            _logger.error("UI 还未起来");
        }
    }
}
}
