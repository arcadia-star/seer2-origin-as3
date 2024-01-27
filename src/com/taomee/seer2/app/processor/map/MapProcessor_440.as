package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.manager.InteractiveRewardManager;
import com.taomee.seer2.app.net.parser.Parser_1060;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.ui.UIManager;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class MapProcessor_440 extends MapProcessor {


    private var _activityDialogPanel:MovieClip;

    private var _activityVoidPanel:MovieClip;

    private var _yesBtn:SimpleButton;

    private var _noBtn:SimpleButton;

    private var _yesVoidBtn:SimpleButton;

    private var _stench:MovieClip;

    public function MapProcessor_440(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this._activityDialogPanel = _map.front["activityDialogPanel"];
        this._activityVoidPanel = _map.front["activityVoidPanel"];
        this._activityVoidPanel.visible = false;
        if (SceneManager.prevSceneType == SceneType.ARENA && FightManager.fightWinnerSide == FightSide.LEFT) {
            if (this.isShowActivityPanel()) {
                this.showActivityPanel();
            } else {
                this._activityDialogPanel.visible = false;
            }
        } else {
            this._activityVoidPanel.visible = false;
            this._activityDialogPanel.visible = false;
        }
    }

    private function isShowActivityPanel():Boolean {
        var _loc1_:Number = Math.random() * 100;
        if (_loc1_ > 50) {
            return true;
        }
        return false;
    }

    private function showActivityPanel():void {
        this._activityDialogPanel.visible = true;
        this._yesBtn = this._activityDialogPanel["yesBtn"];
        this._noBtn = this._activityDialogPanel["noBtn"];
        this._yesBtn.addEventListener(MouseEvent.CLICK, this.onYes);
        this._noBtn.addEventListener(MouseEvent.CLICK, this.onNo);
    }

    private function onYes(param1:MouseEvent):void {
        this._yesBtn.removeEventListener(MouseEvent.CLICK, this.onYes);
        this._noBtn.removeEventListener(MouseEvent.CLICK, this.onNo);
        this._activityDialogPanel.visible = false;
        InteractiveRewardManager.requestReward(18, this.onGetGift);
    }

    private function onGetGift(param1:Parser_1060):void {
        if (param1.addItemVec[0].id == 13) {
            this.showVoidPanel();
        } else {
            param1.showResult(true, this.showStench);
        }
    }

    private function showStench():void {
        ServerMessager.addMessage("你身上闻起来很特别！");
        this._stench = UIManager.getMovieClip("UI_Stench");
        ActorManager.getActor().addChild(this._stench);
        this._stench.y = -10;
    }

    private function showVoidPanel():void {
        this._activityVoidPanel.visible = true;
        this._yesVoidBtn = this._activityVoidPanel["yesBtn"];
        this._yesVoidBtn.addEventListener(MouseEvent.CLICK, this.onVoidYes);
    }

    private function onVoidYes(param1:MouseEvent):void {
        this._yesVoidBtn.removeEventListener(MouseEvent.CLICK, this.onVoidYes);
        this._activityVoidPanel.visible = false;
    }

    private function onNo(param1:MouseEvent):void {
        this._activityDialogPanel.visible = false;
        this._yesBtn.removeEventListener(MouseEvent.CLICK, this.onYes);
        this._noBtn.removeEventListener(MouseEvent.CLICK, this.onNo);
    }

    override public function dispose():void {
        if (Boolean(this._stench) && Boolean(this._stench.parent)) {
            DisplayUtil.removeForParent(this._stench);
            this._stench = null;
        }
        this._yesBtn = null;
        this._noBtn = null;
        this._yesVoidBtn = null;
        this._activityDialogPanel.visible = false;
        this._activityDialogPanel = null;
        this._activityVoidPanel.visible = false;
        this._activityVoidPanel = null;
        super.dispose();
    }
}
}
