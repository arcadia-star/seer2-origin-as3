package com.taomee.seer2.core.ui.toolTip.tipSkins {
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.ui.UIManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import seer2.next.utils.TextUtils;

public class SkillTipSkin extends BaseTipSkin {


    private var _nameTxt:TextField;

    private var _descriptionTxt:TextField;

    private var _data:Object;

    public function SkillTipSkin() {
        super();
        this.initialize();
    }

    private function initialize():void {
        _tipSkin = UIManager.getMovieClip("UI_SkillTooltip");
        _tipSkin.x = 10;
        _tipSkin.y = 20;
        addChild(_tipSkin);
        _back = _tipSkin["back"];
        this._nameTxt = _tipSkin["itemName"];
        this._descriptionTxt = _tipSkin["description"];
        this._descriptionTxt.autoSize = TextFieldAutoSize.LEFT;
        this._descriptionTxt.width = 160;
        this._descriptionTxt.wordWrap = true;
        DisplayObjectUtil.disableSprite(this);
    }

    override public function setData(param1:Object):void {
        this._data = param1;
        if (this._data) {
            this._nameTxt.text = param1.name;
            this._descriptionTxt.htmlText = TextUtils.replaceColorFormat(param1.description);
            _back.width = this._descriptionTxt.width + 10;
            _back.height = this._descriptionTxt.height + 50;
        }
    }

    override public function show(param1:String):void {
        LayerManager.topLayer.addChild(this);
        if (this._data == null) {
            this.visible = false;
        } else {
            this.visible = true;
        }
    }
}
}
