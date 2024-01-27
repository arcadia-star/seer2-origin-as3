package com.taomee.seer2.app.processor.quest.handler.branch.quest10200 {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.pet.data.PetInfo;
import com.taomee.seer2.app.pet.data.PetInfoManager;
import com.taomee.seer2.app.pet.events.PetInfoEvent;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.quest.mark.AcceptableMark;
import com.taomee.seer2.app.utils.NpcUtil;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_10200_2911 extends QuestMapHandler {

    public static var isGame:Boolean = false;

    private static var _questFight:Boolean = false;


    private var _mc3:MovieClip;

    private var _mc4:MovieClip;

    private var _processorMark:AcceptableMark;

    public function QuestMapHandler_10200_2911(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isStepComplete(10200, 1) && QuestManager.isStepComplete(10200, 2) == false) {
            if (SceneManager.prevSceneType == SceneType.ARENA && _questFight) {
                _questFight = false;
                this.nextQuest4();
            } else {
                this.nextQuest2();
            }
        }
    }

    private function nextQuest2():void {
        this._processorMark = new AcceptableMark();
        this._processorMark.x = 556;
        this._processorMark.y = 290;
        _map.front.addChild(this._processorMark);
        this._mc3 = _processor.resLib.getMovieClip("mc3");
        _map.content.addChild(this._mc3);
        this._mc3.addEventListener(MouseEvent.CLICK, this.onMC3);
    }

    private function nextQuest4():void {
        this._processorMark = new AcceptableMark();
        this._processorMark.x = 623;
        this._processorMark.y = 259;
        _map.content.addChild(this._processorMark);
        this._mc4 = _processor.resLib.getMovieClip("mc4");
        _map.content.addChild(this._mc4);
        this._mc3.removeEventListener(MouseEvent.CLICK, this.onMC3);
        this._mc4.addEventListener(MouseEvent.CLICK, this.onMC4);
    }

    private function onMC4(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        DisplayUtil.removeForParent(this._processorMark);
        NpcDialog.show(603, "幽冥", [[0, "滚回你们船长那里去！告诉他们，我——幻灵骑士团——幻翼幽冥来了！"]], ["太狂妄了！"], [function ():void {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStepComplete);
            QuestManager.completeStep(_quest.id, 2);
        }]);
    }

    private function onStepComplete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
        SceneManager.changeScene(SceneType.LOBBY, 10);
    }

    private function onMC3(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        DisplayUtil.removeForParent(this._processorMark);
        NpcDialog.show(414, "尤尼", [[0, "干……嘛……啊……？"]], ["小伙伴，请问？"], [function ():void {
            NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[0, "你看到什么了幽冥了吗？我看它是往这个方向过来的！"]], ["幽冥！？幻灵骑士团的幽冥？"], [function ():void {
                NpcDialog.show(414, "尤尼", [[0, "那你可问对了！看见这里石头的符号了吗？幽冥身上也有！"]], ["哦？什么情况？"], [function ():void {
                    NpcDialog.show(414, "尤尼", [[0, "幽冥所在的星球早就毁灭了，这些石头就是它们星球掉落在我们这里的残骸，它们被萨伦训练成残暴的悍血骑士的！"]], ["我上哪里找到它啊？急人啊！"], [function ():void {
                        NpcDialog.show(414, "尤尼", [[0, "幽冥只能召唤，看你长的挺善良的，给你一些符文牌吧，你自己去试试吧！"]], ["好！快给我，让我试试！谢谢了！"], [function ():void {
                            var _loc1_:* = new Object();
                            _loc1_.fun = onFun;
                            ModuleManager.showModule(URLUtil.getAppModule("EidolonGamePanel"), "正在打开面板...", _loc1_);
                        }]);
                    }]);
                }]);
            }]);
        }]);
    }

    private function onFun():void {
        if (isGame) {
            if (PetInfoManager.getFirstPetInfo().hp <= 0) {
                Connection.addCommandListener(CommandSet.TREAT_ALL_PET_1215, this.onAddAllPetBlood);
                Connection.send(CommandSet.TREAT_ALL_PET_1215);
            } else {
                FightManager.startFightWithWild(542);
                _questFight = true;
                QuestMapHandler_10200_2911.isGame = false;
            }
        } else if (Boolean(_map) && Boolean(_map.front)) {
            _map.front.addChild(this._processorMark);
        }
    }

    private function onAddAllPetBlood(param1:MessageEvent):void {
        var _loc3_:PetInfo = null;
        var _loc4_:int = 0;
        Connection.removeCommandListener(CommandSet.TREAT_ALL_PET_1215, this.onAddAllPetBlood);
        var _loc2_:Vector.<PetInfo> = PetInfoManager.getAllBagPetInfo();
        for each(_loc3_ in _loc2_) {
            _loc3_.hp = _loc3_.maxHp;
            PetInfoManager.dispatchEvent(PetInfoEvent.PET_PROPERTIES_CHANGE, _loc3_);
        }
        _loc4_ = int(param1.message.getRawData().readUnsignedInt());
        ActorManager.actorInfo.coins = _loc4_;
        FightManager.startFightWithWild(542);
        _questFight = true;
        QuestMapHandler_10200_2911.isGame = false;
    }

    override public function processMapDispose():void {
        DisplayUtil.removeForParent(this._mc3);
        DisplayUtil.removeForParent(this._mc4);
        DisplayUtil.removeForParent(this._processorMark);
        super.processMapDispose();
    }
}
}
