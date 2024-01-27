package com.taomee.seer2.app.home.garbage {
import com.taomee.seer2.app.common.ResourceLibraryLoader;
import com.taomee.seer2.app.home.HomeScene;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.map.ResourceLibrary;
import com.taomee.seer2.core.scene.BaseScene;
import com.taomee.seer2.core.scene.ISceneHandler;
import com.taomee.seer2.core.utils.URLUtil;

public class HomeGarbageSceneHandler implements ISceneHandler {

    private static var _resourceLoader:ResourceLibraryLoader;

    {
        staticInit();
    }

    private var _garbageContainer:HomeGarbageContainer;

    private var _scene:HomeScene;

    public function HomeGarbageSceneHandler() {
        super();
    }

    private static function staticInit():void {
        _resourceLoader = new ResourceLibraryLoader(URLUtil.getRes("common/home/garbage" + URLUtil.POSTFIX_SWF));
    }

    public function init(param1:BaseScene):void {
        this._scene = param1 as HomeScene;
        this._garbageContainer = new HomeGarbageContainer();
    }

    public function onMapStart():void {
        if (QuestManager.isFreshQuestComplete()) {
            _resourceLoader.getLib(this.handlerGarbage);
        }
    }

    public function onTick(param1:int):void {
    }

    public function onMapEnd():void {
        if (QuestManager.isFreshQuestComplete()) {
            _resourceLoader.cancel();
            this._garbageContainer.clearGarbage();
        }
    }

    private function handlerGarbage(param1:ResourceLibrary):void {
        this._garbageContainer.fillGarbage(this._scene, this._scene.mapModel, param1);
    }

    public function disopse():void {
        this._garbageContainer.dispose();
        this._garbageContainer = null;
        this._scene = null;
    }
}
}
