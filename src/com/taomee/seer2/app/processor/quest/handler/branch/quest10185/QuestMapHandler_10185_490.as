package com.taomee.seer2.app.processor.quest.handler.branch.quest10185 {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.pet.MonsterManager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.quest.mark.AcceptableMark;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

public class QuestMapHandler_10185_490 extends QuestMapHandler {


    private const monkeyID:int = 577;

    private const mcName1:String = "ThrowBanana";

    private const mcName2:String = "PickupBanana";

    private var monkeyMobile:Mobile;

    private var mark:AcceptableMark;

    private var sceneMc:MovieClip;

    private var bananaList:Vector.<MovieClip>;

    public function QuestMapHandler_10185_490(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapDispose():void {
        var _loc1_:int = 0;
        super.processMapDispose();
        MonsterManager.showAllMonster();
        if (this.monkeyMobile) {
            this.monkeyMobile.removeEventListener(MouseEvent.CLICK, this.clickMonkey);
        }
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.completeStep);
        if (this.bananaList) {
            _loc1_ = 0;
            while (_loc1_ < this.bananaList.length) {
                this.bananaList[_loc1_].removeEventListener(MouseEvent.CLICK, this.pickupBanana);
                _loc1_++;
            }
        }
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (isNeedCompleteStep(1)) {
            this.createMonkey();
            MonsterManager.hideAllMonster();
        }
    }

    private function createMonkey():void {
        this.monkeyMobile = new Mobile();
        this.monkeyMobile.resourceUrl = URLUtil.getNpcSwf(this.monkeyID);
        this.monkeyMobile.x = 420;
        this.monkeyMobile.y = 235;
        this.monkeyMobile.height = 100;
        this.monkeyMobile.mouseChildren = false;
        this.monkeyMobile.buttonMode = true;
        this.mark = new AcceptableMark();
        this.monkeyMobile.addOverHeadMark(this.mark);
        MobileManager.addMobile(this.monkeyMobile, MobileType.NPC);
        this.monkeyMobile.addEventListener(MouseEvent.CLICK, this.clickMonkey);
    }

    private function clickMonkey(param1:MouseEvent):void {
        this.sceneMc = _processor.resLib.getMovieClip(this.mcName1);
        _map.front.addChild(this.sceneMc);
        this.monkeyMobile.visible = false;
        MovieClipUtil.playMc(this.sceneMc, 1, this.sceneMc.totalFrames, this.throwBananaComplete, true);
    }

    private function throwBananaComplete():void {
        this.monkeyMobile.visible = true;
        this.monkeyMobile.mouseEnabled = false;
        DisplayObjectUtil.removeFromParent(this.sceneMc);
        this.sceneMc = _processor.resLib.getMovieClip(this.mcName2);
        this.bananaList = new Vector.<MovieClip>();
        var _loc1_:int = 0;
        while (_loc1_ < 3) {
            this.bananaList.push(this.sceneMc["banana" + _loc1_]);
            this.bananaList[_loc1_].gotoAndStop(1);
            _loc1_++;
        }
        _map.front.addChild(this.sceneMc);
        this.lightBanana(this.bananaList[0]);
    }

    private function lightBanana(param1:MovieClip):void {
        param1.buttonMode = true;
        param1.mouseChildren = false;
        param1.gotoAndStop(2);
        param1.addEventListener(MouseEvent.CLICK, this.pickupBanana);
    }

    private function pickupBanana(param1:MouseEvent):void {
        var _loc2_:int = this.bananaList.indexOf(param1.target as MovieClip);
        var _loc3_:MovieClip = this.bananaList[_loc2_];
        _loc3_.removeEventListener(MouseEvent.CLICK, this.pickupBanana);
        _loc3_.stop();
        DisplayObjectUtil.removeFromParent(_loc3_);
        if (_loc2_ == 2) {
            DisplayObjectUtil.removeFromParent(this.sceneMc);
            this.showMonkeyDia();
        } else {
            _loc2_++;
            _loc3_ = this.bananaList[_loc2_];
            this.lightBanana(_loc3_);
        }
    }

    private function showMonkeyDia():void {
        NpcDialog.show(this.monkeyID, "火爆猴", [[0, "叫你捡个香蕉皮都这么慢！你到底是不是机器人啊你！"]], ["明明是你扔的……"], [function ():void {
            var seerId:* = undefined;
            if (ActorManager.actorInfo.sex == 1) {
                seerId = 501;
            } else {
                seerId = 502;
            }
            NpcDialog.show(seerId, "小赛尔", [[0, "小猴子，你好凶，有什么不开心的事情吗？"]], ["开心的事情？！"], [function ():void {
                NpcDialog.show(monkeyID, "火爆猴", [[0, "我最开心的事情就是发火！你懂吗！发火火火！！别来教训我，你们最好都离我远点！"]], ["不如，我带你去个好地方，你一定会开心的！"], [playFull]);
            }]);
        }]);
    }

    private function playFull():void {
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10185_0"), function ():void {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, completeStep);
            QuestManager.completeStep(questID, 1);
        }, true, true);
    }

    private function completeStep(param1:QuestEvent):void {
        if (param1.questId == questID && param1.stepId == 1) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.completeStep);
            SceneManager.changeScene(SceneType.LOBBY, 340);
        }
    }
}
}
