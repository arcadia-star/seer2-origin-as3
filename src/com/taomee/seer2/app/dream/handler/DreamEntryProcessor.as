package com.taomee.seer2.app.dream.handler {
import com.taomee.seer2.app.dream.DreamManager;
import com.taomee.seer2.app.dream.events.DreamEvent;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.QueueLoader;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.Event;

public class DreamEntryProcessor {

    private static const SLEEPING:String = "sleeping";

    private static const DREAMING:String = "dreaming";


    protected var _category:uint;

    protected var _dreamNpcVec:Vector.<Mobile>;

    private var _closeEye:MovieClip;

    private var _openEye:MovieClip;

    public function DreamEntryProcessor() {
        super();
        DreamManager.dreamNpcCategoryID = this._category;
        this.initActorCloseOpenEye();
    }

    private function initActorCloseOpenEye():void {
        this._closeEye = DreamManager.closeEye;
        this._openEye = DreamManager.openEye;
        if (this._closeEye == null || this._openEye == null) {
            QueueLoader.load(URLUtil.getDreamSceneAnimation(), LoadType.SWF, this.onCloseOpenEyeLoadedComplete);
        } else {
            this.resetCloseOpenEye();
        }
    }

    private function onCloseOpenEyeLoadedComplete(param1:ContentInfo):void {
        var _loc2_:MovieClip = param1.content as MovieClip;
        this._closeEye = DreamManager.closeEye = _loc2_["closeEye"];
        this._openEye = DreamManager.openEye = _loc2_["openEye"];
        this.resetCloseOpenEye();
    }

    private function resetCloseOpenEye():void {
        this._closeEye.gotoAndStop(1);
        this._openEye.gotoAndStop(1);
        if (DreamManager.currentDreamNpcID > 0) {
            LayerManager.topLayer.addChild(this._openEye);
            this._openEye.addEventListener(Event.ENTER_FRAME, this.onOpenedEye);
            this._openEye.play();
        }
        DreamManager.addEventListener(DreamEvent.ENTER_DREAM, this.onActorEnterDream);
        this.processNpc();
    }

    private function processNpc():void {
        this.createNpc();
        this.setNpcAction();
    }

    private function onOpenedEye(param1:Event):void {
        if (this._openEye.currentFrame == this._openEye.totalFrames) {
            this._openEye.removeEventListener(Event.ENTER_FRAME, this.onOpenedEye);
            DisplayObjectUtil.removeFromParent(this._openEye);
            this._openEye = null;
        }
    }

    private function onActorEnterDream(param1:DreamEvent):void {
        DreamManager.removeEventListener(DreamEvent.ENTER_DREAM, this.onActorEnterDream);
        LayerManager.topLayer.addChild(this._closeEye);
        this._closeEye.addEventListener(Event.ENTER_FRAME, this.onClosedEye);
        this._closeEye.play();
    }

    private function onClosedEye(param1:Event):void {
        if (this._closeEye.currentFrame == this._closeEye.totalFrames) {
            this._closeEye.removeEventListener(Event.ENTER_FRAME, this.onClosedEye);
            DisplayObjectUtil.removeFromParent(this._closeEye);
            this._closeEye = null;
            this.enterDreamMap();
        }
    }

    private function clearCloseOpenEye():void {
        if (this._closeEye) {
            this._closeEye.removeEventListener(Event.ENTER_FRAME, this.onClosedEye);
            DisplayObjectUtil.removeFromParent(this._closeEye);
            this._closeEye = null;
        }
        if (this._openEye) {
            this._openEye.removeEventListener(Event.ENTER_FRAME, this.onOpenedEye);
            DisplayObjectUtil.removeFromParent(this._openEye);
            this._openEye = null;
        }
    }

    private function enterDreamMap():void {
        var _loc1_:uint = this.getDreamMapID();
        SceneManager.changeScene(SceneType.LOBBY, _loc1_);
    }

    protected function getDreamMapID():uint {
        return 0;
    }

    protected function createNpc():void {
    }

    private function clearNpc():void {
        var _loc1_:uint = 0;
        var _loc2_:uint = 0;
        if (Boolean(this._dreamNpcVec) && Boolean(this._dreamNpcVec.length)) {
            _loc1_ = this._dreamNpcVec.length;
            _loc2_ = 0;
            while (_loc2_ < _loc1_) {
                MobileManager.removeMobile(this._dreamNpcVec[_loc2_], MobileType.NPC);
                _loc2_++;
            }
        }
        this._dreamNpcVec = null;
    }

    private function setNpcAction():void {
        if (DreamManager.isDreamingAvalueable() == true) {
            this.setDreamNpcAction();
        } else {
            this.setAllSleepAction();
        }
    }

    private function setDreamNpcAction():void {
        var _loc1_:Boolean = false;
        var _loc2_:int = Math.floor(Math.random() * this._dreamNpcVec.length);
        var _loc3_:uint = 0;
        while (_loc3_ < this._dreamNpcVec.length) {
            if (this._dreamNpcVec[_loc3_].id == DreamManager.currentDreamNpcID) {
                this._dreamNpcVec[_loc3_].action = SLEEPING;
                DreamManager.currentDreamNpcID = 0;
                _loc1_ = true;
            } else {
                this._dreamNpcVec[_loc3_].action = DREAMING;
            }
            _loc3_++;
        }
        if (_loc1_ == false) {
            this._dreamNpcVec[_loc2_].action = SLEEPING;
        }
    }

    private function setAllSleepAction():void {
        DreamManager.currentDreamNpcID = 0;
        var _loc1_:uint = 0;
        while (_loc1_ < this._dreamNpcVec.length) {
            this._dreamNpcVec[_loc1_].action = SLEEPING;
            _loc1_++;
        }
    }

    public function dispose():void {
        DreamManager.removeEventListener(DreamEvent.ENTER_DREAM, this.onActorEnterDream);
        this.clearCloseOpenEye();
        this.clearNpc();
    }
}
}
