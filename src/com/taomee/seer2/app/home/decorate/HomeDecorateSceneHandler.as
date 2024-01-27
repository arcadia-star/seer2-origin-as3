package com.taomee.seer2.app.home.decorate {
import com.taomee.seer2.app.common.ResourceLibraryLoader;
import com.taomee.seer2.app.home.HomeScene;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.map.ResourceLibrary;
import com.taomee.seer2.core.scene.BaseScene;
import com.taomee.seer2.core.scene.ISceneHandler;
import com.taomee.seer2.core.utils.URLUtil;

public class HomeDecorateSceneHandler implements ISceneHandler {

    private static var _resourceLoader:ResourceLibraryLoader;

    {
        initialize();
    }

    private var _scene:HomeScene;

    private var _decorate:Decorate;

    public function HomeDecorateSceneHandler() {
        super();
    }

    private static function initialize():void {
        _resourceLoader = new ResourceLibraryLoader(URLUtil.getRes("common/home/decorate" + URLUtil.POSTFIX_SWF));
    }

    public function init(param1:BaseScene):void {
        this._scene = param1 as HomeScene;
    }

    public function onMapStart():void {
        _resourceLoader.getLib(this.initDecorate);
    }

    public function onTick(param1:int):void {
    }

    public function onMapEnd():void {
        this.clearDecorate();
    }

    private function initDecorate(param1:ResourceLibrary):void {
        if (QuestManager.isComplete(1)) {
            this._decorate = new Decorate(this._scene.homeInfo.decorateInfo, param1);
        }
    }

    private function clearDecorate():void {
        if (this._decorate) {
            this._decorate.dispose();
        }
        this._decorate = null;
    }

    public function disopse():void {
        this._scene = null;
        this.clearDecorate();
    }
}
}
