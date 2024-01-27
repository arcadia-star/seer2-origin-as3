package com.taomee.seer2.app.questTiny {
import com.taomee.seer2.app.component.tree.TreeItem;
import com.taomee.seer2.app.manager.DayLimitManager;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.questTiny.items.QuestTinyItem;
import com.taomee.seer2.core.quest.Quest;
import com.taomee.seer2.core.quest.constant.QuestStatus;
import com.taomee.seer2.core.quest.constant.QuestType;

import org.taomee.ds.HashMap;
import org.taomee.utils.BitUtil;

public class QuestTinyHelper {

    private static var _xmlClass:Class = QuestTinyHelper__xmlClass;

    private static var stepMap:HashMap = new HashMap();

    public static const RECOMMEND_QUEST:String = "recommendQuest";

    public static const MAIN_QUEST:String = "mainQuest";

    public static const CHAPTER_QUEST:String = "chapterQuest";

    public static const STORY_QUEST:String = "storyQuest";

    public static const PET_QUEST:String = "petQuest";

    public static const BRANCH_QUEST:String = "branchQuest";

    public static const ACTIVITY_QUEST:String = "activityQuest";

    public static const STAR_QUEST:String = "starQuest";

    private static var branchList:Array = [10050, 10051, 10052, 10053, 10054, 10055, 10056, 10057, 10069, 10070, 10071];

    private static const dayLimit:uint = 1524;

    {
        initlize();
    }

    public function QuestTinyHelper() {
        super();
    }

    private static function initlize():void {
        var _loc3_:XML = null;
        var _loc1_:XML = XML(new _xmlClass());
        var _loc2_:XMLList = _loc1_.descendants("step");
        for each(_loc3_ in _loc2_) {
            stepMap.add(uint(_loc3_.@id), {
                "des": String(_loc3_.@des),
                "module": String(_loc3_.@module),
                "title": String(_loc3_.@title),
                "para": String(_loc3_.@para)
            });
        }
    }

    public static function getQuestCateogryDes(param1:String):String {
        var _loc2_:String = "";
        switch (param1) {
            case RECOMMEND_QUEST:
                _loc2_ = "这里记录了专为你量身推荐的任务哦！快行动起来吧！Let’s go！";
                break;
            case MAIN_QUEST:
                _loc2_ = "这里记载了赛尔号Ⅱ所发生的点点滴滴，你就是它的主宰者！";
                break;
            case CHAPTER_QUEST:
                _loc2_ = "这只是我们旅程的开始，只有经历了才会了解它……";
                break;
            case STORY_QUEST:
                _loc2_ = "这里撰写了赛尔号Ⅱ里所发生的酸甜苦辣，我们懂得……";
                break;
            case PET_QUEST:
                _loc2_ = "在这里的生活中少不了精灵的相伴，你对他们足够了解了吗？";
                break;
            case ACTIVITY_QUEST:
                _loc2_ = "这里记录着许许多多的新鲜事，和你的朋友、精灵一起来参加吧！";
                break;
            case BRANCH_QUEST:
                _loc2_ = "这里探索未知的任务,获得更丰富的奖励！";
        }
        return _loc2_;
    }

    public static function updateChildren(param1:TreeItem, param2:String):void {
        var treeItem:TreeItem = param1;
        var type:String = param2;
        switch (type) {
            case RECOMMEND_QUEST:
                updateQuestVec(treeItem, getDailyRecommendQuestVec());
                break;
            case MAIN_QUEST:
                updateQuestVec(treeItem, getMiniQuestVec());
                break;
            case STAR_QUEST:
                DayLimitManager.getDoCount(dayLimit, function (param1:uint):void {
                    var _loc5_:Object = null;
                    var _loc6_:Object = null;
                    var _loc2_:Vector.<Object> = new Vector.<Object>();
                    var _loc3_:uint = param1;
                    var _loc4_:int = 0;
                    while (_loc4_ < 10) {
                        _loc5_ = new Object();
                        if (!BitUtil.getBit(_loc3_, _loc4_)) {
                            _loc6_ = stepMap.getValue(_loc4_ + 1);
                            _loc5_.id = -1;
                            _loc5_.title = _loc6_.title;
                            _loc5_.des = _loc6_.des;
                            _loc5_.module = _loc6_.module;
                            _loc5_.para = _loc6_.para;
                            _loc2_.push(_loc5_);
                        }
                        _loc4_++;
                    }
                    updateStarVec(treeItem, _loc2_);
                });
        }
    }

    private static function updateStarVec(param1:TreeItem, param2:Vector.<Object>):void {
        param1.changeToLen(param2.length, QuestTinyItem);
        var _loc3_:int = 0;
        while (_loc3_ < param2.length) {
            param1.getChildItemAt(_loc3_).update(param2[_loc3_]);
            _loc3_++;
        }
    }

    private static function updateQuestVec(param1:TreeItem, param2:Vector.<Quest>):void {
        param1.changeToLen(param2.length, QuestTinyItem);
        var _loc3_:int = 0;
        while (_loc3_ < param2.length) {
            param1.getChildItemAt(_loc3_).update(param2[_loc3_]);
            _loc3_++;
        }
    }

    public static function getRecommendQuestVec():Vector.<Quest> {
        var tmpVec:Vector.<Quest> = null;
        var questVec:Vector.<Quest> = null;
        tmpVec = new Vector.<Quest>();
        questVec = QuestManager.getQuestListByType(QuestType.CHAPTER).concat(QuestManager.getQuestListByType(QuestType.STORY));
        questVec.forEach(function (param1:Quest, param2:int, param3:Vector.<Quest>):void {
            if (param1.status == QuestStatus.IN_PROGRESS) {
                tmpVec.push(param1);
            }
        });
        questVec.forEach(function (param1:Quest, param2:int, param3:Vector.<Quest>):void {
            if (!param1.isNewOnline && param1.status == QuestStatus.ACCEPTABLE) {
                if (!isSpecialTask(param1.id)) {
                    tmpVec.push(param1);
                }
            }
        });
        questVec = QuestManager.getQuestList();
        questVec.forEach(function (param1:Quest, param2:int, param3:Vector.<Quest>):void {
            if (Boolean(param1.isNewOnline) && param1.status == QuestStatus.ACCEPTABLE) {
                if (!isSpecialTask(param1.id)) {
                    tmpVec.push(param1);
                }
            }
        });
        return tmpVec;
    }

    public static function getDailyRecommendQuestVec():Vector.<Quest> {
        var tmpVec:Vector.<Quest> = null;
        tmpVec = new Vector.<Quest>();
        var resultVec:Vector.<Quest> = getRecommendQuestVec().concat(randomQuestVec(getPetQuestVec().concat(getNPCQuestVec())));
        resultVec.forEach(function (param1:Quest, param2:int, param3:Vector.<Quest>):void {
            if (!isSpecialTask(param1.id)) {
                tmpVec.push(param1);
            }
        });
        return sortQuestVec(tmpVec);
    }

    public static function getChapterQuestVec():Vector.<Quest> {
        var resultVec:Vector.<Quest> = null;
        resultVec = new Vector.<Quest>();
        var questVec:Vector.<Quest> = QuestManager.getQuestListByType(QuestType.CHAPTER);
        questVec.forEach(function (param1:Quest, param2:int, param3:Vector.<Quest>):void {
            if (param1.status != QuestStatus.NONE) {
                resultVec.push(param1);
            }
        });
        return sortQuestVec(resultVec);
    }

    public static function getMiniQuestVec():Vector.<Quest> {
        return sortQuestVec(getStoryQuestVec().concat(getBranchQuest()).concat(getActivityQuest()));
    }

    public static function getStoryQuestVec():Vector.<Quest> {
        var resultVec:Vector.<Quest> = null;
        resultVec = new Vector.<Quest>();
        var questVec:Vector.<Quest> = QuestManager.getQuestListByType(QuestType.STORY).concat(getChapterQuestVec());
        questVec.forEach(function (param1:Quest, param2:int, param3:Vector.<Quest>):void {
            if (param1.status != QuestStatus.NONE) {
                if (!isSpecialTask(param1.id)) {
                    resultVec.push(param1);
                }
            }
        });
        return sortQuestVec(resultVec);
    }

    public static function getPetQuestVec():Vector.<Quest> {
        var tmpVec:Vector.<Quest> = null;
        tmpVec = new Vector.<Quest>();
        var questVec:Vector.<Quest> = QuestManager.getQuestListByType(QuestType.PET);
        questVec.forEach(function (param1:Quest, param2:int, param3:Vector.<Quest>):void {
            if (param1.status == QuestStatus.IN_PROGRESS || param1.status == QuestStatus.ACCEPTABLE) {
                tmpVec.push(param1);
            }
        });
        return tmpVec;
    }

    public static function getNPCQuestVec():Vector.<Quest> {
        var tmpVec:Vector.<Quest> = null;
        tmpVec = new Vector.<Quest>();
        var questVec:Vector.<Quest> = QuestManager.getQuestListByType(QuestType.NPC);
        questVec.forEach(function (param1:Quest, param2:int, param3:Vector.<Quest>):void {
            if (param1.status == QuestStatus.IN_PROGRESS || param1.status == QuestStatus.ACCEPTABLE) {
                tmpVec.push(param1);
            }
        });
        return tmpVec;
    }

    private static function getLingShouQuestVec():Vector.<Quest> {
        var tmpVec:Vector.<Quest> = null;
        tmpVec = new Vector.<Quest>();
        var questVec:Vector.<Quest> = QuestManager.getQuestListByType(QuestType.BEAST);
        questVec.forEach(function (param1:Quest, param2:int, param3:Vector.<Quest>):void {
            if (param1.status == QuestStatus.IN_PROGRESS || param1.status == QuestStatus.ACCEPTABLE) {
                tmpVec.push(param1);
            }
        });
        return tmpVec;
    }

    private static function getActivityQuest():Vector.<Quest> {
        var ingVec:Vector.<Quest> = null;
        var acceptVec:Vector.<Quest> = null;
        ingVec = new Vector.<Quest>();
        acceptVec = new Vector.<Quest>();
        var questVec:Vector.<Quest> = QuestManager.getQuestListByType(QuestType.ACTIVITY);
        questVec.forEach(function (param1:Quest, param2:int, param3:Vector.<Quest>):void {
            if (param1.status == QuestStatus.IN_PROGRESS && param1.id != 30001 && param1.id != 30040) {
                if (param1.isInTime) {
                    ingVec.push(param1);
                }
            } else if (param1.status == QuestStatus.ACCEPTABLE && param1.id != 30001 && param1.id != 30040) {
                if (param1.isInTime) {
                    acceptVec.push(param1);
                }
            }
        });
        return ingVec.concat(randomQuestVec(acceptVec));
    }

    private static function getBranchQuest():Vector.<Quest> {
        var ingVec:Vector.<Quest> = null;
        var acceptVec:Vector.<Quest> = null;
        ingVec = new Vector.<Quest>();
        acceptVec = new Vector.<Quest>();
        var questVec:Vector.<Quest> = getLingShouQuestVec().concat(getNPCQuestVec().concat(getPetQuestVec()));
        questVec.forEach(function (param1:Quest, param2:int, param3:Vector.<Quest>):void {
            if (param1.status == QuestStatus.IN_PROGRESS) {
                ingVec.push(param1);
            } else if (param1.status == QuestStatus.ACCEPTABLE) {
                acceptVec.push(param1);
            }
        });
        return ingVec.concat(randomQuestVec(acceptVec));
    }

    private static function randomQuestVec(param1:Vector.<Quest>):Vector.<Quest> {
        var resultVec:Vector.<Quest>;
        var tempVec:Vector.<Quest> = null;
        var index:int = 0;
        var questVec:Vector.<Quest> = param1;
        tempVec = new Vector.<Quest>();
        questVec.forEach(function (param1:Quest, param2:int, param3:Vector.<Quest>):void {
            if (param1.status == QuestStatus.IN_PROGRESS) {
                tempVec.push(param1);
            }
        });
        if (tempVec.length == 0) {
            questVec.forEach(function (param1:Quest, param2:int, param3:Vector.<Quest>):void {
                if (param1.status == QuestStatus.ACCEPTABLE) {
                    tempVec.push(param1);
                }
            });
        }
        resultVec = new Vector.<Quest>();
        if (tempVec.length > 0) {
            index = int(Math.random() * tempVec.length);
            resultVec.push(tempVec[index]);
        }
        return resultVec;
    }

    private static function sortQuestVec(param1:Vector.<Quest>):Vector.<Quest> {
        var resultVec:Vector.<Quest> = null;
        var questVec:Vector.<Quest> = param1;
        resultVec = new Vector.<Quest>();
        questVec.forEach(function (param1:Quest, param2:int, param3:Vector.<Quest>):void {
            if (param1.status == QuestStatus.IN_PROGRESS) {
                resultVec.push(param1);
            }
        });
        questVec.forEach(function (param1:Quest, param2:int, param3:Vector.<Quest>):void {
            if (!param1.isNewOnline && param1.status == QuestStatus.ACCEPTABLE) {
                resultVec.push(param1);
            }
        });
        questVec.forEach(function (param1:Quest, param2:int, param3:Vector.<Quest>):void {
            if (Boolean(param1.isNewOnline) && param1.status == QuestStatus.ACCEPTABLE) {
                resultVec.push(param1);
            }
        });
        return resultVec;
    }

    private static function isSpecialTask(param1:int):Boolean {
        if (param1 == 53 || param1 >= 68 && param1 <= 73 || param1 == 83 || param1 == 86 || param1 == 60 || param1 == 99) {
            return true;
        }
        return false;
    }
}
}
