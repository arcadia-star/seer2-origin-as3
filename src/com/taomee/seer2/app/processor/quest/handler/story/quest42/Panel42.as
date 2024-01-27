package com.taomee.seer2.app.processor.quest.handler.story.quest42 {
import com.taomee.seer2.app.serverBuffer.ServerBuffer;
import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
import com.taomee.seer2.app.serverBuffer.ServerBufferType;
import com.taomee.seer2.core.map.ResourceLibrary;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;

import org.taomee.utils.AlignType;
import org.taomee.utils.DisplayUtil;

public class Panel42 {


    private const gotoMapList:Vector.<uint> = Vector.<uint>([110, 160, 192, 470, 320, 540, 660]);

    private var _resLib:ResourceLibrary;

    private var _panel:MovieClip;

    private var _closeBtn:SimpleButton;

    private var _npcMCList:Vector.<MovieClip>;

    public function Panel42(param1:ResourceLibrary) {
        super();
        this._resLib = param1;
        this.init();
    }

    private function init():void {
        this.initMC();
    }

    private function initMC():void {
        this._panel = this._resLib.getMovieClip("mc_0");
        this._npcMCList = Vector.<MovieClip>([]);
        var _loc1_:int = 0;
        while (_loc1_ < 7) {
            this._npcMCList.push(this._panel["npc" + _loc1_]);
            _loc1_++;
        }
        this._closeBtn = this._panel["closeBtn"];
        this.initEvent();
        this.initServer();
        this.showPanel();
    }

    private function initEvent():void {
        var _loc1_:MovieClip = null;
        this._closeBtn.addEventListener(MouseEvent.CLICK, this.onClose);
        for each(_loc1_ in this._npcMCList) {
            if (_loc1_.currentFrame == 1) {
                _loc1_["goBtn"].addEventListener(MouseEvent.CLICK, this.onGoto);
            }
        }
    }

    private function onGoto(param1:MouseEvent):void {
        var _loc2_:uint = this._npcMCList.indexOf(param1.currentTarget.parent as MovieClip);
        SceneManager.changeScene(SceneType.LOBBY, this.gotoMapList[_loc2_]);
        this.dispose();
    }

    private function initServer():void {
        ServerBufferManager.getServerBuffer(ServerBufferType.QUEST_BUF_42, this.getServer, false);
    }

    private function getServer(param1:ServerBuffer):void {
        var _loc3_:int = 0;
        var _loc2_:int = 0;
        while (_loc2_ < this.gotoMapList.length) {
            _loc3_ = param1.readDataAtPostion(_loc2_);
            if (_loc3_ == 1) {
                this._npcMCList[_loc2_].gotoAndStop(2);
            } else {
                this._npcMCList[_loc2_].gotoAndStop(1);
            }
            _loc2_++;
        }
    }

    private function onClose(param1:MouseEvent):void {
        this.dispose();
    }

    private function showPanel():void {
        LayerManager.topLayer.addChild(this._panel);
        DisplayUtil.align(this._panel, AlignType.MIDDLE_CENTER);
    }

    private function removeEvent():void {
        var _loc1_:MovieClip = null;
        if (this._closeBtn) {
            this._closeBtn.removeEventListener(MouseEvent.CLICK, this.onClose);
        }
        for each(_loc1_ in this._npcMCList) {
            if (_loc1_.currentFrame == 1) {
                _loc1_["goBtn"].removeEventListener(MouseEvent.CLICK, this.onGoto);
            }
        }
    }

    public function dispose():void {
        this.removeEvent();
        DisplayUtil.removeForParent(this._panel);
        this._panel = null;
        this._closeBtn = null;
        this._npcMCList = null;
    }
}
}
