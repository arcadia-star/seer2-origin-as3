package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.quest.mark.InProgressMark;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;

import flash.display.MovieClip;
import flash.events.MouseEvent;

public class MapProcessor_80369 extends MapProcessor {


    private var _npc:MovieClip;

    public function MapProcessor_80369(param1:MapModel) {
        super(param1);
    }

    override public function dispose():void {
        super.dispose();
    }

    override public function init():void {
        this.createNpc();
        this.showNpc();
    }

    private function createNpc():void {
        var _loc1_:InProgressMark = null;
        if (!this._npc) {
            this._npc = _map.content["npc1025"];
            this._npc.buttonMode = true;
            _loc1_ = new InProgressMark();
            _loc1_.y = -120;
            this._npc.addChild(_loc1_);
            this._npc.visible = false;
            this._npc.addEventListener(MouseEvent.CLICK, this.initStep2Continue);
        }
    }

    private function initStep2Continue(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        if (!QuestManager.isAccepted(87) && QuestManager.isComplete(85)) {
            NpcDialog.show(1025, "废品分装队长", [[0, "我是废品分装队长——在地球清理行动中负责分装回收机器人收集来的垃圾。"]], ["（主线）废墟下的恐怖 ", "你加油"], [function ():void {
                QuestManager.accept(87);
            }, function ():void {
            }]);
        } else {
            NpcDialog.show(1025, "废品分装队长", [[0, "我是废品分装队长——在地球清理行动中负责分装回收机器人收集来的垃圾。"]], ["你加油！！"], [function ():void {
            }]);
        }
    }

    private function showNpc():void {
        if (QuestManager.isComplete(87)) {
            _map.content["npc1025"]["t"].visible = true;
        } else if (QuestManager.isComplete(85) && !QuestManager.isAccepted(87)) {
            _map.content["npc1025"]["t"].visible = true;
        } else {
            _map.content["npc1025"]["t"].visible = false;
        }
    }
}
}
