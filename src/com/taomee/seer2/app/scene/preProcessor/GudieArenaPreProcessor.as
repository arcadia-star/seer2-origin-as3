package com.taomee.seer2.app.scene.preProcessor {
import com.taomee.seer2.app.arena.resource.FightUIManager;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.UILoader;
import com.taomee.seer2.core.scene.SwitchData;
import com.taomee.seer2.core.scene.SwitchPreProcessor;
import com.taomee.seer2.core.utils.URLUtil;

public class GudieArenaPreProcessor extends SwitchPreProcessor {


    public function GudieArenaPreProcessor() {
        super();
    }

    override public function process(param1:SwitchData, param2:Function):void {
        _data = param1;
        _callBack = param2;
        if (!FightUIManager.initialized) {
            UILoader.load(URLUtil.getUISwf("UI_Arena"), LoadType.DOMAIN, this.onFightUILoaded);
        } else {
            this.handlerCallBack();
        }
    }

    private function onFightUILoaded(param1:ContentInfo):void {
        FightUIManager.setup(param1.content);
        this.handlerCallBack();
    }

    override protected function handlerCallBack():void {
        super.handlerCallBack();
    }
}
}
