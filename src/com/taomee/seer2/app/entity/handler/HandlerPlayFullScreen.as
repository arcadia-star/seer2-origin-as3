package com.taomee.seer2.app.entity.handler {
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.utils.URLUtil;

public class HandlerPlayFullScreen extends HandlerEntityClick {


    private var _fullScreenName:String;

    public function HandlerPlayFullScreen() {
        super();
    }

    override public function initData(param1:XML):void {
        this._fullScreenName = param1.toString();
    }

    override protected function action():void {
        MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen(this._fullScreenName), null, true, false, 2);
    }
}
}
