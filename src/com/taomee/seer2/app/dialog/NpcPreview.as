package com.taomee.seer2.app.dialog {
import com.taomee.seer2.core.cache.CacheManager;
import com.taomee.seer2.core.cache.CacheType;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.ui.UIManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.text.TextField;

public class NpcPreview extends Sprite {


    private var _npcId:int;

    private var _npcName:String;

    private var _emotionId:int;

    private var _npcPreviewUrl:String;

    private var _decoration:DisplayObject;

    private var _npcContent:DisplayObject;

    public function NpcPreview() {
        super();
        this.initialize();
    }

    private function initialize():void {
        DisplayObjectUtil.disableSprite(this);
    }

    public function update(param1:String, param2:int, param3:int):void {
        if (param2 == this._npcId && param3 == this._emotionId) {
            return;
        }
        this._npcId = param2;
        this._npcName = param1;
        this._emotionId = param3;
        this.clear();
        this.updateNameDecoration();
        this._npcPreviewUrl = this.generatePreviewId(param2, param3);
        CacheManager.getContent(URLUtil.getNpcPreview(this._npcPreviewUrl), CacheType.PHASOR, this.onComplete);
    }

    private function onComplete(param1:ContentInfo):void {
        if (this._npcContent != null) {
            DisplayObjectUtil.removeFromParent(this._npcContent);
        }
        this._npcContent = param1.content;
        addChildAt(this._npcContent, getChildIndex(this._decoration));
    }

    private function generatePreviewId(param1:int, param2:int):String {
        return param1.toString() + "_" + param2.toString();
    }

    private function updateNameDecoration():void {
        if (this._decoration == null) {
            this._decoration = UIManager.getMovieClip("UI_DialogDecoration");
            this._decoration.x = -80;
            addChild(this._decoration);
        }
        var _loc1_:TextField = this._decoration["nameTxt"];
        _loc1_.text = this._npcName;
    }

    private function clear():void {
        if (this._npcPreviewUrl != null) {
            CacheManager.cancel(this._npcPreviewUrl, CacheType.PHASOR, this.onComplete);
        }
        if (this._npcContent != null) {
            DisplayObjectUtil.removeFromParent(this._npcContent);
        }
    }
}
}
