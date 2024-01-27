package com.taomee.seer2.app.processor.activity.specialPetAct {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.component.MouseClickHintSprite;
import com.taomee.seer2.app.manager.DayLimitManager;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.QueueLoader;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.system.ApplicationDomain;

import org.taomee.utils.DisplayUtil;
import org.taomee.utils.DomainUtil;

public class SpecialPetOneAct {


    private var _resLib:ApplicationDomain;

    private var _mapModel:MapModel;

    private var _mouseHint:Sprite;

    private var _boss:MovieClip;

    private const FIGHT_DAY:int = 741;

    private const INDEX_LIST:Vector.<int> = Vector.<int>([525, 524]);

    public function SpecialPetOneAct(param1:MapModel) {
        super();
        this._mapModel = param1;
        this.afterFightTipHandle(this.getURL);
    }

    private function getURL():void {
        QueueLoader.load(URLUtil.getActivityAnimation("specialPetAct/specialPetAct"), LoadType.SWF, function (param1:ContentInfo):void {
            _resLib = param1.domain;
            init();
        });
    }

    private function init():void {
        this._boss = this.getMovie("Boss");
        this._boss.buttonMode = true;
        (this._boss["bloodShow"] as MovieClip).visible = false;
        (this._boss["tip"] as MovieClip).stop();
        (this._boss["tip"] as MovieClip).visible = false;
        this._mapModel.content.addChild(this._boss);
        this.showMouseHint(this._boss);
        this._boss.addEventListener(MouseEvent.CLICK, this.onBossClick);
    }

    private function afterFightTipHandle(param1:Function):void {
        var func:Function = param1;
        if (SceneManager.prevSceneType == SceneType.ARENA && this.INDEX_LIST.indexOf(FightManager.currentFightRecord.initData.positionIndex) != -1) {
            DayLimitManager.getDoCount(this.FIGHT_DAY, function (param1:int):void {
                var _loc2_:int = 0;
                if (ActorManager.actorInfo.vipInfo.isVip()) {
                    _loc2_ = 15 - param1;
                } else {
                    _loc2_ = 10 - param1;
                }
                if (_loc2_ > 0) {
                    ServerMessager.addMessage("今天还剩" + _loc2_ + "次挑战机会!");
                    func();
                } else {
                    SceneManager.changeScene(SceneType.LOBBY, 70);
                }
            });
        } else {
            func();
        }
    }

    private function showMouseHint(param1:MovieClip):void {
        if (!this._mouseHint) {
            this._mouseHint = new MouseClickHintSprite();
            this._mouseHint.y = -this._mouseHint.height + 50;
            this._mouseHint.x = (param1.width - this._mouseHint.width) / 2 + 27;
        }
        param1.addChild(this._mouseHint);
    }

    private function hideMouseHint():void {
        DisplayUtil.removeForParent(this._mouseHint);
        this._mouseHint = null;
    }

    private function onBossClick(param1:MouseEvent):void {
        this.hideMouseHint();
        ModuleManager.showModule(URLUtil.getAppModule("SpecialPetActFightPanel"), "正在打开稀有精灵单人挑战面板...", 1);
    }

    private function getMovie(param1:String):MovieClip {
        if (this._resLib) {
            return DomainUtil.getMovieClip(param1, this._resLib);
        }
        return null;
    }

    public function dispose():void {
        if (this._boss) {
            this._boss.removeEventListener(MouseEvent.CLICK, this.onBossClick);
            DisplayUtil.removeForParent(this._boss);
            this._boss = null;
        }
        this.hideMouseHint();
    }
}
}
