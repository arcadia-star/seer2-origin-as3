package com.taomee.seer2.app.processor.quest.handler.branch.quest10118 {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.controls.PetAvatarPanel;
import com.taomee.seer2.app.controls.ToolBar;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.lobby.LobbyScene;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.quest.mark.AcceptableMark;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_10118_1012 extends QuestMapHandler {

    private static const FIGHT_INDEX:int = 144;

    private static const STEP_ID:int = 2;

    private static const STEP_DATA_INDEX:int = 0;

    private static const SOLDIER_NUM:uint = 5;

    private static const PREFIX:String = "s";

    private static var _whichSoldier:String;


    private var _serverFightMsg:String = null;

    private var _questUi:MovieClip;

    private var _accpetableMark:AcceptableMark;

    private var _isTalked:Boolean = false;

    private var _stoneMc:MovieClip;

    public function QuestMapHandler_10118_1012(param1:QuestProcessor) {
        super(param1);
    }

    public static function hideToolBar():void {
        (SceneManager.active as LobbyScene).hideToolbar();
        PetAvatarPanel.show();
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(_quest.id) && !QuestManager.isComplete(_quest.id)) {
            this.backFromFightScene();
            this.initUI();
            this.filterSoldierMc();
            DialogPanel.addEventListener(DialogPanelEvent.DIALOG_CLOSED, this.dialogClose);
        }
    }

    private function dialogClose(param1:Event):void {
        ToolBar.hide();
    }

    private function backFromFightScene():void {
        var _loc1_:int = int(FightManager.currentFightRecord.initData.positionIndex);
        if (FIGHT_INDEX == _loc1_) {
            if (SceneManager.prevSceneType == SceneType.ARENA) {
                this.saveFightData();
            }
        }
    }

    private function initUI():void {
        this._questUi = _processor.resLib.getMovieClip("QuestUI_10115");
        var _loc1_:int = 1;
        while (_loc1_ <= SOLDIER_NUM) {
            this._questUi[PREFIX + _loc1_].addEventListener(MouseEvent.CLICK, this.startFight);
            (this._questUi[PREFIX + _loc1_] as MovieClip).buttonMode = true;
            _loc1_++;
        }
        this._questUi["npc"].addEventListener(MouseEvent.CLICK, this.startTalk);
        (this._questUi["npc"] as MovieClip).buttonMode = true;
        LayerManager.uiLayer.addChild(this._questUi);
        this._accpetableMark = new AcceptableMark();
        LayerManager.uiLayer.addChild(this._accpetableMark);
        this._accpetableMark.x = 730;
        this._accpetableMark.y = 170;
    }

    private function startTalk(param1:MouseEvent):void {
        var visibleCount:int;
        var event:MouseEvent = param1;
        DisplayUtil.removeForParent(this._accpetableMark);
        this._isTalked = true;
        visibleCount = this.isStepIComplete();
        if (0 == visibleCount) {
            NpcDialog.show(18, "斯力普", [[5, "哈哈哈哈！你以为你已将黑暗消除殆尽了吗？接下来就来欣赏你自己内心潜藏的黑暗吧！！哈哈哈！"]], ["啊啊！我怎么了！"], [function ():void {
                hideToolBar();
                DisplayObjectUtil.removeFromParent(_questUi);
                playFullMovieI();
            }]);
        } else if (SOLDIER_NUM == visibleCount) {
            NpcDialog.show(18, "斯力普", [[5, "我怎么醒不过来了？难道是可恶萨伦帝国在搞鬼？快把它们给我清除掉吧！哈哈哈！"]], ["奇怪……怎么睡着了还能说话！先干掉萨伦再说吧。"], [function ():void {
                hideToolBar();
            }]);
        } else {
            NpcDialog.show(18, "斯力普", [[5, "快！将这些黑暗的士兵清除掉！没有多少时间了！"]], ["奇怪……怎么睡着了还能说话！先干掉萨伦再说吧。"], [function ():void {
                hideToolBar();
            }]);
        }
    }

    private function playFullMovieI():void {
        MovieClipUtil.playFullScreen(URLUtil.getRes("active/fullScreen/10118_1.swf"), function ():void {
            showStone();
        });
    }

    private function filterSoldierMc():void {
        var _loc2_:int = 0;
        var _loc3_:String = null;
        var _loc1_:int = int(_quest.getStepData(STEP_ID, STEP_DATA_INDEX));
        if (_loc1_) {
            this._serverFightMsg = _loc1_.toString();
            _loc2_ = 0;
            while (_loc2_ < this._serverFightMsg.length) {
                _loc3_ = this._serverFightMsg.charAt(_loc2_);
                this._questUi[PREFIX + _loc3_].removeEventListener(MouseEvent.CLICK, this.startFight);
                DisplayUtil.removeForParent(this._questUi[PREFIX + _loc3_]);
                _loc2_++;
            }
        }
    }

    private function startFight(param1:MouseEvent):void {
        if (this._isTalked) {
            _whichSoldier = param1.currentTarget.name;
            FightManager.startFightWithWild(FIGHT_INDEX);
        }
    }

    private function saveFightData():void {
        var _loc2_:int = 0;
        var _loc1_:int = parseInt(_whichSoldier.charAt(_whichSoldier.length - 1));
        if (this._serverFightMsg) {
            _loc2_ = parseInt(this._serverFightMsg);
            _loc2_ = _loc2_ * 10 + _loc1_;
        } else {
            _loc2_ = _loc1_;
        }
        _quest.setStepData(STEP_ID, STEP_DATA_INDEX, _loc2_);
        this._serverFightMsg = _loc2_.toString();
    }

    protected function showStone():void {
        this._stoneMc = _processor.resLib.getMovieClip("stoneMc");
        this._stoneMc.buttonMode = true;
        _map.front.addChild(this._stoneMc);
        MovieClipUtil.playMc(this._stoneMc, 1, this._stoneMc.totalFrames, function ():void {
            _stoneMc.gotoAndStop(_stoneMc.totalFrames);
            _stoneMc.addEventListener(MouseEvent.CLICK, clickStone);
        }, true);
    }

    protected function clickStone(param1:MouseEvent):void {
        this._stoneMc.removeEventListener(MouseEvent.CLICK, this.clickStone);
        ModuleManager.toggleModule(URLUtil.getAppModule("StonePanel"), "打开中...", {
            "toHome": true,
            "completeQuestId": 10118,
            "completeStep": 1
        });
    }

    private function isStepIComplete():int {
        var _loc1_:int = 0;
        var _loc2_:int = 1;
        while (_loc2_ <= SOLDIER_NUM) {
            if (this._questUi[PREFIX + _loc2_].parent) {
                _loc1_++;
            }
            _loc2_++;
        }
        return _loc1_;
    }

    override public function processMapDispose():void {
        DialogPanel.removeEventListener(DialogPanelEvent.DIALOG_CLOSED, this.dialogClose);
        DisplayObjectUtil.removeFromParent(this._questUi);
    }
}
}
