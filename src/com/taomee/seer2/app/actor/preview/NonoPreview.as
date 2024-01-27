package com.taomee.seer2.app.actor.preview {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.component.IconDisplayer;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.Sprite;

import org.taomee.utils.DisplayUtil;

public class NonoPreview extends Sprite {


    private var _preview:IconDisplayer;

    private var _equipId:uint;

    public function NonoPreview() {
        super();
        this.initPreviewDisplayer();
    }

    public function dispose():void {
        if (this._preview) {
            this._preview.dispose();
            DisplayUtil.removeForParent(this._preview);
        }
    }

    private function initPreviewDisplayer():void {
        this._preview = new IconDisplayer();
        this.addPreviewVec();
    }

    private function addPreviewVec():void {
        this.updatePreview(ActorManager.getActor().getNono().nonoInfo.equipId);
    }

    public function updatePreview(param1:uint):void {
        var _loc2_:String = null;
        this._equipId = param1;
        DisplayUtil.removeForParent(this._preview);
        if (param1 == 0) {
            this._preview.setIconUrl(URLUtil.getNonoPreviewSwf(ActorManager.getActor().getNono().nonoInfo.getNonoType(ActorManager.actorInfo)));
        } else {
            this._preview.setIconUrl(URLUtil.getNonoPreviewSwf(param1));
        }
        addChild(this._preview);
    }

    public function get equipId():uint {
        return this._equipId;
    }
}
}
