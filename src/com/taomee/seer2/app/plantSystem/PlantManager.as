package com.taomee.seer2.app.plantSystem {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.config.SeedConfig;
import com.taomee.seer2.app.inventory.ItemManager;
import com.taomee.seer2.app.inventory.item.SpecialItem;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.plant.PlantScene;
import com.taomee.seer2.app.plant.event.PlantEvent;
import com.taomee.seer2.app.plant.event.PlantEventControl;
import com.taomee.seer2.app.plantSystem.tip.PlantTipManager;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.processor.activity.devilActivity.DevilLoad;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.QueueLoader;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.utils.IDataInput;

import org.taomee.utils.DisplayUtil;

public class PlantManager {

    public static var isShow:Boolean = false;

    public static var _pointList:Vector.<Point>;

    public static var isQuest:Boolean = false;

    public static var isQuest2:Boolean = false;

    public static var isQuest3:Boolean = false;


    private var _mouse:MovieClip;

    private var _landList:Vector.<PlantLand>;

    private var _scene:PlantScene;

    private var _load:DevilLoad;

    private var _item:SpecialItem;

    private var _type:int;

    private var _plantSetInfo:PlantSetInfo;

    private var _index:int;

    private var _removeBtn:MovieClip;

    private var _steal:MovieClip;

    public function PlantManager(param1:Vector.<Point>) {
        super();
        _pointList = param1;
        PlantTipManager.setup();
        this.init();
    }

    private function init():void {
        ActiveCountManager.requestActiveCount(202075, function (param1:uint, param2:uint):void {
            PlantHomeManager.homeLevel = param2;
            if (_load == null) {
                _load = new DevilLoad();
            }
            _load.playLoad("plant/plantLoad", startNext);
            initRemove();
        });
    }

    private function startNext():void {
        this.updateLand();
        PlantEventControl.addEventListener(PlantEvent.SEED_STATUS_CHANGE, this.onSeedStatusChange);
        PlantEventControl.addEventListener(PlantEvent.SELECT_ITEM, this.onSelectItem);
    }

    private function updateLand():void {
        this._landList = Vector.<PlantLand>([]);
        this._scene = SceneManager.active as PlantScene;
        var _loc1_:int = 0;
        while (_loc1_ < 16) {
            this._landList.push(new PlantLand(SceneManager.active.mapModel.content["land" + _loc1_], this._scene.plantInfo.infoList[_loc1_], this._load));
            _loc1_++;
        }
        var _loc2_:int = 0;
        while (_loc2_ < 4) {
            SceneManager.active.mapModel.front["vip" + _loc2_].mouseChildren = false;
            SceneManager.active.mapModel.front["vip" + _loc2_].mouseEnabled = false;
            _loc2_++;
        }
        PlantHomeManager.plantList = this._landList;
        this.updateSteal();
    }

    private function updateSteal():void {
        this._steal = SceneManager.active.mapModel.content["steal"];
        this._steal.addEventListener(MouseEvent.CLICK, this.onSteal);
        this._steal.visible = false;
        if (SceneManager.active.mapID != ActorManager.actorInfo.id) {
            return;
        }
        Connection.addCommandListener(CommandSet.GET_RANKING_LIST_1232, this.onRanking);
        Connection.send(CommandSet.GET_RANKING_LIST_1232, 5, 0);
    }

    private function onRanking(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.GET_RANKING_LIST_1232, this.onRanking);
        var _loc2_:IDataInput = param1.message.getRawData();
        var _loc3_:uint = uint(_loc2_.readUnsignedInt());
        var _loc4_:uint;
        if ((_loc4_ = uint(_loc2_.readUnsignedInt())) != 0) {
            this._steal.visible = true;
        } else {
            this._steal.visible = false;
        }
    }

    private function onSteal(param1:MouseEvent):void {
        this._steal.visible = false;
        ModuleManager.toggleModule(URLUtil.getAppModule("PlantRecordPanel"), "正在打开...");
    }

    private function onSelectItem(param1:PlantEvent):void {
        if (this._mouse) {
            PlantMouse.endSwapMouse();
        }
        this._item = param1.content as SpecialItem;
        this._mouse = PlantMouse.getMouse(this._item);
        LayerManager.stage.addEventListener(MouseEvent.CLICK, this.onClick);
        PlantMouse.startSwapMouse(this._mouse);
        this.isClosePlantMouse(true);
    }

    private function isClosePlantMouse(param1:Boolean):void {
        var _loc2_:PlantLand = null;
        for each(_loc2_ in this._landList) {
            if (param1) {
                _loc2_.closePlantMouse();
            } else {
                _loc2_.openPlantMouse();
            }
        }
    }

    private function onClick(param1:MouseEvent):void {
        var _loc3_:int = 0;
        if (isQuest) {
            return;
        }
        if (isQuest2) {
            if (this._landList[0].mc.hitTestPoint(LayerManager.stage.mouseX, LayerManager.stage.mouseY)) {
                switch (PlantContent.getType(this._item)) {
                    case 0:
                        this.checkSeed(_loc3_);
                        break;
                    case 1:
                        this.checkFruit(_loc3_);
                        break;
                    case 2:
                        this.checkFertilizer(_loc3_);
                }
                return;
            }
            return;
        }
        var _loc2_:Vector.<int> = Vector.<int>([]);
        _loc3_ = 0;
        while (_loc3_ < 16) {
            if (this._landList[_loc3_].mc.hitTestPoint(LayerManager.stage.mouseX, LayerManager.stage.mouseY, true)) {
                _loc2_.push(_loc3_);
            }
            _loc3_++;
        }
        if (_loc2_.length != 0) {
            switch (PlantContent.getType(this._item)) {
                case 0:
                    this.checkSeed(_loc2_[0]);
                    break;
                case 1:
                    this.checkFruit(_loc2_[0]);
                    break;
                case 2:
                    this.checkFertilizer(_loc2_[0]);
            }
            return;
        }
        if (isQuest2) {
            return;
        }
        this.isClosePlantMouse(false);
        this.removeMouse();
    }

    private function onSeedStatusChange(param1:PlantEvent):void {
        var _loc2_:uint = param1.content as uint;
        if (this._landList[_loc2_].info.seedStage == 1) {
            return;
        }
        if (this._landList[_loc2_].info.plantSeedId == 0) {
            return;
        }
        this._landList[_loc2_].statusChange();
    }

    private function onPlantSetInfo(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.PLANT_SET_INFO_1519, this.onPlantSetInfo);
        var _loc2_:IDataInput = param1.message.getRawData();
        this._plantSetInfo = new PlantSetInfo(_loc2_);
        this._type = _loc2_.readUnsignedInt();
        var _loc3_:uint = uint(_loc2_.readUnsignedInt());
        var _loc4_:uint = uint(_loc2_.readUnsignedInt());
        this._landList[_loc4_].info.userId = _loc3_;
        this._landList[_loc4_].info.plantId = _loc4_;
        this._landList[_loc4_].info.parseInfo(_loc2_);
        this._landList[_loc4_].info.seedInfo = SeedConfig.getSeedInfo(this._landList[_loc4_].info.plantSeedId);
        switch (this._type) {
            case 0:
                this.updateSeed();
                break;
            case 1:
                this.updateFruit();
                break;
            case 2:
                this.updateFertilizer();
        }
    }

    private function updateFertilizer():void {
        var animation:MovieClip = null;
        this.isClosePlantMouse(false);
        this.removeMouse();
        this._landList[this._index].setBubble(6);
        animation = this._load.getMC("fertilizerAnimation");
        animation.x = _pointList[this._index].x - 12;
        animation.y = _pointList[this._index].y;
        LayerManager.topLayer.addChild(animation);
        MovieClipUtil.playMc(animation, 2, animation.totalFrames, function ():void {
            DisplayUtil.removeForParent(animation);
            _landList[_index].updateSeed(true);
        }, true);
    }

    private function updateFruit():void {
        var animation:MovieClip = null;
        this.isClosePlantMouse(false);
        this.removeRemoveMouse();
        this._landList[this._index].setBubble(2);
        animation = this._load.getMC("seedRemoveAnimation");
        animation.x = _pointList[this._index].x + 5;
        animation.y = _pointList[this._index].y;
        SceneManager.active.mapModel.content.addChild(animation);
        MovieClipUtil.playMc(animation, 2, animation.totalFrames, function ():void {
            DisplayUtil.removeForParent(animation);
            _landList[_index].removeSeed();
        }, true);
    }

    private function updateSeed():void {
        if (ItemManager.getSpecialItem(this._item.referenceId) == null || ItemManager.getSpecialItem(this._item.referenceId).quantity == 0) {
            this.removeMouse();
        }
        this.isClosePlantMouse(false);
        QueueLoader.load(URLUtil.getRes("plant/seedAnimation/" + this._landList[this._index].info.plantSeedId + ".swf"), LoadType.SWF, this.onUpdateSeedComplete);
    }

    private function onUpdateSeedComplete(param1:ContentInfo):void {
        var animation:MovieClip = null;
        var info:ContentInfo = param1;
        this._landList[this._index].setBubble(1);
        if (this._landList[this._index].info.plantSeedId <= 601020 || this._landList[this._index].info.plantSeedId == 601455 || this._landList[this._index].info.plantSeedId == 601533) {
            animation = info.content as MovieClip;
            animation.x = _pointList[this._index].x;
            animation.y = _pointList[this._index].y;
        } else {
            animation = new (info.domain.getDefinition("item"))();
            animation.x = _pointList[this._index].x;
            animation.y = _pointList[this._index].y;
        }
        LayerManager.topLayer.addChild(animation);
        animation.x -= 1200 - LayerManager.stage.stageWidth;
        animation.y -= 660 - LayerManager.stage.stageHeight;
        MovieClipUtil.playMcList(animation, 2, animation.totalFrames, function (param1:int):void {
            _landList[param1].startSeed();
        }, this._index);
    }

    private function initRemove():void {
        this._removeBtn = SceneManager.active.mapModel.content["removeBtn"];
        if (SceneManager.active.mapID != ActorManager.actorInfo.id) {
            return;
        }
        this._removeBtn.addEventListener(MouseEvent.CLICK, this.onRemove, false, 1);
    }

    private function onRemove(param1:MouseEvent):void {
        if (isQuest) {
            return;
        }
        param1.stopImmediatePropagation();
        if (this._mouse) {
            PlantMouse.endSwapMouse();
        }
        this._mouse = PlantMouse.getRemove();
        LayerManager.stage.addEventListener(MouseEvent.CLICK, this.onClickRemove);
        PlantMouse.startSwapMouse(this._mouse);
        this.isClosePlantMouse(true);
    }

    private function nextSeed(param1:int):void {
        this._index = param1;
        Connection.addCommandListener(CommandSet.PLANT_SET_INFO_1519, this.onPlantSetInfo);
        Connection.send(CommandSet.PLANT_SET_INFO_1519, this._scene.mapID, this._landList[param1].info.plantId, 0, this._item.referenceId, 0);
    }

    private function nextFruit(param1:int):void {
        this._index = param1;
        Connection.addCommandListener(CommandSet.PLANT_SET_INFO_1519, this.onPlantSetInfo);
        Connection.send(CommandSet.PLANT_SET_INFO_1519, this._scene.mapID, this._landList[param1].info.plantId, 1, 0, 0);
    }

    private function nextFertilizer(param1:int):void {
        this._index = param1;
        Connection.addCommandListener(CommandSet.PLANT_SET_INFO_1519, this.onPlantSetInfo);
        Connection.send(CommandSet.PLANT_SET_INFO_1519, this._scene.mapID, this._landList[param1].info.plantId, 2, this._item.referenceId, 0);
    }

    private function checkSeed(param1:int):void {
        if (this._landList[param1].info.plantIsOpen == 0) {
            this.removeMouse();
            this.isClosePlantMouse(false);
            AlertManager.showAlert("这块土地未开放");
            return;
        }
        if (this._landList[param1].info.plantSeedId != 0) {
            this.removeMouse();
            this.isClosePlantMouse(false);
            AlertManager.showAlert("这块土地已有作物");
            return;
        }
        this.nextSeed(param1);
    }

    private function checkFruit(param1:int):void {
        if (this._landList[param1].info.plantIsOpen == 0) {
            this.removeRemoveMouse();
            this.isClosePlantMouse(false);
            AlertManager.showAlert("这块土地未开放");
            return;
        }
        if (this._landList[param1].info.plantSeedId == 0) {
            this.removeRemoveMouse();
            this.isClosePlantMouse(false);
            AlertManager.showAlert("这块土地没有作物");
            return;
        }
        if (this._landList[param1].info.seedStage == 4) {
            this.removeRemoveMouse();
            this.isClosePlantMouse(false);
            AlertManager.showAlert("这个作物已经成熟");
            return;
        }
        this.nextFruit(param1);
    }

    private function checkFertilizer(param1:int):void {
        if (this._landList[param1].info.plantIsOpen == 0) {
            this.removeMouse();
            this.isClosePlantMouse(false);
            AlertManager.showAlert("这块土地未开放");
            return;
        }
        if (this._landList[param1].info.plantSeedId == 0) {
            this.removeMouse();
            this.isClosePlantMouse(false);
            AlertManager.showAlert("这块土地没有作物");
            return;
        }
        if (this._landList[param1].info.seedStage == 4) {
            this.removeMouse();
            this.isClosePlantMouse(false);
            AlertManager.showAlert("这个作物已经成熟");
            return;
        }
        if (this._landList[param1].info.fertilizer >= 1) {
            this.removeMouse();
            this.isClosePlantMouse(false);
            AlertManager.showAlert("这个作物已经施过肥");
            return;
        }
        this.nextFertilizer(param1);
    }

    private function removeMouse():void {
        LayerManager.stage.removeEventListener(MouseEvent.CLICK, this.onClick);
        PlantMouse.endSwapMouse();
    }

    private function removeRemoveMouse():void {
        LayerManager.stage.removeEventListener(MouseEvent.CLICK, this.onClickRemove);
        PlantMouse.endSwapMouse();
    }

    private function onClickRemove(param1:MouseEvent):void {
        var _loc2_:Vector.<int> = Vector.<int>([]);
        var _loc3_:int = 0;
        while (_loc3_ < 16) {
            if (this._landList[_loc3_].mc.hitTestPoint(LayerManager.stage.mouseX, LayerManager.stage.mouseY, true)) {
                _loc2_.push(_loc3_);
            }
            _loc3_++;
        }
        if (_loc2_.length != 0) {
            this.checkFruit(_loc2_[0]);
            return;
        }
        this.isClosePlantMouse(false);
        this.removeRemoveMouse();
    }

    public function dispose():void {
        var _loc1_:PlantLand = null;
        if (this._load) {
            this._load.dispose();
        }
        if (this._removeBtn) {
            this._removeBtn.removeEventListener(MouseEvent.CLICK, this.onRemove);
        }
        Connection.removeCommandListener(CommandSet.GET_RANKING_LIST_1232, this.onRanking);
        Connection.removeCommandListener(CommandSet.PLANT_SET_INFO_1519, this.onPlantSetInfo);
        PlantEventControl.removeEventListener(PlantEvent.SEED_STATUS_CHANGE, this.onSeedStatusChange);
        PlantEventControl.removeEventListener(PlantEvent.SELECT_ITEM, this.onSelectItem);
        this.removeMouse();
        this.removeRemoveMouse();
        for each(_loc1_ in this._landList) {
            _loc1_.dispose();
        }
    }
}
}
