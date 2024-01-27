package com.taomee.seer2.app.processor.quest.handler.branch.quest10034 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.NpcUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_10034_211 extends QuestMapHandler {


    private var _npc:MovieClip;

    private var _mc_1:MovieClip;

    public function QuestMapHandler_10034_211(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id, 1) == false) {
            this.initNpc();
        }
    }

    private function initNpc():void {
        this._npc = _processor.resLib.getMovieClip("npc");
        _map.front.addChild(this._npc);
        this._npc.buttonMode = true;
        this._npc.addEventListener(MouseEvent.CLICK, this.onClick);
    }

    private function onClick(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        NpcDialog.show(405, "阿宝", [[0, "钱啊钱啊钱！你们如果会报数那该有多好！哎哟！圣诞老公公你帮我算账吧……我到底有多少零用钱内？"]], ["我来帮你吧！"], [function ():void {
            _mc_1 = _processor.resLib.getMovieClip("mc1");
            _map.front.addChild(_mc_1);
            NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[0, "到底是多少呢？肯定有简单的公式可以算的！"]], ["(1+99)*99/2=4950", "99*100-99=9801", "(1+100)*100/2=5050"], [function ():void {
                DisplayUtil.removeForParent(_mc_1);
                NpcDialog.show(405, "阿宝", [[0, "哇哦！阿宝可是大财主！阿宝有很多money！阿宝是有钱人！！！！哈哈哈！！！"]], ["小财迷……"], [function ():void {
                    QuestManager.completeStep(_quest.id, 1);
                    DisplayUtil.removeForParent(_npc);
                }]);
            }, function ():void {
                DisplayUtil.removeForParent(_mc_1);
                NpcDialog.show(405, "阿宝", [[0, "咦？左算右算好似不对耶！你……你是不是算错啦？"]], ["我再试试看！"]);
            }, function ():void {
                DisplayUtil.removeForParent(_mc_1);
                NpcDialog.show(405, "阿宝", [[0, "咦？左算右算好似不对耶！你……你是不是算错啦？"]], ["我再试试看！"]);
            }]);
        }]);
    }

    override public function processMapDispose():void {
        DisplayUtil.removeForParent(this._npc);
        this._npc = null;
        DisplayUtil.removeForParent(this._mc_1);
        this._mc_1 = null;
    }
}
}
