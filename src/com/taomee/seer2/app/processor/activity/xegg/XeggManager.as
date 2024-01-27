package com.taomee.seer2.app.processor.activity.xegg {
import com.taomee.seer2.app.inventory.ItemManager;
import com.taomee.seer2.app.inventory.events.ItemEvent;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.rightToolbar.RightToolbarConter;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.quest.events.QuestEvent;

import flash.utils.setTimeout;

public class XeggManager {

    private static const dayList:Vector.<uint> = Vector.<uint>([1, 2, 3, 4, 5, 6]);

    private static const questList:Vector.<uint> = Vector.<uint>([30031, 30032, 30033, 30034, 30035, 30036]);


    public function XeggManager() {
        super();
    }

    public static function startXegg():void {
        XeggHome.setup();
        ItemManager.addEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS, onSeer);
        ItemManager.requestSpecialItemList();
    }

    private static function onSeer(param1:ItemEvent):void {
        var date:Date = null;
        var index:int = 0;
        var i:int = 0;
        var event:ItemEvent = param1;
        ItemManager.removeEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS, onSeer);
        if (ItemManager.getSpecialItem(500514)) {
            date = new Date(TimeManager.getServerTime() * 1000);
            index = dayList.indexOf(date.date);
            if (date.date != 31 && date.date > 6) {
                index = 5;
            }
            i = 0;
            while (i < index + 1) {
                if (QuestManager.isCanAccepted(questList[i])) {
                    QuestManager.addEventListener(QuestEvent.ACCEPT, onAccept);
                    QuestManager.accept(questList[i]);
                    break;
                }
                if (QuestManager.isAccepted(questList[i])) {
                    setTimeout(function ():void {
                        RightToolbarConter.instance.toolbarLight("xeggToolbar");
                    }, 2000);
                    break;
                }
                i++;
            }
        }
    }

    private static function onAccept(param1:QuestEvent):void {
        var event:QuestEvent = param1;
        setTimeout(function ():void {
            RightToolbarConter.instance.toolbarLight("xeggToolbar");
        }, 2000);
    }
}
}
