package com.taomee.seer2.core.scene {
import com.taomee.seer2.core.entity.AnimateElementManager;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.net.message.IMessageHandler;
import com.taomee.seer2.core.utils.effect.EffectShake;

import org.taomee.utils.DisplayUtil;
import org.taomee.utils.Tick;

public class BaseScene {


    private var _type:int;

    private var _mapModel:MapModel;

    private var _messageGateWay:MessageGateWay;

    private var _sceneHandlerGateWay:SceneHandlerGateWay;

    public function BaseScene(param1:int) {
        super();
        this._type = param1;
    }

    public function init():void {
        MobileManager.initialize(this);
        AnimateElementManager.initialize(this);
        this._messageGateWay = SceneTypeFactory.createMessageGateWay(this);
        this._sceneHandlerGateWay = SceneTypeFactory.createSceneHandlerGateWay(this);
    }

    public function updateMap(param1:MapModel):void {
        if (this._mapModel != null) {
            this.clearScene();
        }
        this.switchMap(param1);
        this.updateScene();
        this.syncToServer();
    }

    protected function clearScene():void {
        MobileManager.clearAll();
        AnimateElementManager.clearAll();
        DisplayUtil.removeAllChild(LayerManager.mapLayer);
        Tick.instance.removeRender(this.onTick);
    }

    private function switchMap(param1:MapModel):void {
        if (this._mapModel) {
            this._mapModel.dispose();
            this._sceneHandlerGateWay.onMapEnd();
        }
        this._mapModel = param1;
        this._mapModel.init();
    }

    protected function updateScene():void {
        LayerManager.mapLayer.addChild(this._mapModel.far);
        LayerManager.mapLayer.addChild(this._mapModel.ground);
        LayerManager.mapLayer.addChild(this._mapModel.content);
        LayerManager.mapLayer.addChild(this._mapModel.front);
        Tick.instance.addRender(this.onTick);
    }

    protected function syncToServer():void {
    }

    protected function onTick(param1:int):void {
        MobileManager.update();
        AnimateElementManager.update();
        this._sceneHandlerGateWay.onTick(param1);
        EffectShake.update();
    }

    protected function completeMap():void {
        this._mapModel.complete();
        this._sceneHandlerGateWay.onMapStart();
    }

    public function dispose():void {
        this.clearScene();
        this._messageGateWay.dispose();
        this._sceneHandlerGateWay.disopse();
        this._mapModel.dispose();
        this._mapModel = null;
    }

    public function addMessageHandler(param1:IMessageHandler):void {
        this._messageGateWay.addMessageHandler(param1);
    }

    public function addSceneHandler(param1:ISceneHandler):void {
        this._sceneHandlerGateWay.addSceneHandler(param1);
    }

    public function get type():int {
        return this._type;
    }

    public function get mapModel():MapModel {
        return this._mapModel;
    }

    public function get mapID():int {
        return this._mapModel.id;
    }

    public function get mapCategoryID():int {
        return this._mapModel.categoryId;
    }

    public function get mapResourceID():int {
        return this._mapModel.resourceId;
    }

    public function get fightMapId():int {
        return this._mapModel.fightMapId;
    }
}
}
