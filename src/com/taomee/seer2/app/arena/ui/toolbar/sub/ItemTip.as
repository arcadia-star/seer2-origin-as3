package com.taomee.seer2.app.arena.ui.toolbar.sub {
import com.taomee.seer2.app.arena.resource.FightUIManager;
import com.taomee.seer2.app.inventory.item.PetItem;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.text.TextField;

public class ItemTip extends Sprite {


    private var _content:MovieClip;

    private var _back:MovieClip;

    private var _nameText:TextField;

    private var _desText:TextField;

    private const TXT_WIDTH:int = 46;

    public function ItemTip() {
        super();
        this.initialize();
    }

    private function initialize():void {
        this.mouseChildren = false;
        this.mouseEnabled = false;
        this.createChildren();
    }

    private function createChildren():void {
        this._content = FightUIManager.getMovieClip("UI_FightItemTip");
        this._back = this._content["back"];
        this._nameText = this._content["txtName"];
        this._desText = this._content["txtDes"];
        this._desText.wordWrap = true;
        this._desText.multiline = true;
        addChild(this._content);
    }

    public function setItemInfo(param1:PetItem):void {
        this._nameText.text = param1.name;
        this._desText.text = param1.tip;
        this._desText.height = this._desText.textHeight + 5;
        this._back.height = this._desText.height + 35;
        this._nameText.y = -1 * this._back.height + 5;
        this._desText.y = -1 * this._back.height + 20;
    }
}
}
