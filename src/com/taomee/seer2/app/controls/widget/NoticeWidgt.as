package com.taomee.seer2.app.controls.widget {
import com.taomee.seer2.app.component.BlockableView;
import com.taomee.seer2.app.notify.NoticeManager;
import com.taomee.seer2.core.ui.UIManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;

public class NoticeWidgt extends BlockableView {


    private var _mainUI:MovieClip;

    private var _countTxt:TextField;

    public function NoticeWidgt() {
        super();
        this._mainUI = UIManager.getMovieClip("UI_NoticeUI");
        this._mainUI.gotoAndStop(1);
        this._countTxt = this._mainUI["txt"];
        mouseChildren = false;
        this.refresh();
        this.mouseChildren = false;
        this.buttonMode = true;
        this.addEventListener(MouseEvent.CLICK, this.onClick);
        NoticeManager.addEventListener(NoticeManager.NEW_NOTICE, this.onNotify);
    }

    private function onNotify(param1:Event):void {
        this.refresh();
    }

    private function onClick(param1:Event):void {
        NoticeManager.shiftNotice().process();
        this.refresh();
    }

    private function refresh():void {
        this._countTxt.text = NoticeManager.getNoticeCount().toString();
        if (NoticeManager.getNoticeCount() > 0) {
            isShow = true;
        } else {
            isShow = false;
        }
    }

    override public function show():void {
        this._mainUI.gotoAndPlay(1);
        addChild(this._mainUI);
    }

    override public function hide():void {
        this._mainUI.gotoAndStop(1);
        DisplayObjectUtil.removeFromParent(this._mainUI);
    }
}
}
