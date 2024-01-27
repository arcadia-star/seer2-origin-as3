package com.taomee.seer2.app.scene.preProcessor {
import com.taomee.seer2.app.lobby.setting.LobbyMapSetting;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.QueueLoader;
import com.taomee.seer2.core.scene.SwitchData;
import com.taomee.seer2.core.scene.SwitchPreProcessor;
import com.taomee.seer2.core.utils.URLUtil;

public class LobbyPreProcessor extends SwitchPreProcessor {


    public function LobbyPreProcessor() {
        super();
    }

    override public function process(param1:SwitchData, param2:Function):void {
        _data = param1;
        _callBack = param2;
        if (LobbyMapSetting.isInitialized == true) {
            this.processDayNight();
        } else {
            QueueLoader.load(URLUtil.getMapConfig("setting"), LoadType.TEXT, this.onMapSettingLoaded, null, null, 2, null, null, true);
        }
    }

    private function onMapSettingLoaded(param1:ContentInfo):void {
        LobbyMapSetting.parseSetting(XML(param1.content));
        this.processDayNight();
    }

    private function processDayNight():void {
        var _loc1_:int = int(_data.mapId);
        _data.mapId = LobbyMapSetting.getMapId(_loc1_);
        _data.resourceId = LobbyMapSetting.getResourceId(_loc1_);
        handlerCallBack();
    }
}
}
