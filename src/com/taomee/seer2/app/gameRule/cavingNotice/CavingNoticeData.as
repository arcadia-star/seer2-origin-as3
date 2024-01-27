package com.taomee.seer2.app.gameRule.cavingNotice {
public class CavingNoticeData {

    private static var _recordActivities:Vector.<ActivityRecord> = new Vector.<ActivityRecord>();

    public static const ACTIVITY_DATAS:Vector.<CavingPageInfo> = Vector.<CavingPageInfo>([new CavingPageInfo(27, 310, "“三八”双雄战！", Vector.<CavingTimeInfo>([new CavingTimeInfo(false, 6, 15, 0, 16, 0), new CavingTimeInfo(false, 0, 15, 0, 16, 0)])), new CavingPageInfo(28, 20, "资质修炼器", Vector.<CavingTimeInfo>([new CavingTimeInfo(false, 6, 14, 0, 16, 0), new CavingTimeInfo(false, 0, 14, 0, 16, 0)]))]);

    public static const NOTIC_DATAS:Vector.<CavingPageInfo> = Vector.<CavingPageInfo>([new CavingPageInfo(0, 90, "敌报！萨伦帝国入侵", Vector.<CavingTimeInfo>([new CavingTimeInfo(false, 5, 14, 0, 15, 0), new CavingTimeInfo(false, 5, 19, 0, 20, 0)])), new CavingPageInfo(1, 160, "重夺水源之心", Vector.<CavingTimeInfo>([new CavingTimeInfo(false, 6, 14, 0, 15, 0), new CavingTimeInfo(false, 6, 19, 0, 20, 0)])), new CavingPageInfo(2, 261, "火焰山激斗", Vector.<CavingTimeInfo>([new CavingTimeInfo(false, 0, 14, 0, 15, 0), new CavingTimeInfo(false, 0, 19, 0, 20, 0)])), new CavingPageInfo(15, 350, "“鸡”毛与沙", Vector.<CavingTimeInfo>([new CavingTimeInfo(true)])), new CavingPageInfo(3, 81, "守擂达人", Vector.<CavingTimeInfo>([new CavingTimeInfo(false, 6, 20, 0, 21, 0), new CavingTimeInfo(false, 0, 20, 0, 21, 0)])), new CavingPageInfo(4, 81, "双倍荣誉", Vector.<CavingTimeInfo>([new CavingTimeInfo(false, 6, 20, 0, 21, 0), new CavingTimeInfo(false, 0, 20, 0, 21, 0)])), new CavingPageInfo(16, 262, "M5战书？我接受！", Vector.<CavingTimeInfo>([new CavingTimeInfo(false, 6, 16, 0, 17, 0), new CavingTimeInfo(false, 0, 16, 0, 17, 0)]))]);

    public static const ALLACTIVITY:Vector.<CavingPageInfo> = ACTIVITY_DATAS.concat(NOTIC_DATAS);

    public static const RAREPET_DATAS:Vector.<CavingPageInfo> = Vector.<CavingPageInfo>([new CavingPageInfo(11, 340, "摇滚天王：爆炸头！", Vector.<CavingTimeInfo>([new CavingTimeInfo(true)])), new CavingPageInfo(12, 520, "闻笛起舞？！", Vector.<CavingTimeInfo>([new CavingTimeInfo(true)])), new CavingPageInfo(13, 262, "谁敢打扰达达用餐？", Vector.<CavingTimeInfo>([new CavingTimeInfo(false, 0, 13, 0, 14, 0), new CavingTimeInfo(false, 1, 13, 0, 14, 0), new CavingTimeInfo(false, 2, 13, 0, 14, 0), new CavingTimeInfo(false, 3, 13, 0, 14, 0), new CavingTimeInfo(false, 4, 13, 0, 14, 0), new CavingTimeInfo(false, 5, 13, 0, 14, 0), new CavingTimeInfo(false, 6, 13, 0, 14, 0)])), new CavingPageInfo(14, 125, "谁偷吃了我的料理？", Vector.<CavingTimeInfo>([new CavingTimeInfo(false, 0, 18, 0, 20, 0), new CavingTimeInfo(false, 1, 18, 0, 20, 0), new CavingTimeInfo(false, 2, 18, 0, 20, 0), new CavingTimeInfo(false, 3, 18, 0, 20, 0), new CavingTimeInfo(false, 4, 18, 0, 20, 0), new CavingTimeInfo(false, 5, 18, 0, 20, 0), new CavingTimeInfo(false, 6, 18, 0, 20, 0)])), new CavingPageInfo(29, 132, "爱之拂晓兔", Vector.<CavingTimeInfo>([new CavingTimeInfo(true)])), new CavingPageInfo(30, 70, "回忆的鲁卜利娃娃", Vector.<CavingTimeInfo>([new CavingTimeInfo(true)]))]);

    public static const ONLYPET_DATAS:Vector.<CavingPageInfo> = Vector.<CavingPageInfo>([new CavingPageInfo(6, 540, "万圣节精灵：阿布", Vector.<CavingTimeInfo>([new CavingTimeInfo(false)])), new CavingPageInfo(17, 70, "埃卡维特的梦境奇遇", Vector.<CavingTimeInfo>([new CavingTimeInfo(false)])), new CavingPageInfo(19, 20, "姜饼城不眠夜", Vector.<CavingTimeInfo>([new CavingTimeInfo(false)])), new CavingPageInfo(23, 70, "提灯怪灵闹新春！", Vector.<CavingTimeInfo>([new CavingTimeInfo(false)]))]);


    public function CavingNoticeData() {
        super();
    }

    public static function hasNoticeActivity():Boolean {
        var _loc2_:CavingPageInfo = null;
        var _loc1_:Boolean = false;
        for each(_loc2_ in ALLACTIVITY) {
            if (checkActivity(_loc2_)) {
                _loc1_ = true;
            }
        }
        return _loc1_;
    }

    private static function checkActivity(param1:CavingPageInfo):Boolean {
        var _loc5_:CavingTimeInfo = null;
        var _loc6_:Boolean = false;
        var _loc7_:ActivityRecord = null;
        var _loc2_:Boolean = false;
        var _loc3_:Vector.<CavingTimeInfo> = param1.times;
        var _loc4_:uint = param1.pageId;
        for each(_loc5_ in _loc3_) {
            if (_loc5_.allTime == false) {
                if (_loc5_.isInTimeScope()) {
                    _loc6_ = false;
                    for each(_loc7_ in _recordActivities) {
                        if (_loc7_.pageId == _loc4_ && _loc7_.timeInfo.compare(_loc5_)) {
                            _loc6_ = true;
                            break;
                        }
                    }
                    if (_loc6_ == false) {
                        _loc2_ = true;
                        _recordActivities.push(new ActivityRecord(_loc4_, _loc5_));
                    }
                }
            }
        }
        return _loc2_;
    }

    public static function addTagButton(param1:TagButton, param2:uint):void {
        var _loc3_:Boolean = checkPageInfo(param1, param2, ALLACTIVITY);
        if (_loc3_ == false) {
            _loc3_ = checkPageInfo(param1, param2, RAREPET_DATAS);
        }
        if (_loc3_ == false) {
            _loc3_ = checkPageInfo(param1, param2, ONLYPET_DATAS);
        }
    }

    private static function checkPageInfo(param1:TagButton, param2:uint, param3:Vector.<CavingPageInfo>):Boolean {
        var _loc5_:CavingPageInfo = null;
        var _loc4_:Boolean = false;
        for each(_loc5_ in param3) {
            if (_loc5_.pageId == param2) {
                _loc5_.btn = param1;
                _loc4_ = true;
                break;
            }
        }
        return _loc4_;
    }
}
}
